---
imports:
    - kubernetes/kubectl
    - ml/ray/start/kubernetes/label-selectors
---

# Determine the name of the head node

```shell
export RAY_HEAD_POD=$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --no-headers | awk '{print $1}')
```
