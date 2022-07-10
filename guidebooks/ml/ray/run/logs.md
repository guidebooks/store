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

Only one of these two will operate --- if you look into each, you will
see that they are guarded either by `$STREAMCONSUMER_LOGS` not being
defined, or being defined, respectively. The former case streams just
to the console. This can use `ray job logs -f` directly. The latter
case handles streaming the output somewhere, such as to a file (and
possibly to the console, too, via `tee`).

It turns out that the `ray` CLI does some sort of batching that makes
consuming streaming output from that file "batchy". Instead, we use
[`websocat`](https://github.com/vi/websocat) to talk directly to the
Ray API; for log following, this is a websocket protocol, hence the
need for an additional tool. Sigh.

### Logs just to console

```shell
--8<-- "./logs.sh"
```

### Logs to a file (and possibly the console, too)

--8<-- "./logs-websocat.md"
