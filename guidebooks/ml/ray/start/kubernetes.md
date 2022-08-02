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

--8<-- "../hacks/openshift/uid-range.md"

## Stream out Events from the Ray Head Node

```shell.async
kubectl get events --context ${KUBE_CONTEXT} -n ${KUBE_NS} --watch-only | tee "${STREAMCONSUMER_EVENTS}kubernetes.txt"
```

### Use Helm to create the Ray Cluster

This defines the base docker image we will use for the ray head and worker nodes.

```shell
export RAY_OPERATOR_IMAGE=${RAY_OPERATOR_IMAGE-rayproject/ray:1.13.0-py37}
```

```shell
export RAY_IMAGE=${RAY_IMAGE-$([ $NUM_GPUS = 0 ] && echo rayproject/ray:1.13.0-py37 || echo rayproject/ray-ml:1.13.0-py37-gpu)}
```

A staging directory for the clone of the Ray Helm chart.

```shell
export HELM_CLONE_TEMPDIR=$(mktemp -d)
```

The name of the Ray Kubernetes Service:

```shell
export RAY_KUBE_CLUSTER_NAME=mycluster
```

--8<-- "./kubernetes/install-via-helm.md"

## Wait for Ray Head Node

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} wait pod -n ${KUBE_NS} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --for=condition=Ready --timeout=600s | grep -v 'no matching resources' > /dev/null && break || echo "Waiting for Ray Head node"
    sleep 1
done
```

--8<-- "ml/ray/cluster/kubernetes"

## Wait for at least one Worker to be Ready

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} get pod -n ${KUBE_NS} -l ${KUBE_POD_LABEL_SELECTOR} | grep Running > /dev/null && break || echo "Waiting for Ray Worker nodes"
    sleep 1
done
```
