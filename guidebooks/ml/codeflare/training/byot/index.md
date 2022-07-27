---
imports:
    - util/jobid
    - ./working-directory.md
    - ./base-ray-image.md
    - ml/ray/run/logs/init.md
    - ml/ray/start
---

# Bring Your Own Training

This path provides a way for you to run your own custom training on a remote ray cluster.

## Run it

Submit the job.

```shell
export JOB_NAME=BYOT
```

```python
---
#exec: ray job submit  --job-id ${JOB_ID} --no-wait --runtime-env  ${CUSTOM_WORKING_DIR}/runtime-env.yaml --working-dir ${CUSTOM_WORKING_DIR} --address ${RAY_ADDRESS}  -- python main.py 
#the below command is equivalent of this command
exec: 
    #assumes that all these variables are set already, and are cross checked via asserts in python
    #JOB_ID=${JOB_ID} CUSTOM_WORKING_DIR=${CUSTOM_WORKING_DIR} RAY_ADDRESS=${RAY_ADDRESS}
---
--8<-- "./job_submission.py"
```

--8<-- "ml/ray/run/logs"
