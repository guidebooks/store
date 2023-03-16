---
imports:
    - kubernetes/helm3
    - kubernetes/choose/ns
    - ./instance-id
---

# Tear down Torchx Job

```shell
---
validate: |
---
[[ -n "$TORCHX_INSTANCE" ]] \
  && helm ls ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} ${TORCHX_INSTANCE} 2> /dev/null \
  && helm delete ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} ${TORCHX_INSTANCE}
```
