---
imports:
    - kubernetes/kubectl
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
    - ./resources.md
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.

--8<-- "../hacks/openshift/uid-range.md"

## Stream out Events from the Ray Head Node

```shell.async
kubectl get events --context ${KUBE_CONTEXT} -n ${KUBE_NS} --watch-only | tee "${STREAMCONSUMER_EVENTS}kubernetes.txt"
```

### Use Helm to create the Ray Cluster

This defines the base docker image we will use for the ray head and worker nodes.

```shell
export RAY_IMAGE=${RAY_IMAGE-$([ $NUM_GPUS = 0 ] && echo rayproject/ray:1.12.2-py37 || echo rayproject/ray-ml:1.12.2-py37-gpu)}
```

A staging directory for the clone of the Ray Helm chart.

```shell
export HELM_CLONE_TEMPDIR=$(mktemp -d)
```

The name of the Ray Kubernetes Service:

```shell
export RAY_KUBE_CLUSTER_NAME=mycluster
```

A Kubernetes label selector that can be used to query for workers.

```shell
export KUBE_POD_LABEL_SELECTOR=ray-user-node-type=rayWorkerType
```

--8<-- "./kubernetes/install-via-helm.md"

## Wait for Ray Head Node

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} wait pod -n ${KUBE_NS} -l ray-user-node-type=rayHeadType --for=condition=Ready --timeout=600s | grep -v 'no matching resources' > /dev/null && break || echo "Waiting for Ray Head node"
    sleep 1
done
```

## The local port to use for `ray` operations

Here, we try to avoid using the default port for a local Ray instance.

```shell
export RAY_KUBE_PORT=8266
```

## The URL to use for `ray` operations

```shell
export RAY_ADDRESS="http://127.0.0.1:$RAY_KUBE_PORT"
```

--8<-- "./kubernetes/port-forward.md"

## Wait for at least one Worker to be Ready

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} wait pod -n ${KUBE_NS} -l ${KUBE_POD_LABEL_SELECTOR} --for=condition=Ready --timeout=600s | grep -v 'no matching resources' > /dev/null && break || echo "Waiting for Ray Worker nodes"
    sleep 1
done
```
