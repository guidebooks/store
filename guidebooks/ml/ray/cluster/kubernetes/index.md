---
imports:
    - util/shuf
---

# Settings for a Kubernetes Ray Cluster

Choose this option if your Ray Cluster is running on Kubernetes.

## The local port to use for `ray` operations

Here, we try to avoid using the default port for a local Ray instance.

```shell
export RAY_KUBE_PORT=${RAY_KUBE_PORT-$(shuf -i 8266-9999 -n1)}
```

```shell
export RAY_ADDRESS="http://127.0.0.1:$RAY_KUBE_PORT"
```

--8<-- "ml/ray/start/kubernetes/port-forward.md"

## The URL to use for `ray` operations

Note: set this after bringing up the port-forward, because the
RAY_ADDRESS is not valid until the port forward is up.
