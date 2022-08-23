---
imports:
    - util/jq
    - kubernetes/kubectl
---

# Capture Job Definition

Let's capture parameters of the job. This will include, for example,
the Ray `runtime_env`.

```shell.async
if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/$LOG_AGGREGATOR_POD_NAME -- cat "$LOG_AGGREGATOR_LOGDIR"/ray-job-definition.json > "${LOGDIR_STAGE}/ray-job-definition.json"
elif [ -z "$RAY_ADDRESS" ]; then
    echo "Please set RAY_ADDRESS"
    exit 1
else
    curl -s $RAY_ADDRESS/api/jobs/$JOB_ID > "${LOGDIR_STAGE}/ray-job-definition.json"
fi

INPUT=$(cat "${LOGDIR_STAGE}/ray-job-definition.json" | jq -r .entrypoint | awk '{print $2}')
PKGDIR=$(cat "${LOGDIR_STAGE}/ray-job-definition.json" | jq -r .runtime_env.working_dir | sed 's#gcs://##' | sed 's/\.zip//')

if [ -n "$KUBE_CONTEXT" ] && [ -n "$KUBE_NS" ]; then
    RAY_HEAD_POD=$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --no-headers | awk '{print $1}')
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${RAY_HEAD_POD} -- cat /tmp/ray/session_latest/runtime_resources/working_dir_files/${PKGDIR}/${INPUT} >> "${LOGDIR_STAGE}/source.py"
fi
```
