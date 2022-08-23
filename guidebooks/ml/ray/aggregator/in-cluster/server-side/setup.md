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

Wait for Ray head node to be ready.
```shell
while true; do
    kubectl get pod -l ray-node-type=head | grep Running > /dev/null && break || echo "[Log Aggregator]: Waiting for Ray Head node"
    sleep 1
done

kubectl wait pod -l ray-node-type=head --for=condition=Ready --timeout=240s
```

Extract the name of the Ray cluster.
```shell
export RAY_KUBE_CLUSTER_NAME=${RAY_KUBE_CLUSTER_NAME-$(kubectl get pod --no-headers -l ray-node-type=head -o custom-columns=NAME:.metadata.labels.ray-cluster-name | head -1 )}
```

Extract the name of our namespace.
```shell
export KUBE_NS=${KUBE_NS-$(kubectl get --no-headers pod $LOG_AGGREGATOR_POD_NAME -o custom-columns=NS:.metadata.namespace)}
```

Extract the endpoint for the Ray API.
```shell
export RAY_ADDRESS=http://${RAY_KUBE_CLUSTER_NAME}-ray-head.${KUBE_NS}.svc.cluster.local:8265
```

Only start aggregation if we haven't yet, by some other client
```shell
export GUIDEBOOK_AGGREGATOR_SINGLETON=$JOB_ID
```
