---
imports:
    - util/shuf
---

## The local port to use for `ray` operations

Here, we try to avoid using the default port for a local Ray instance.

```shell
export RAY_KUBE_PORT=${RAY_KUBE_PORT-$(shuf -i 8266-9999 -n1)}
```

```shell
export RAY_ADDRESS="http://127.0.0.1:$RAY_KUBE_PORT"
```
