---
imports:
    - python/pip/torch
---

# Ray Train with PyTorch

This example shows how you can use Ray Train with PyTorch.

```python
---
exec: ray-submit --job-id ${JOB_ID}
---
# First, set up your dataset and model.
--8<-- "./nn.py"

# Now define your single-worker PyTorch training function.
--8<-- "./train_func.py"
# FYI: This training function can be executed with:
#     train_func()

# Now let’s convert this to a distributed multi-worker training function!
# All you have to do is use the ray.train.torch.prepare_model and ray.train.torch.prepare_data_loader utility functions to easily setup your model & data for distributed training. This will automatically wrap your model with DistributedDataParallel and place it on the right device, and add DistributedSampler to your DataLoaders.
--8<-- "./train_func_distributed.py"

# Then, instantiate a Trainer that uses a "torch" backend with 4 workers, and use it to run the new training function!
--8<-- "./trainer.py"
```
