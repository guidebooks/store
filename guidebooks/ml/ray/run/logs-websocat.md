
Using `websocat` is the easiest way @starpit can see to stream out the
logs in a way that is compatible with `tee` or `>` or any other UNIX
pipeline operators. See
https://discuss.ray.io/t/ray-job-logs-follow-does-not-cooperate-with-unix-pipes/6489

```shell.async
if [ -n "${STREAMCONSUMER_LOGS}" ]; then
    WS_ADDRESS=$(echo ${RAY_ADDRESS} | sed 's/^http/ws/')
    websocat --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail | tee "${STREAMCONSUMER_LOGS}job.txt"
fi
```

Oof, missing `ray job wait`... This is a simplisitic and wasteful way
to do the same. See
https://discuss.ray.io/t/feature-request-cli-command-ray-job-wait/6492

```shell
if [ -n "${STREAMCONSUMER_LOGS}" ]; then
    ray job logs -f ${JOB_ID} >& /dev/null
fi
```
