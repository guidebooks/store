# Local dependency

import torch
import torch.nn as nn
import math
import torch.nn.functional as F
import time
import pathlib

import requests
from io import BytesIO
from os.path import exists, join
from os import environ
import torch.utils.data as data
torch.manual_seed(42)
torch.cuda.manual_seed_all(42)

import ray
import ray.train as train
from ray.train import Trainer

import tensorflow.summary as summary

import argparse
import importlib

parser = argparse.ArgumentParser(description='BERT on WikiText-103 with Ray Train for OPC (now with TensorBoard!)')
parser.add_argument('--num_workers', type=int, default=1, help='Number of workers to use for training')
parser.add_argument('--gpu_size', type=int, default=16, help='GPU memory size in gigabytes')
parser.add_argument('--num_epochs', type=int, default=5, help='Number of passes over the dataset')
parser.add_argument('--datapath', type=str, default='/home/ray/bert/', help='Absolute path to dataset directory')
parser.add_argument('--modelpath', type=str, default='/home/ray/bert/', help='Absolute path to model save location. Must be accessible to head node.')
parser.add_argument('--logpath', type=str, default='/home/ray/bert/', help='Absolute path to log save location. Must be accessible to each worker node.')
parser.add_argument('--tblogpath', type=str, default='/home/ray/bert/', help='Absolute path to tensorboard log location. Must be accessible to each worker node.')
args = parser.parse_args()

# Create the tensorboard log directory structure in advance, so that
# any remote rsyncs won't try to fetch from a non-existent directory
#pathlib.Path(args.logpath).mkdir(parents=True, exist_ok=True)
print(f"Logging tensorboard to {args.tblogpath}")

ray.init(address="auto")

# For now, changing other hyperparameters will require changing the hardcoded constants in the code below

# Fetch pre-tokenized dataset

dpath = args.datapath+'wikitext-v103-tokenized.pth'
if not exists(dpath):
    print("Retrieving tokenized dataset from Box...")
    url = 'https://ibm.box.com/shared/static/foiewtjjleqn9koiy5531evma8nfhvj9.pth'
    wikiset = BytesIO(requests.get(url).content)
    wikiset = torch.load(wikiset)
    torch.save(wikiset, dpath)
else:
    print("Retrieving tokenized dataset locally...")
    wikiset = torch.load(dpath)
print("Dataset retrieved!")



# Define the model

class EmbedLayer(nn.Module):
    def __init__(self, d, vocab, max_pos, pad_id):
        super().__init__()
        self.word_e = nn.Embedding(vocab, d, padding_idx = pad_id)
        self.pos_e = nn.Embedding(max_pos, d)
        self.ln = nn.LayerNorm(d)
        self.dropout = nn.Dropout(.1)
        self.register_buffer('pos_id', torch.arange(max_pos).unsqueeze(0))

    def forward(self, inp):
        # inp: b n
        pos = self.pos_id[:,:inp.size(1)]
        out = self.word_e(inp) + self.pos_e(pos)
        return self.dropout(self.ln(out))

class AttnLayer(nn.Module):
    def __init__(self, d, nheads, growfactor, FRN):
        super().__init__()
        assert d/nheads == d//nheads, "Error: n_channels must be divisible by n_heads"
        self.d_small = d//nheads
        self.d = d
        self.nheads = nheads
        self.frn = FRN

        self.k = nn.Linear(d, d)
        self.q = nn.Linear(d, d)
        self.v = nn.Linear(d, d)
        self.fc = nn.Linear(d, d)
        self.attn_dropout = nn.Dropout(.1)
        self.dropout = nn.Dropout(.1)
        self.ln = nn.LayerNorm(d,elementwise_affine=False)

        self.resblock = nn.Sequential(
            nn.Linear(d, d*growfactor),
            nn.GELU(),
            nn.Linear(d*growfactor, d),
            nn.Dropout(.1)
        )
        self.ln2 = nn.LayerNorm(d,elementwise_affine=False)

    def forward(self, inp):
        # inp: b n d
        s = inp.size()
        k = self.k(inp).view(*s[:2],self.nheads,self.d_small).permute(0,2,3,1) # b h d' n
        q = self.q(inp).view(*s[:2],self.nheads,self.d_small).permute(0,2,1,3) # b h n d'
        v = self.v(inp).view(*s[:2],self.nheads,self.d_small).permute(0,2,1,3) # b h n d'

        attn = q.matmul(k).div(math.sqrt(self.d_small)) # b h n n
        attn = (F.softmax(attn, 3) if not self.frn else
                F.normalize(attn.view(s[0], self.nheads, -1), p=2, dim=2).view(*attn.size()))
        attn = self.attn_dropout(attn) # b h n n

        out = attn.matmul(v).permute(0,2,1,3).contiguous().view(s) # b n d
        out = self.dropout(self.fc(out))
        out = self.ln(out+inp)

        return self.ln2(self.resblock(out)+out)

