# Helpful Kubernetes Label Selectors for Ray

A Kubernetes label selector that can be used to query for workers.
```shell
export KUBE_POD_LABEL_SELECTOR=ray-user-node-type=rayWorkerType,app.kubernetes.io/name=${RAY_KUBE_CLUSTER_NAME}
```

```shell
export KUBE_POD_RAY_HEAD_LABEL_SELECTOR=ray-user-node-type=rayHeadType,app.kubernetes.io/name=${RAY_KUBE_CLUSTER_NAME}
```

A Kubernetes label selector that can be used to query for workers and the head node.
```shell
export KUBE_PODFULL_LABEL_SELECTOR=app.kubernetes.io/name=${RAY_KUBE_CLUSTER_NAME},ray-node-type
```
