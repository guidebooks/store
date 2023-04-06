---
imports:
    - util/jobid
---

```shell
export TORCHX_INSTANCE=$(echo "${USER-nouser}-torchx-${JOB_ID}" | cut -c1-35)
```

To help us find relevant events.

```shell
export KUBERNETES_EVENT_KEY=$TORCHX_INSTANCE
```
