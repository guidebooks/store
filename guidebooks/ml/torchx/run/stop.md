---
imports:
    - kubernetes/helm3
    - kubernetes/choose/ns
    - ./instance-id
---

# Tear down the Torchx Job

```shell
helm delete ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} ${TORCHX_INSTANCE}
```
