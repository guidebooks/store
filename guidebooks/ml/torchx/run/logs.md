---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
    - ./wait-till-running
    - ./instance-label
    - ./status-poller
    - ml/ray/run/pod-stats
    - ml/ray/run/gpu-utilization
---

# Stream out Torchx Job Logs

```shell
--8<-- "./logs.sh"
```
