from ray.train import Trainer

trainer = Trainer(backend="torch", num_workers=4)

# For GPU Training, set `use_gpu` to True.
# trainer = Trainer(backend="torch", num_workers=4, use_gpu=True)

trainer.start()
results = trainer.run(train_func_distributed)
trainer.shutdown()
