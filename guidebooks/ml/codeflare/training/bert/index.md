---
imports:
    - ml/ray/start
    - util/jobid
---

# Distributed Language Modeling with BERT

This demo contains code for pre-training a bare-bones BERT model on the Masked Language Modeling (MLM) task, using Ray for distribution on OpenShift. We will be using a pre-tokenized version of Wikitext-103, a small dataset mainly for functional tests. This code is based off the HuggingFace BERT demo, but is free of all dependencies.

## Install Python Packages

```shell
---
exec: pip-install
---
--8<-- "./pip.txt"
```

## Run it

Submit the job.

```shell
export JOB_NAME=BERT
```

```shell
export TB_LOGDIR=/tmp/tensorboard/${JOB_ID}
```

```python
---
exec: ray-submit --job-id ${JOB_ID} --no-wait -- --datapath /tmp/ --modelpath /tmp/ --logpath ${TB_LOGDIR} --num_workers ${NUM_GPUs-${NUM_CPUS-1}} ${GPU_OPTION}
---
--8<-- "./ray-bert-vanilla.py"
```

--8<-- "ml/tensorflow/tensorboard/rsync"
--8<-- "ml/tensorflow/tensorboard/run"

--8<-- "ml/ray/run/logs"
