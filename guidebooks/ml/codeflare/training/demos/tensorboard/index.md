---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ml/ray/start
---

# Simple Training Demo that uses Tensorboard

This quickstart will show how to quickly get started with TensorBoard. Using the [MNIST](https://en.wikipedia.org/wiki/MNIST_database) dataset as the example, normalize the data and write a function that creates a simple Keras model for classifying the images into 10 classes.


## Install Python Packages

```shell
---
exec: pip-install
---
--8<-- "./requirements.txt"
```

## Run it

Submit the job.

```shell
export JOB_NAME=TensorboardDemo
```

```shell
export TB_LOGDIR="s3://${S3_BUCKETRAYLOGS}/tensorboard/${JOB_ID}"
```

```python
---
exec: ray-submit --job-id ${JOB_ID}
---
--8<-- "./main.py"
```
