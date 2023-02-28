---
imports:
    - kubernetes/choose/ns
    - ml/ray/start/kubernetes/label-selectors.md
---

# Stream GPU Utilization Metrics

We use some bash hacking to `kubectl exec` into each pod that
satisfies the `KUBE_POD_LABEL_SELECTOR` filter. We use `awk` to
display the utilization metric in red text (`[31m`), and to turn "Gpu"
into "Gpu Utilization".

```shell.async
if [ ${NUM_GPUS-0} -gt 0 ]; then
  --8<-- "./gpu-utilization.sh"
fi
```
