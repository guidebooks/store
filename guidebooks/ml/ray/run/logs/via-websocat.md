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

    if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
        kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/logs/job.txt > "${STREAMCONSUMER_LOGS}job.txt"
    elif [ -z "$QUIET_CONSOLE" ]; then
        websocat --text --no-line --exit-on-eof ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail $WEBSOCAT_OPTS | tee "${STREAMCONSUMER_LOGS}job.txt"
    else
        echo "Ray log streamer start: ${JOB_ID} ${WS_ADDRESS}" 1>&2
        websocat --text -B 524288 --no-line --exit-on-eof ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail $WEBSOCAT_OPTS > "${STREAMCONSUMER_LOGS}job.txt"
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
            jobstatus="$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status)"
            if [[ "SUCCEEDED" != $jobstatus ]] && [[ "FAILED" != $jobstatus ]]; then
                echo "Waiting (again) for ray job to finish: ${JOB_ID} $jobstatus" 1>&2
                websocat --text --exit-on-eof --no-line ${WS_ADDRESS}/api/jobs/${JOB_ID}/logs/tail $WEBSOCAT_OPTS > /dev/null
                jobstatus="$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status)"
                if [[ "SUCCEEDED" != $jobstatus ]] && [[ "FAILED" != $jobstatus ]]; then
                    echo "Polling for ray job to finish: ${JOB_ID} $jobstatus" 1>&2
                    while true; do
                        sleep 1
                        jobstatus="$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status)"
                        if [[ "SUCCEEDED" = $jobstatus ]] || [[ "FAILED" = $jobstatus ]]; then
                            break
                        fi
                    done
                fi
            fi
            jobstatus="$(curl -s ${RAY_ADDRESS}/api/jobs/${JOB_ID} | jq -r .status | awk '{s=$1; print toupper(substr(s, 1, 1)) tolower(substr( s, 2 ))}')"
            echo -e "\x1b[1;2;32m[Job \x1b[0;32m${jobstatus-Unknown}\x1b[1;2;32m]\x1b[0;2;32m * Run has completed $(tput sgr0)$(tput dim)$(tput setaf 2)$(date -u +'%Y-%m-%dT%H:%M:%SZ')$(tput sgr0)\x1b[0m" | tee -a "${STREAMCONSUMER_LOGS}job.txt"
        fi
    fi
fi
```
