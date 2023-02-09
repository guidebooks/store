---
imports:
    - ./label-selectors
    - kubernetes/helm3
    - ml/ray/cluster/kubernetes/choose-pod-scheduler
---

# Install Ray in Kubernetes via Helm

This defines the base docker image we will use for the ray head and worker nodes.

```shell
export RAY_OPERATOR_IMAGE=${RAY_OPERATOR_IMAGE-rayproject/ray:2.1.0}
```

```shell
export RAY_VERSION=${RAY_VERSION=2.1.0}
```

```shell
export RAY_IMAGE=${RAY_IMAGE-$([ $NUM_GPUS = 0 ] && echo ${RAY_IMAGE_ORG-rayproject}/${RAY_IMAGE_NAME-ray}:${RAY_VERSION}${RAY_TAG_SUFFIX} || echo ${RAY_IMAGE_ORG-rayproject}/${RAY_IMAGE_NAME-ray-ml}:${RAY_VERSION}-gpu)}
```

```shell
--8<-- "./install-via-helm.sh"
```

## Wait for Ray Head Node

--8<-- "ml/ray/start/kubernetes/wait-for-head"
--8<-- "ml/ray/cluster/kubernetes"

## Wait for at least one Worker to be Ready

```shell
if [ "$MAX_WORKERS" -gt "0" ]; then
    while true; do
        kubectl ${KUBE_CONTEXT_ARG} get pod ${KUBE_NS_ARG} -l ${KUBE_POD_LABEL_SELECTOR} | grep Running > /dev/null && break || echo "Waiting for Ray Worker nodes"
        sleep 1
    done

    kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_LABEL_SELECTOR} --for=condition=Ready --timeout=240s && \
        echo "Worker node is ready"
fi
```
