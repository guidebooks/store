---
imports:
    - util/websocat
---

# Stream out Ray Job Logs

We will stream out a suite of data, including resource utilization metrics and job logs.

## Stream Resource Metrics

--8<-- "./pod-stats.md"
--8<-- "./node-stats.md"
--8<-- "./gpu-utilization.md"

## Capture Job Definition

--8<-- "./job-definition.md"

## Stream Ray Job Logs

Wait for the job to be active.

```shell
while true; do if [ "$(ray job status ${JOB_ID} >& /dev/null && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

Then stream out the logs.

```shell
if [ -n "${LOGDIR_STAGE}" ]; then
  echo
  echo "👉 $(tput setaf 6)Logs will be stored in this local staging directory: $(tput bold)${LOGDIR_STAGE}$(tput sgr0)"
  echo "👉 $(tput setaf 6)Logs will also be stored in s3: $(tput bold)${LOGDIR_URI}$(tput sgr0)"
fi
```

```shell
--8<-- "./logs.sh"
```

--8<-- "./logs-websocat.md"

