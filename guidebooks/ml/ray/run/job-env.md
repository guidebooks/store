# Capture Environment Variables for Job

This increases the default GCS timeout (which is 5 seconds) to 30
seconds. This increases resilience to network contention.

```shell
export RAY_gcs_rpc_server_connect_timeout_s=30
```

```shell
if [[ -n "$GUIDEBOOK_ENV" ]]; then
    jobEnvFile="${LOGDIR_STAGE}/env.json"
    echo -n "$GUIDEBOOK_ENV" | base64 -d > "$jobEnvFile"
fi
```
