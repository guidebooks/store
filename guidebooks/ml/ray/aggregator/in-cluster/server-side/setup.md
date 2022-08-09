---
imports:
    - kubernetes/kubectl
---

# Configure Log Aggregator for use inside a Kubernetes Cluster

```shell
if [ -z "$LOG_AGGREGATOR_POD_NAME" ]; then
    echo "Please define the LOG_AGGREGATOR_POD_NAME environment variable"
    exit 1
fi
```

```shell
export RAY_KUBE_CLUSTER_NAME=${RAY_KUBE_CLUSTER_NAME-$(kubectl get pod --no-headers -l ray-node-type=head -o custom-columns=NAME:.metadata.labels.ray-cluster-name | head -1 )}
```

```shell
export KUBE_NS=${KUBE_NS-$(kubectl get --no-headers pod $LOG_AGGREGATOR_POD_NAME -o custom-columns=NS:.metadata.namespace)}
```

```shell
export RAY_ADDRESS=http://${RAY_KUBE_CLUSTER_NAME}-ray-head.${KUBE_NS}.svc.cluster.local:8265
```
