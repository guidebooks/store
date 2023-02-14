# Submit a Ray Job

```shell
---
exec: ray-submit --no-input --job-id ${JOB_ID} --working-dir=${ML_CODEFLARE_ROBERTA_WORKDIR} -- bash -c "chmod +x main.sh && ./main.sh --gpus=$((${MAX_WORKERS} * ${NUM_GPUS})) ${GUIDEBOOK_DASHDASH}"
---
```
