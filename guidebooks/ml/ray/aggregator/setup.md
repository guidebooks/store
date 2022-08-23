---
imports:
    - util/jq
---

# Log Aggregator Setup

Set up some variables that are dependently on the selected run.

```shell
if [ -z "$JOB_ID" ]; then
    echo "Please set JOB_ID"
    exit 1
fi
```

```shell
export JOB_ENV=$(
    if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
        echo $(kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $LOG_AGGREGATOR_POD_NAME -- wait-for-and-cat "$LOG_AGGREGATOR_LOGDIR"/ray-job-definition.json)
    elif [ -z "$RAY_ADDRESS" ]; then
        echo "Please set RAY_ADDRESS"
        exit 1
    else
        while true; do
            resp=$(curl -s $RAY_ADDRESS/api/jobs/$JOB_ID)
            if [ -n "$resp" ]; then
                status=$(echo "$resp" | jq -cr '.status')
                if [ "$status" = "RUNNING" ] || [ "$status" = "SUCCEEDED" ]; then
                    echo "[Log Aggregator]: Ray job has started" 1>&2
                    echo "$resp"
                    break
                fi
            fi

            echo "[Log Aggregator]: Waiting for Ray job to start" 1>&2
            sleep 2
        done
    fi
)
```

```shell
export NUM_GPUS=$(echo "$JOB_ENV" | jq -cr '.runtime_env.env_vars.NUM_GPUS')
```
