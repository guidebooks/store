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
        echo $(kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/$LOG_AGGREGATOR_POD_NAME -- cat "$LOG_AGGREGATOR_LOGDIR"/ray-job-definition.json)
    elif [ -z "$RAY_ADDRESS" ]; then
        echo "Please set RAY_ADDRESS"
        exit 1
    else
        echo $(curl -s $RAY_ADDRESS/api/jobs/$JOB_ID)
    fi
)
```

```shell
export NUM_GPUS=$(echo "$JOB_ENV" | jq -cr '.runtime_env.env_vars.NUM_GPUS')
```
