---
imports:
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
---

# Stop The JupyterLab Server in Kubernetes

Stop The JupyterLab Server in Kubernetes.

```shell
helm ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} uninstall jupyterlab || exit 0
```
