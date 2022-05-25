---
imports:
    - ../../../kubernetes/kubectl.md
    - ../../../kubernetes/context.md
    - ../../../kubernetes/choose/ns.md
    - ../../../kubernetes/helm3.md
---

# Stop Ray in your Kubernetes Cluster

## Delete Cluster Resource

First, we need to delete the cluster resource, to make sure finalizers
are processed properly.

```shell
kubectl --context ${KUBE_CONTEXT} -n ${RAY_KUBE_NS} delete raycluster ${RAY_KUBE_CLUSTER_NAME-mycluster} || exit 0
```

## Delete Cluster

Now we can delete the cluster.

```shell
helm --kube-context ${KUBE_CONTEXT} -n ${RAY_KUBE_NS} delete ${RAY_KUBE_CLUSTER_NAME-mycluster} || exit 0
```
