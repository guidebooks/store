## Install Ray in Kubernetes via Helm

```shell
---
validate: |
  if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then X=$(kubectl --context ${KUBE_CONTEXT} get raycluster ${RAY_KUBE_CLUSTER_NAME} -n ${KUBE_NS} -o json 2>&1); echo "$X" | grep -v 'No resources' && echo "$X" | grep -v 'not found' && [ $(echo "$X" | jq '.spec.podTypes | .[] | select(.name=="rayWorkerType") | .podConfig.spec.containers[0].resources.requests.cpu') = ${NUM_CPUS-1} ]; else exit 1; fi
---
--8<-- "./install-via-helm.sh"
```
