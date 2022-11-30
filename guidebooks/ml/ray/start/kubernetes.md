---
imports:
    - util/jobid
    - kubernetes/kubectl
    - ./resources
    - kubernetes/choose/ns
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.

The name of the Ray Kubernetes Service:

```shell
export RAY_KUBE_CLUSTER_NAME=${RAY_KUBE_CLUSTER_NAME-ray-${APP_NAME-myapp}-${JOB_ID}}
```

## Stream out Events from the Ray Head Node

```shell.async
kubectl get events ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} --watch-only | tee "${STREAMCONSUMER_EVENTS-/tmp/}kubernetes.txt"
```

```shell.async
if [ -n "$DEBUG_KUBERNETES" ]; then
    echo "Streaming out Ray Pod Logs"
    kubectl logs ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ray-cluster-name=${RAY_KUBE_CLUSTER_NAME} -f
fi
```

### Use Helm to create the Ray Cluster

--8<-- "./kubernetes/install-via-helm.md"
