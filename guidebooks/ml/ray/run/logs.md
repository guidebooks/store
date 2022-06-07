# Stream out Ray Job Logs

--8<-- "./gpu-utilization.md"

## Stream Ray Job Logs

Wait for the job to be active.

```shell
while true; do if [ "$(ray job status ${JOB_ID} >& /dev/null && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

Then stream out the logs.

```shell
--8<-- "./logs.sh"
```
