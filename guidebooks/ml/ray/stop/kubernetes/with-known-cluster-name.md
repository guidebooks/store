---
imports:
    - kubernetes/helm3
    - kubernetes/choose/ns
---

# Stop Ray in your Kubernetes Cluster

```shell
if [ -z "$RAY_KUBE_CLUSTER_NAME" ]; then exit; fi

helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME}) \
    || exit 0
```

--8<-- "ml/ray/start/kubernetes/self-destruct/cleanup"
