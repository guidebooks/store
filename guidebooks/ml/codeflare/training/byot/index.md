---
imports:
    - util/jobid
    - ./working-directory.md
    - ./base-ray-image.md
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
exec: ray-submit --job-id ${JOB_ID} --no-wait --working-dir=${CUSTOM_WORKING_DIR} --base-image=${RAY_IMAGE} --entrypoint=main.py -- ${GUIDEBOOK_DASHDASH}
---
```

--8<-- "ml/ray/run/logs"
