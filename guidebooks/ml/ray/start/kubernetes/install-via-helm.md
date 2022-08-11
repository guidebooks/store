---
imports:
    - ml/ray/cluster/kubernetes/choose-pod-scheduler
---

# Install Ray in Kubernetes via Helm

```shell
---
validate: |
  if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then helm status ${RAY_KUBE_CLUSTER_NAME} ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG}; else exit 1; fi
---
--8<-- "./install-via-helm.sh"
```