class BertEncoder(nn.Module):
    def __init__(self, nlayers=12, d=768, nheads=12, growfactor=4, vocab=25000, max_pos=128, pad_id=0, FRN=False):
        super().__init__()
        self.embed = EmbedLayer(d, vocab, max_pos, pad_id)
        self.process = nn.Sequential(*[AttnLayer(d,nheads,growfactor,FRN) for _ in range(nlayers)])
        self.outbias = nn.Parameter(torch.zeros(vocab))
        self.embedlayer = self.embed.word_e.weight

        self.vocab = vocab
        self.d = d

        self.reset_params()

    def reset_params(self):
        for module in self.modules():
            if isinstance(module, nn.Linear):
                module.weight.data.normal_(0,.5/math.sqrt(self.d))
                if module.bias is not None:
                    module.bias.data.zero_()
            elif isinstance(module, nn.Embedding):
                module.weight.data.normal_(0,.5/math.sqrt(self.d))
                if module.padding_idx is not None:
                    module.weight.data[module.padding_idx].zero_()

    def encode(self, inp):
        return self.process(inp)

    def forward(self, inp, inds):
        embeds = self.embed(inp)
        preds = self.process(embeds).view(-1,self.d)[inds]
        preds = preds.matmul(self.embedlayer.t()) + self.outbias
        return preds



# Wrappers for custom HuggingFace functionality

# Wrapper for the tokenized dataset that sets labels as masked-off inputs
class MLM_Dataset(data.Dataset):
    def __init__(self, data, vocab, token):
        self.data = data
        self.masktoken = token
        self.vsize = len(vocab)
    def __getitem__(self, i):
        inp = self.data[i].clone()
        labels = self.data[i].clone()
        inp,labels = mask_off(inp, labels, self.masktoken, self.vsize)
        return (inp,labels)
    def __len__(self):
        return self.data.size(0)

# Masking logic
def rand_mask(x, prob):
    return torch.bernoulli(torch.full(x.shape, prob)).bool().to(x.device)

# MLM-specific masking logic, following HuggingFace
def mask_off(inp,labels,token,vsize):
    mask_out = rand_mask(inp,.15)
    labels[~mask_out] = -100 # PyTorch's default [IGNORE] index
    mask_in = rand_mask(inp,.8)&mask_out
    inp[mask_in] = token
    mask_rand = rand_mask(inp,.5)&mask_out&~mask_in
    inp[mask_rand] = torch.randint(vsize, [mask_rand.sum(),]).to(inp.device)
    return inp, labels

# Used for zeroing out weight decay in bias terms only
def get_parameter_names(model, ignore):
    result = []
    for name, child in model.named_children():
        result += [f"{name}.{n}" for n in get_parameter_names(child, ignore)
                   if not isinstance(child, tuple(ignore))]
    result += list(model._parameters.keys())
    return result


# Training loop

