---
imports:
    - util/jq
    - kubernetes/kubectl
    - ml/ray/cluster/head
---

# Capture Job Definition

Let's capture parameters of the job. This will include, for example,
the Ray `runtime_env`.

```shell.async
curl -s $KUI_RAY_ADDRESS/api/jobs/$JOB_ID > "${LOGDIR_STAGE}/ray-job-definition.json"
INPUT=$(cat "${LOGDIR_STAGE}/ray-job-definition.json" | jq -r .entrypoint | awk '{print $2}')
PKGDIR=$(cat "${LOGDIR_STAGE}/ray-job-definition.json" | jq -r .runtime_env.working_dir | sed 's#gcs://##' | sed 's/\.zip//')
kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} ${RAY_HEAD_POD} -- cat /tmp/ray/session_latest/runtime_resources/working_dir_files/${PKGDIR}/${INPUT} >> "${LOGDIR_STAGE}/source.py"

while true; do
    curl -s $KUI_RAY_ADDRESS/api/jobs/$JOB_ID > "${LOGDIR_STAGE}/ray-job-definition.json"
    sleep 10
done
```
