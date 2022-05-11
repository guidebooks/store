---
imports:
    - ../../../../python/conda/install.md
    - ../../../ray/install/index.md
---

# Distributed Language Modeling with BERT

This demo contains code for pre-training a bare-bones BERT model on the Masked Language Modeling (MLM) task, using Ray for distribution on OpenShift. We will be using a pre-tokenized version of Wikitext-103, a small dataset mainly for functional tests. This code is based off the HuggingFace BERT demo, but is free of all dependencies.

## Set up your Python Environment

```shell
---
validate: conda env list | grep ml.codeflare.training.bert
---
conda env create --name ml.codeflare.training.bert -f https://raw.githubusercontent.com/guidebooks/store/main/guidebooks/ml/codeflare/training/bert/raybert_environment.yml
```

## Run it

```shell
---
validate: [ -f ray-bert-vanilla.py ]
---
curl -LO https://raw.githubusercontent.com/guidebooks/store/main/guidebooks/ml/codeflare/tr\
aining/bert/ray-bert-vanilla.py
```

```shell
conda run -n ml.codeflare.training.bert python -u ray-bert-vanilla.py
```