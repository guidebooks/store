---
imports:
    - kubernetes/helm3
    - kubernetes/choose/ns
    - ./instance-id
---

# Tear down Torchx Job

```shell
[[ -n "$TORCHX_INSTANCE" ]] \
  && helm ls ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} | grep ${TORCHX_INSTANCE} >& /dev/null \
  && (helm delete ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} ${TORCHX_INSTANCE} 2>&1 | grep -v 'Failed to purge' || exit 0)
```
