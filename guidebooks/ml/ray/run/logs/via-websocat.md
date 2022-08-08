---
imports:
    - util/websocat
---

Using `websocat` is the easiest way @starpit can see to stream out the
logs in a way that is compatible with `tee` or `>` or any other UNIX
pipeline operators. See
https://discuss.ray.io/t/ray-job-logs-follow-does-not-cooperate-with-unix-pipes/6489

```shell
export WS_ADDRESS=$(echo ${RAY_ADDRESS} | sed 's/^http/ws/')
```

```shell.async
if [ -n "${STREAMCONSUMER_LOGS}" ]; then
    if [ -z "$QUIET_CONSOLE" ]; then
        websocat --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail | tee "${STREAMCONSUMER_LOGS}job.txt"
    else
        websocat -B 524288 --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail > "${STREAMCONSUMER_LOGS}job.txt"
    fi
fi
```

Oof, missing `ray job wait`... This is a simplisitic and wasteful way
to do the same. See
https://discuss.ray.io/t/feature-request-cli-command-ray-job-wait/6492

```shell
if [ -n "${STREAMCONSUMER_LOGS}" ]; then
    if [ -z "$NO_WAIT" ]; then
        # was: ray job logs -f ${JOB_ID} >& /dev/null
        websocat --exit-on-eof --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail >& /dev/null
    fi
fi
```
