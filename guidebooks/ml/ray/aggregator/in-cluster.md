---
imports:
    - kubernetes/kubectl
---

# Start up Log Aggregator inside a Kubernetes Cluster

This guidebook is the same as the `with-jobid` guidebook, in that it
assumes some external agent has set the `JOB_ID` environment variable.

```shell
if [ -z "$LOG_AGGREGATOR_POD" ]; then
    echo "Please define the LOG_AGGREGATOR_POD environment variable"
    exit 1
fi
```

```shell
export KUBE_NS=${KUBE_NS-$(kubectl get --no-headers pod $LOG_AGGREGATOR_POD -o custom-columns=NS:.metadata.namespace)}
```

TODO: avoid hard-coded `mycluster`.

```shell
export RAY_ADDRESS=http://mycluster-ray-head.${KUBE_NS}.svc.cluster.local:8265
```

--8<-- "./with-jobid"
