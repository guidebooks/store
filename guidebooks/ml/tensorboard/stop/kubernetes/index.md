---
imports:
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
---

# Stop The Tensorboard Server in Kubernetes

Stop The Tensorboard Server in Kubernetes.

```shell
helm --kube-context ${KUBE_CONTEXT} -n ${KUBE_NS} uninstall tensorboard
```
