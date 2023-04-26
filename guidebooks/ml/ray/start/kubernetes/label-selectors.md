# Helpful Kubernetes Label Selectors for Ray

A Kubernetes label selector that can be used to query for the head node.
```shell
export KUBE_POD_RAY_HEAD_LABEL_SELECTOR=${KUBE_POD_LABEL_SELECTOR-ray-user-node-type=rayHeadType,app.kubernetes.io/instance=${RAY_KUBE_CLUSTER_NAME}}
```

A Kubernetes label selector that can be used to query for both workers and the head node.
```shell
export KUBE_PODFULL_LABEL_SELECTOR=${KUBE_PODFULL_LABEL_SELECTOR-app.kubernetes.io/instance=${RAY_KUBE_CLUSTER_NAME}}
```

A Kubernetes label selector that can be used to query for workers.
```shell
export KUBE_POD_LABEL_SELECTOR=${KUBE_POD_LABEL_SELECTOR-ray-user-node-type=rayWorkerType,app.kubernetes.io/instance=${RAY_KUBE_CLUSTER_NAME}}
```

Identify the pods that should be tracked for logs
```shell
export KUBE_RAY_LOGS_LABEL_SELECTOR="-l $KUBE_POD_RAY_HEAD_LABEL_SELECTOR"
```

```shell
export KUBE_JOB_LOGS_LABEL_SELECTOR="${KUBE_JOB_LOGS_LABEL_SELECTOR-$KUBE_RAY_LOGS_LABEL_SELECTOR}"
```