def train_func(config):
    dataset = config["data"]

    # Create a tensorboard writer. use args.logpath/jobid, if we have a jobid
    tfio = importlib.import_module("tensorflow_io")
    tb_logpath = join(args.tblogpath, f'gpu_{train.world_rank()}/')
    writer = summary.create_file_writer(tb_logpath)

    # Model
    model = BertEncoder(vocab=150000)
    print("Model created! %d parameters in core network."%sum([p.numel() for p in
                                                               model.parameters()]))
    model = train.torch.prepare_model(model)
    loss_fn = torch.nn.CrossEntropyLoss()

    # Data
    bsize = int(64*args.gpu_size/16)
    masktoken = dataset["key"].index("[MASK]") #tokenizer.encode("[MASK]")[1]
    train_loader = data.DataLoader(MLM_Dataset(torch.LongTensor(dataset["train"]), dataset["key"], masktoken),
                                   batch_size=bsize, shuffle=True)
    val_loader = data.DataLoader(MLM_Dataset(torch.LongTensor(dataset["validation"]), dataset["key"], masktoken),
                                 batch_size=bsize, shuffle=False)
    train_loader = train.torch.prepare_data_loader(train_loader)
    val_loader = train.torch.prepare_data_loader(val_loader)
    print(f"Effective batch size is {bsize*train.world_size()}")

    # Optimizers
    num_epochs = args.num_epochs
    decayers = [name for name in get_parameter_names(model, (nn.LayerNorm,)) if "bias" not in name]
    optimizer = torch.optim.AdamW([{"params":[p for n,p in model.named_parameters() if n in decayers],
                                    "weight_decay": .01},
                                   {"params":[p for n,p in model.named_parameters() if n not in decayers],
                                    "weight_decay": 0}],
                                  lr=5e-5*(2*math.sqrt(args.num_workers*args.gpu_size/16)-1)) # a compromise between linear and
                                                                                         # sqrt scaling. May break for gpus>16
    scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, len(train_loader)*num_epochs)

    # Train
    print("Beginning training!")
    tb_step = 0
    for epoch in range(num_epochs):
        losstracker = 0
        trackertracker = 0
        start = time.time()
        for it, (inp, labels) in enumerate(train_loader):

            inds = torch.nonzero(labels.view(-1)+100).squeeze(1) # -100 is the [IGNORE] index
            optimizer.zero_grad()
            pred = model(inp, inds)
            loss = loss_fn(pred, labels.view(-1)[inds])
            loss.backward()
            nn.utils.clip_grad_norm_(model.parameters(),1/math.sqrt(4*args.num_workers*args.gpu_size/16))
            optimizer.step()
            scheduler.step()
            losstracker += loss.item()
            trackertracker += 1

            if it%(len(train_loader)//10) == len(train_loader)//10 - 1:
                print("Iteration %d/%d of epoch %d/%d reached: train loss is %.2f (%.2f sec/iter)"%
                      (it+1,len(train_loader),epoch+1,num_epochs,losstracker/trackertracker,(time.time()-start)/trackertracker))
                with writer.as_default():
                    summary.scalar("Train_loss_gpu_"+str(train.world_rank()), losstracker/trackertracker, step = tb_step)
                tb_step += 1
                losstracker = 0
                trackertracker = 0
                start = time.time()

        model.eval()
        losstracker = 0
        for inp, labels in val_loader:
            with torch.no_grad():
                inds = torch.nonzero(labels.view(-1)+100).squeeze(1)
                pred = model(inp, inds)
                loss = loss_fn(pred, labels.view(-1)[inds])
            losstracker += loss.item()
        model.train()
        print("Epoch %d: validation loss is %.2f"%(epoch+1, losstracker/len(val_loader)))
        with writer.as_default():
            summary.scalar("Val_loss_gpu_"+str(train.world_rank()), losstracker/len(val_loader), step = tb_step)

    return model.cpu().state_dict() if train.world_rank()==0 else None # Avoid duplicating models
        


# DO THE THING!

start = time.time()
num_gpus = int(environ.get("NUM_GPUS")) if "NUM_GPUS" in environ else 0
trainer = Trainer(backend="torch", num_workers=args.num_workers, use_gpu=num_gpus > 0,
                  logdir=args.logpath)
trainer.start()
states = trainer.run(train_func, config={"data":wikiset})
for state in states: # Pick out the single non-duplicated model
    if state is not None:
        break
print("Saving model...")
torch.save({k[7:]:state[k] for k in state}, args.modelpath+"bert_mlm_baseline_scale.pth")
trainer.shutdown()

print("Training Complete!")
print()
print("Distributed training took only %.2f hours!"%((time.time()-start)/3600))

