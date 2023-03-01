## Run it

Submit the job.

```shell
---
exec: ray-submit --job-id ${JOB_ID} --working-dir=${CUSTOM_WORKING_DIR} --entrypoint=main.py -- -v --datapath /tmp/ --modelpath /tmp/ --logpath /tmp/ --tblogpath "${TB_LOGDIR}" --num_workers ${NUM_GPUs-${NUM_CPUS_INTEGER-1}} ${GPU_OPTION}
---
```
