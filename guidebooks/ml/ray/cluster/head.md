---
imports:
    - kubernetes/kubectl
    - ml/ray/start/kubernetes/label-selectors
---

# Determine the name of the head node

```shell
export RAY_HEAD_POD=$(kubectl get pod -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --no-headers | awk '{print $1}')
```
