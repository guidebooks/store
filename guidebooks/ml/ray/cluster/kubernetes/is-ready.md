---
imports:
    - util/jq
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
---

# Ray-in-Kubernetes Cluster Readiness

```shell
export RAY_MAX_WORKERS=$(kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} get raycluster ${RAY_KUBE_CLUSTER_NAME-mycluster} -o json | jq '.spec.podTypes | .[] | select(.name=="rayWorkerType") | .maxWorkers')
```

Emit the initial state
```shell
echo "head    0/1"
echo "workers 0/${RAY_MAX_WORKERS-1}"
```

```shell
kubectl get pod \
  --context ${KUBE_CONTEXT} -n ${KUBE_NS} \
  -l ray-cluster-name=${RAY_KUBE_CLUSTER_NAME-mycluster} \
  --watch --no-headers \
  -o custom-columns=NAME:.metadata.name,TYPE:.metadata.labels.ray-node-type,STATUS:.status.phase \
  | awk -v MAX_WORKERS=$RAY_MAX_WORKERS '$2=="head" { if ($3=="Running") readyHead="1/1"; else readyHead="0/1"; print "head   ", readyHead; fflush(); } $2=="worker" { if ($3=="Running") { if (ready[$1]!=1) nReadyWorkers++; } else if (ready[$1]=1) { nReadyWorkers--; if (nReadyWorkers < 0) nReadyWorkers = 0; ready[$1]=0 } { print "workers", nReadyWorkers "/" MAX_WORKERS; fflush(); } }'
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
