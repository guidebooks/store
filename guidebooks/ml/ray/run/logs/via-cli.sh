if [ -z "${STREAMCONSUMER_LOGS}" ]; then
    ray job logs -f ${JOB_ID} 2> /dev/null
fi
