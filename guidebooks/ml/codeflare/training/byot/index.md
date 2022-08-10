---
imports:
    - util/jobid
    - ./working-directory.md
    - ./base-ray-image.md
    - s3/choose/instance-maybe
    - ml/ray/run/logs/init.md
    - ml/ray/start
---

# Bring Your Own Code

This path provides a way for you to run your own custom code on a remote ray cluster.

## Run it

Submit the job.

```shell
export JOB_NAME=BYOC
```

```shell
---
exec: ray-submit --job-id ${JOB_ID} --working-dir=${CUSTOM_WORKING_DIR} --base-image=${RAY_IMAGE} --entrypoint=main.py -- ${GUIDEBOOK_DASHDASH}
---
```
