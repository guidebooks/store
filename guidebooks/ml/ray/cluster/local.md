# Settings for a Local Ray Cluster

Choose this option if your Ray Cluster is running on your local machine.

```shell
export RAY_KUBE_PORT=${RAY_KUBE_PORT-8265}
```

```shell
export RAY_ADDRESS=http://127.0.0.1:${RAY_KUBE_PORT}
```
