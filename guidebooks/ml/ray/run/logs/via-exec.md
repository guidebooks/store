# Stream out Ray Job Logs

Here, we use `kubectl exec` to stream out Ray job logs.

```shell.stdin
# Stream out Ray Logs

kubectl exec ${RAY_HEAD_POD} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -it \
    -- ray job logs -f ${JOB_ID} \
    | tee "${STREAMCONSUMER_LOGS}job.txt"
```


```shell
# Emit final job status message.

jobstatus="$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status | awk '{s=$1; print toupper(substr(s, 1, 1)) tolower(substr( s, 2 ))}')"

echo -e "\x1b[1;2;32m[Job \x1b[0;32m${jobstatus-Unknown}\x1b[1;2;32m]\x1b[0;2;32m * Run has completed $(tput sgr0)$(tput dim)$(tput setaf 2)$(date -u +'%Y-%m-%dT%H:%M:%SZ')$(tput sgr0)\x1b[0m" | tee -a "${STREAMCONSUMER_LOGS}job.txt"
```

