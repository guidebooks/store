---
imports:
    - util/websocat
---

# Stream out Ray Job Logs

--8<-- "./gpu-utilization.md"

## Stream Ray Job Logs

Wait for the job to be active.

```shell
while true; do if [ "$(ray job status ${JOB_ID} >& /dev/null && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

Then stream out the logs.

```shell
echo "👉 $(tput setaf 6)Logs will be stored in this local staging directory: $(tput bold)${CODEFLARE_LOGDIR_STAGE}$(tput sgr0)"
echo "👉 $(tput setaf 6)Logs will also be stored in s3: $(tput bold)${CODEFLARE_LOGDIR_URI}$(tput sgr0)"
```

```shell
--8<-- "./logs.sh"
```

--8<-- "./logs-websocat.md"

