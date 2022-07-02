
Using `websocat` is the easiest way @starpit can see to stream out the
logs in a way that is compatible with `tee` or `>` or any other UNIX
pipeline operators. See
https://discuss.ray.io/t/ray-job-logs-follow-does-not-cooperate-with-unix-pipes/6489

```shell.async
WS_ADDRESS=$(echo ${RAY_ADDRESS} | sed 's/^http/ws/')
websocat --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail | vector --config /Users/apollo/work/research/cil/opensource/ray-template-repo/vector.toml
```

<!--using this to track if the job is done-->

```shell
ray job logs -f ${JOB_ID} >& /dev/null
```