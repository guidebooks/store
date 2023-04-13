---
imports:
    - kubernetes/choose/ns
    - ml/ray/start/kubernetes/label-selectors.md
---

# Sample Kubernetes Pod Statistics

This guidebook will emit a stream of samples of the form:

```
Sample 2022-06-21T08:19:54-04:00
NAME                              GPUReq   CPUReq   MemReq
mycluster-ray-worker-type-np2vr   1        1        32Gi

Sample 2022-06-21T08:19:54-04:05
NAME                              GPUReq   CPUReq   MemReq
mycluster-ray-worker-type-np2vr   1        1        32Gi
```

```shell.async
# CPU Utilization

--8<-- "./pod-vmstat.sh"
```

```shell.async
# Memory Utilization

--8<-- "./pod-vmstat-memory.sh"
```

```shell.async
# Worker Status

--8<-- "./pod-stats.sh"
```

```shell
if [ -n "$WAIT" ]; then sleep 100000000; fi
```
