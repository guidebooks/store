
Wait for the job to be active, and then stream out the logs.

```shell
while true; do if [ "$(ray job status ${JOB_ID} >& /dev/null && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
ray job logs -f ${JOB_ID} 2> /dev/null
```
