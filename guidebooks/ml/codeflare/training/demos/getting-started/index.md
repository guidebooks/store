---
imports:
    - util/jobid
    - ml/ray/start
---

# Simple Training Demo

This quickstart will show how to quickly get started with submitting distributed training jobs in CodeFlare.


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
export JOB_NAME=GettingStartedDemo
```

```python
---
exec: ray-submit --job-id ${JOB_ID}
---
--8<-- "./main.py"
```
