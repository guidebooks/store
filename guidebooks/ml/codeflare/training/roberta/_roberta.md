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
export ML_CODEFLARE_ROBERTA_BRANCH=${ML_CODEFLARE_ROBERTA_BRANCH-0-0-2}
```

```shell
export ML_CODEFLARE_ROBERTA_SUBDIR=${ML_CODEFLARE_ROBERTA_SUBDIR-src}
```

Clone the code.
```shell
--8<-- "./clone.sh"
```

Inject our wrapper script
```shell
cat << EOF > "${ML_CODEFLARE_ROBERTA_WORKDIR}/$ML_CODEFLARE_ROBERTA_REPO/$ML_CODEFLARE_ROBERTA_SUBDIR/main.py"
--8<-- "./fetch.py"
EOF
```

```shell
export ML_CODEFLARE_MAIN=nlp/pretraining/train_roberta-torchnative.py
```

## Submit a Ray Job

```shell
---
exec: ray-submit --no-input --job-id ${JOB_ID} --working-dir="${ML_CODEFLARE_ROBERTA_WORKDIR}/$ML_CODEFLARE_ROBERTA_REPO/$ML_CODEFLARE_ROBERTA_SUBDIR" --entrypoint main.py -- ${GUIDEBOOK_DASHDASH}
---
```

exec: ray-submit --no-input --job-id ${JOB_ID} --working-dir=${ML_CODEFLARE_ROBERTA_WORKDIR} -- bash -c "chmod +x main.sh && ./main.sh --gpus=$((${MAX_WORKERS} * ${NUM_GPUS})) ${GUIDEBOOK_DASHDASH}"

GOOD: exec: ray-submit --no-input --job-id ${JOB_ID} --working-dir="${ML_CODEFLARE_ROBERTA_WORKDIR}/$ML_CODEFLARE_ROBERTA_REPO/$ML_CODEFLARE_ROBERTA_SUBDIR" --entrypoint nlp/pretraining/train_roberta-torchnative.py -- --datapath $ML_CODEFLARE_ROBERTA_DATAPATH --simulated_gpus 8 --b_size 64 ${GUIDEBOOK_DASHDASH}
