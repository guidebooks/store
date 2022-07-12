# Initialize Ray Log Streaming

Local staging directory for the logs. Note that on macOS, the `mktemp`
command behaves a bit differently w.r.t. the template argument.
```shell
export LOGDIR_STAGE="${LOGDIR_STAGE-$GUIDEBOOK_PROFILE_DATA_PATH}/jobs/${JOB_ID}"
```

Ensure the staging directory exists.
```shell
mkdir -p "$LOGDIR_STAGE"
```

Store the job id in the stage.
```shell
echo ${JOB_ID} > "${LOGDIR_STAGE}/jobid.txt"
```

Staging location for logs, from any guidebooks.
```shell
export STREAMCONSUMER_LOGS="${LOGDIR_STAGE}/logs/"
```
```shell
mkdir -p "${LOGDIR_STAGE}/logs"
```

Staging location for events, from any guidebooks.
```shell
export STREAMCONSUMER_EVENTS="${LOGDIR_STAGE}/events/"
```
```shell
mkdir -p "${LOGDIR_STAGE}/events"
```

Staging location for resource utilization information, from any guidebooks.
```shell
export STREAMCONSUMER_RESOURCES="${LOGDIR_STAGE}/resources/"
```
```shell
mkdir -p "${LOGDIR_STAGE}/resources"
```
