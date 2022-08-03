---
imports:
    - util/shuf
    - kubernetes/context.md
    - kubernetes/choose/ns.md
---

# Port-forward to the Ray API

To facilitate communication to the Ray API. For Kubernetes instances.

```shell
if [ -z "${KUBE_CONTEXT}" ]; then 
    echo "NO CONTEXT"
elif [ -z "${RAY_KUBE_PORT}" ]; then 
    echo "NO KUBE PORT"
elif [ -z "${RAY_KUBE_CLUSTER_NAME}" ]; then 
    echo "NO CLUSTER NAME"
fi
```

```shell.async
kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} port-forward service/${RAY_KUBE_CLUSTER_NAME}-ray-head ${RAY_KUBE_PORT}:10001 > /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME}
```

```shell
echo "cating the port-forward output"
cat /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME}
```

```shell
```

### Wait for the ray port forwarder to become active

```shell
while true; do if [ -f /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME} ] && [ "$(cat /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

```shell
echo "IN THE THICK OF IT ${RAY_KUBE_PORT:-DEFAULT_8266}  ${RAY_KUBE_CLUSTER_NAME:-DEFAULT_CLUSTER_NAME}"
```
