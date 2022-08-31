---
imports:
    - util/jobid
    - ml/ray/start
---

# Pre-Train a RoBERTa Language Model from Pre-tokenized Data

The
[RoBERTa](https://huggingface.co/docs/transformers/model_doc/roberta)
model architecture is a robustly optimized method for pretraining
natural language processing (NLP) systems.

## Dependencies

```shell
---
exec: pip-install
---
--8<-- "./requirements.txt"
```

## Configure the Working Directory

Create a staging directory for the clone of the Ray Helm chart.
```shell
export ML_CODEFLARE_ROBERTA_WORKDIR=$(mktemp -d)
```

```shell
export ML_CODEFLARE_ROBERTA_GITHUB=${ML_CODEFLARE_ROBERTA_GITHUB-github.ibm.com}
```

```shell
export ML_CODEFLARE_ROBERTA_ORG=${ML_CODEFLARE_ROBERTA_ORG-ai-foundation}
```

```shell
export ML_CODEFLARE_ROBERTA_REPO=${ML_CODEFLARE_ROBERTA_REPO-foundation-model-stack}
```

```shell
export ML_CODEFLARE_ROBERTA_BRANCH=${ML_CODEFLARE_ROBERTA_BRANCH-0-0-x}
```

```shell
export ML_CODEFLARE_ROBERTA_SUBDIR=${ML_CODEFLARE_ROBERTA_SUBDIR-RoBERTa/training}
```

Clone the code.
```shell
--8<-- "./clone.sh"
```

Inject our wrapper script
```shell
--8<-- "./wrapper.sh"
```


## Submit a Ray Job

```shell
---
exec: ray-submit --no-input --job-id ${JOB_ID} --working-dir=${ML_CODEFLARE_ROBERTA_WORKDIR} -- bash -c "chmod +x main.sh && ./main.sh --gpus=$((${MAX_WORKERS} * ${NUM_GPUS})) ${GUIDEBOOK_DASHDASH}"
---
```
