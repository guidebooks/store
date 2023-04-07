# Capture Environment Variables for Job

```shell
if [[ -n "$GUIDEBOOK_ENV" ]]; then
    jobEnvFile="${LOGDIR_STAGE}/env.json"
    echo -n "$GUIDEBOOK_ENV" | base64 -d > "$jobEnvFile"
fi
```
