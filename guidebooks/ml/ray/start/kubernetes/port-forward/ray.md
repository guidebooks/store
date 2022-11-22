---
imports:
    - util/shuf
    - kubernetes/choose/ns
---

# Port-forward to the Ray API

To facilitate communication to the Ray API.

```shell.async
N=1
SLEEP=1
while true; do
    kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} port-forward service/${RAY_KUBE_CLUSTER_NAME-mycluster}-ray-head ${RAY_KUBE_PORT-8266}:8265 > /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster} || sleep $SLEEP
    if [ "$N" -lt 10 ]; then SLEEP=10; fi
    N=$((N + 1))
done
```

> Note: We loop here, because the client side connection to the server
> will inevitably time out. The sleep is there to protect us from
> unforeseen bugs that might otherwise result in an infinite spin loop.

### Wait for the ray port forwarder to become active

```shell
N=1
SLEEP=1
while true; do 
    if [ -f /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster} ] && [ "$(cat /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then
      break
    else
      sleep 1
    fi
    if [ "$N" -lt 10 ]; then SLEEP=10; fi
    N=$((N + 1))
done
```
