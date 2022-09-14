---
imports:
    - util/jq
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
    - ./choose-pod-scheduler
---

# Ray-in-Kubernetes Cluster Readiness

```shell
export RAY_MAX_WORKERS=$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} raycluster ${RAY_KUBE_CLUSTER_NAME-mycluster} -o json | jq '.spec.podTypes | .[] | select(.name=="rayWorkerType") | .maxWorkers')
```

Emit the initial state
```shell
echo "head    0/1"
echo "workers 0/${RAY_MAX_WORKERS-1}"
```

```shell
kubectl get pod \
  ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
  -l ray-cluster-name=${RAY_KUBE_CLUSTER_NAME-mycluster} \
  --watch --no-headers \
  -o custom-columns=NAME:.metadata.name,TYPE:.metadata.labels.ray-node-type,STATUS:.status.phase \
  | awk -v MAX_WORKERS=${RAY_MAX_WORKERS-0} -v KUBE_POD_MANAGER=$KUBE_POD_MANAGER '\
  --8<-- "./is-ready.awk"
  '
```

Until your cluster is not provisioned, you should expect no
output. Once the Ray operator is operational, expect to see a stream
of lines like this:

```
head    1/1
workers 1/2
```

This output is intended to summarize the readiness of the two main
classes of resources in your Kubernetes cluster. In this example "1/2"
means that 1 Ray worker is ready, out of the maximum of 2 workers that
you have allowed.

I don't know if Ray has a concept of a minimum viable worker
quorum. If it does/ever does, we can integrate that into this logic.
