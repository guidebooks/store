---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ml/ray/start
---

# Distributed Language Modeling with BERT

This demo contains code for pre-training a bare-bones BERT model on the Masked Language Modeling (MLM) task, using Ray for distribution on OpenShift. We will be using a pre-tokenized version of Wikitext-103, a small dataset mainly for functional tests. This code is based off the HuggingFace BERT demo, but is free of all dependencies.

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
export JOB_NAME=BERT
```

```shell
export TB_LOGDIR="${LOGDIR_URI}/tensorboard/"
```

```python
---
exec: ray-submit --job-id ${JOB_ID} --no-wait -- -v --datapath /tmp/ --modelpath /tmp/ --logpath /tmp/ --tblogpath "${TB_LOGDIR}" --num_workers ${NUM_GPUs-${NUM_CPUS-1}} ${GPU_OPTION}
---
--8<-- "./ray-bert-vanilla.py"
```

--8<-- "ml/tensorflow/tensorboard/run"
--8<-- "ml/ray/run/logs"
