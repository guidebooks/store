if [ -z "${STREAMCONSUMER_LOGS}" ]; then
    curl -s $RAY_ADDRESS/api/jobs/$JOB_ID/logs | jq -r .logs
fi
