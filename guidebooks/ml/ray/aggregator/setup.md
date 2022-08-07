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

if [ -z "$RAY_ADDRESS" ]; then
    echo "Please set RAY_ADDRESS"
    exit 1
fi
```

```shell
export JOB_ENV=$(curl $RAY_ADDRESS/api/jobs/$JOB_ID | jq -cr '.runtime_env.env_vars')
```

```shell
export NUM_GPUS=$(echo "$JOB_ENV" | jq -r .NUM_GPUS)
```
