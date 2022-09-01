---
imports:
    - kubernetes/helm3
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

# Stop Ray in your Kubernetes Cluster

```shell
helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME-mycluster} || exit 0
```
