## Run it

Submit the job.

```shell
export WANDB_CONFIG_DIR=/tmp
```

```shell
export WANDB_DISABLED=true
```

```shell
---
exec: ray-submit --job-id ${JOB_ID} --working-dir=${CUSTOM_WORKING_DIR} --entrypoint=main.py -- ${GUIDEBOOK_DASHDASH} -- -v -b ${S3_BUCKET} -m ${S3_OBJECTMODEL} -g ${S3_OBJECTGLUEDATA} -t WNLI -M -s 40 41 42 43 ${GUIDEBOOK_DASHDASH}
---

