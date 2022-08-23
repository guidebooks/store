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
    if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
        kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/logs/job.txt > "${STREAMCONSUMER_LOGS}job.txt"
    elif [ -z "$QUIET_CONSOLE" ]; then
        websocat --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail | tee "${STREAMCONSUMER_LOGS}job.txt"
    else
        echo "Ray log streamer start: ${JOB_ID} ${WS_ADDRESS}" 1>&2
        websocat -B 524288 --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail > "${STREAMCONSUMER_LOGS}job.txt"
        echo "Ray log streamer exit: ${JOB_ID}" 1>&2
    fi
fi
```

Oof, missing `ray job wait`... This is a simplisitic and wasteful way
to do the same. See
https://discuss.ray.io/t/feature-request-cli-command-ray-job-wait/6492

```shell
if [ -n "${STREAMCONSUMER_LOGS}" ]; then
    if [ -z "$NO_WAIT" ]; then
        if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
            echo "TODO" 1>&2
        else
            # was: ray job logs -f ${JOB_ID} >& /dev/null
            echo "Waiting for ray job to finish: ${JOB_ID}" 1>&2
            websocat --exit-on-eof --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail > /dev/null
            status=$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status)
            if [ "SUCCEEDED" != $status ] && [ "ERROR" != $status ]; then
                echo "Waiting (again) for ray job to finish: ${JOB_ID} $status" 1>&2
                websocat --exit-on-eof --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail > /dev/null
                status=$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status)
                if [ "SUCCEEDED" != $status ] && [ "ERROR" != $status ]; then
                    echo "Polling for ray job to finish: ${JOB_ID} $status" 1>&2
                    while true; do
                        sleep 1
                        status=$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status)
                        if [ "SUCCEEDED" = $status ] || [ "ERROR" = $status ]; then
                            break
                        fi
                    done
                fi
            fi
            status=$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status)
            echo "Ray job has finished: ${JOB_ID} $status" 1>&2
        fi
    fi
fi
```
