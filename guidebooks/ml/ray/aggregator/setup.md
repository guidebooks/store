# Log Aggregator Setup

Set up some variables that are dependently on the selected run.

```shell
if [ -z "$JOB_ID" ]; then
    echo "Please set JOB_ID"
    exit 1
fi
```

```shell
export NUM_GPUS=${NUM_GPUS-0}
```
