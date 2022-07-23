---
imports:
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
---

# Stop The MLFlow Server in Kubernetes

Stop The MLFlow Server in Kubernetes.

```shell
helm --kube-context ${KUBE_CONTEXT} -n ${KUBE_NS} uninstall mlflow
```
