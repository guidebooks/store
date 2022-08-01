---
imports:
    - util/shuf
    - kubernetes/context.md
    - kubernetes/choose/ns.md
---

# Port-forward to the Ray API

To facilitate communication to the Ray API.

```shell.async
kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} port-forward service/${RAY_KUBE_CLUSTER_NAME}-ray-head ${RAY_KUBE_PORT-8266}:8265 > /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster}
```

### Wait for the ray port forwarder to become active

```shell
while true; do if [ -f /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster} ] && [ "$(cat /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```
