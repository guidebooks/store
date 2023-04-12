Using `websocat` is the easiest way @starpit can see to stream out the
logs in a way that is compatible with `tee` or `>` or any other UNIX
pipeline operators. See
https://discuss.ray.io/t/ray-job-logs-follow-does-not-cooperate-with-unix-pipes/6489

```shell
export WS_ADDRESS=$(echo ${RAY_ADDRESS} | sed 's/^http/ws/')
```

```shell
if [ -n "${STREAMCONSUMER_LOGS}" ]; then
    # ugh, otherwise errno 22 ensues with ray 2
    if [ "$(uname)" = "Darwin" ]; then WEBSOCAT_OPTS=threadedstdio: ; fi

    if [ -z "$QUIET_CONSOLE" ]; then
        websocat --text --no-line --exit-on-eof ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail $WEBSOCAT_OPTS | tee "${STREAMCONSUMER_LOGS}job.txt"
    else
        websocat --text -B 524288 --no-line --exit-on-eof ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail $WEBSOCAT_OPTS > "${STREAMCONSUMER_LOGS}job.txt"
    fi
fi
```
