---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ml/ray/start
    - ./choose-model.md
    - ./choose-glue-data.md
---

<!--    - ../../../../s3/create/kubernetes/secret-if-needed.md -->

# The General Language Understanding Evaluation (GLUE) benchmark

The General Language Understanding Evaluation (GLUE) benchmark is a collection of resources for training, evaluating, and analyzing natural language understanding systems. GLUE consists of:

- A benchmark of nine sentence- or sentence-pair language understanding tasks built on established existing datasets and selected to cover a diverse range of dataset sizes, text genres, and degrees of difficulty,
- A diagnostic dataset designed to evaluate and analyze model performance with respect to a wide range of linguistic phenomena found in natural language, and
- A public leaderboard for tracking performance on the benchmark and a dashboard for visualizing the performance of models on the diagnostic set.

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
export WANDB_CONFIG_DIR=/tmp
```

```shell
export WANDB_DISABLED=true
```

```python
---
exec: ray-submit --job-id ${JOB_ID} -- -v -b ${S3_BUCKET} -m ${S3_OBJECTMODEL} -g ${S3_OBJECTGLUEDATA} -t WNLI -M -s 40 41 42 43 ${GUIDEBOOK_DASHDASH}
---
--8<-- "./glue_benchmark.py"
```

