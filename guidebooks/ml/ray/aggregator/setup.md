---
imports:
    - util/jq
---

# Log Aggregator Setup

Set up some variables that are dependently on the selected run.

```shell
export JOB_ENV=$(curl $RAY_ADDRESS/api/jobs/$JOB_ID | jq -cr '.runtime_env.env_vars')
```

```shell
export NUM_GPUS=$(echo "$JOB_ENV" | jq -r .NUM_GPUS)
```
