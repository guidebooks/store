---
imports:
    - kubernetes/helm3
    - kubernetes/choose/ns
---

# Stop Ray in your Kubernetes Cluster

```shell
if [ -z "$RAY_KUBE_CLUSTER_NAME" ]; then exit; fi
if ! helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} status ${RAY_KUBE_CLUSTER_NAME} >& /dev/null; then exit; fi

helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || (sleep 1 && helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall ${RAY_KUBE_CLUSTER_NAME} 2> /dev/null) \
    || exit 0
```
