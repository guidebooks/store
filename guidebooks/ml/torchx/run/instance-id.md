---
imports:
    - util/jobid
---

```shell
export TORCHX_INSTANCE=$(echo "${USER-nouser}-torchx-${JOB_ID}" | cut -c1-63)
```
