---
imports:
    - ./label-selectors
    - kubernetes/helm3
    - ml/ray/cluster/kubernetes/choose-pod-scheduler
---

# Install Ray in Kubernetes via Helm

This defines the base docker image we will use for the ray head and worker nodes.

```shell
export RAY_OPERATOR_IMAGE=${RAY_OPERATOR_IMAGE-rayproject/ray:1.13.1-py37}
```

```shell
export RAY_IMAGE=${RAY_IMAGE-$([ $NUM_GPUS = 0 ] && echo rayproject/ray:1.13.1-py37 || echo rayproject/ray-ml:1.13.1-py37-gpu)}
```

```shell
---
validate: |
  if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then helm status ${RAY_KUBE_CLUSTER_NAME} ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG}; else exit 1; fi
---
--8<-- "./install-via-helm.sh"
```

## Wait for Ray Head Node

```shell
while true; do
    kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} | grep Running > /dev/null && break || echo "Waiting for Ray Head node"
    sleep 1
done

kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --for=condition=Ready --timeout=240s && \
    echo "Head node is ready"
```

--8<-- "ml/ray/cluster/kubernetes"

## Wait for at least one Worker to be Ready

```shell
while true; do
    kubectl ${KUBE_CONTEXT_ARG} get pod ${KUBE_NS_ARG} -l ${KUBE_POD_LABEL_SELECTOR} | grep Running > /dev/null && break || echo "Waiting for Ray Worker nodes"
    sleep 1
done

kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_LABEL_SELECTOR} --for=condition=Ready --timeout=240s && \
    echo "Worker node is ready"
```
