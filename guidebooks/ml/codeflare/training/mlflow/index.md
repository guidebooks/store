---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ml/mlflow/start
    - ml/ray/start
---

# Simple Training Example that uses MLFlow

Trains an MNIST digit recognizer using PyTorch Lightning, and uses
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
export JOB_NAME=MLFlowExample
```

```python
---
exec: ray-submit --job-id ${JOB_ID} --no-wait
---
--8<-- "./main.py"
```

--8<-- "ml/ray/run/logs"
