---
imports:
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
---

# Stop The MLFlow Server in Kubernetes

Stop The MLFlow Server in Kubernetes.

```shell
helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall mlflow
```
