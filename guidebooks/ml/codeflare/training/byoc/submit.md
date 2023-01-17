# Run it

Submit a bring-your-own job.

```shell
export JOB_NAME=BYOC
```

```shell
---
exec: ray-submit --job-id ${JOB_ID} --working-dir=${CUSTOM_WORKING_DIR} --base-image=${RAY_IMAGE} --entrypoint=main.py -- ${GUIDEBOOK_DASHDASH}
---
```
