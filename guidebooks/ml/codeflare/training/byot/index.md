---
imports:
    - util/jobid
    - ./working-directory.md
    - ./base-ray-image.md
    - ml/ray/start
---

# Bring Your Own Training

This path provides a way for you to run your own custom training on a remote ray cluster.

## Run it

Submit the job.

```shell
export JOB_NAME=BYOT
```

```shell
---
exec: ray job submit  --job-id ${JOB_ID} --no-wait --runtime-env  ${CUSTOM_WORKING_DIR}/runtime-env.yaml --working-dir ${CUSTOM_WORKING_DIR} --address ${RAY_ADDRESS}  -- python main.py 
---
```

--8<-- "ml/ray/run/logs"
