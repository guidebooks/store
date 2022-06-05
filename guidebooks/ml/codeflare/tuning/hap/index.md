---
imports:
    - ../../../ray/hacks/openshift/uid-range.md
    - ../../../ray/start/index.md
    - ../../../../util/jobid.md
    - ../../../../s3/choose/instance.md
    - ../../../../s3/create/kubernetes/secret-if-needed.md
    - ../../../../s3/choose/object.md
---

# Fine-tuning with Hate and Profanity (HAP) Removal 

This solution guides you through fine-tuning your models to remove
hate and profanity.

## Run it

Submit the job.

```python
---
exec: ray-submit --job-id ${JOB_ID} --no-wait -- -s 1 -e 4 -b ${S3_BUCKET} -d ${S3_OBJECT} -v
---
--8<-- "./hap_benchmark.py"
```

--8<-- "../../../ray/run/logs.md"

