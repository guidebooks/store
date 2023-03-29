---
imports:
    - kubernetes/helm3
    - kubernetes/choose/ns
    - ./instance-id
---

# Tear down Torchx Job

```shell
if [[ -n "$TORCHX_INSTANCE" ]]; then
  if helm ls ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} | grep ${TORCHX_INSTANCE} >& /dev/null ; then
      helm delete ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} ${TORCHX_INSTANCE} 2>&1 | grep -v 'Failed to purge' || exit 0
  fi
fi
```
