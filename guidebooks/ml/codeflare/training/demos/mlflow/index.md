---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ml/mlflow/start
    - ml/ray/start
---

# Simple Training Demo that uses MLFlow

Trains an [MNIST](https://en.wikipedia.org/wiki/MNIST_database) digit recognizer using PyTorch Lightning, and uses
Mlflow to log metrics, params and artifacts.

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
export JOB_NAME=MLFlowDemo
```

```python
---
exec: ray-submit --job-id ${JOB_ID}
---
--8<-- "./main.py"
```
