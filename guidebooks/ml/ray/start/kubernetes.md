---
imports:
    - kubernetes/kubectl
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
    - ./kubernetes/label-selectors
    - ./resources
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.

The name of the Ray Kubernetes Service:

```shell
export RAY_KUBE_CLUSTER_NAME=${RAY_KUBE_CLUSTER_NAME-mycluster}
```

## Stream out Events from the Ray Head Node

```shell.async
kubectl get events ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} --watch-only | tee "${STREAMCONSUMER_EVENTS}kubernetes.txt"
```

```shell.async
if [ -n "$DEBUG_KUBERNETES" ]; then
    echo "Streaming out Ray Pod Logs"
    kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} logs -l ray-cluster-name=${RAY_KUBE_CLUSTER_NAME} -f
fi
```

### Use Helm to create the Ray Cluster

--8<-- "./kubernetes/install-via-helm.md"
