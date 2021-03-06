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
kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} delete raycluster ${RAY_KUBE_CLUSTER_NAME-mycluster} --wait=false || exit 0
```

## Clear out potentially stuck finalizers

```shell
if [ -z "$NOFORCE_STOP" ]; then
    echo "Patching finalizer"
    kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} patch raycluster ${RAY_KUBE_CLUSTER_NAME-mycluster} -p '{"metadata":{"finalizers":null}}' --type=merge 2> /dev/null || exit 0
fi
```

## Delete Cluster

Now we can delete the cluster.

```shell
helm --kube-context ${KUBE_CONTEXT} -n ${KUBE_NS} delete ${RAY_KUBE_CLUSTER_NAME-mycluster} || exit 0
```
