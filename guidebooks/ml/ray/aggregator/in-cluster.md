---
imports:
    - kubernetes/choose/ns
---

# Start up Log Aggregator inside a Kubernetes Cluster

This guidebook is the same as the `with-jobid` guidebook, in that it
assumes some external agent has set the `JOB_ID` environment variable.

TODO: avoid hard-coded `mycluster`.

```shell
export RAY_ADDRESS=http://mycluster-ray-head.${KUBE_NS}.svc.cluster.local:8265
```

:import{./with-jobid}
