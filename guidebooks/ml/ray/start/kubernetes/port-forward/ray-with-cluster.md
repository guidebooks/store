---
imports:
    - util/shuf
    - kubernetes/choose/ns
    - ml/ray/cluster/head
---

# Port-forward to the Ray API

To facilitate communication to the Ray API, we establish a
port-forward to a selected Ray cluster.

```shell.async
# Ray port-forward
N=1
SLEEP=1
while true; do
    svc=${RAY_KUBE_CLUSTER_HEAD_SERVICE-ray-head-${RAY_KUBE_CLUSTER_NAME-mycluster}}
    kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} port-forward --pod-running-timeout=24h service/$svc ${RAY_KUBE_PORT-8266}:8265 > /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster}
    
    state=$(kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${RAY_HEAD_POD} --no-headers -o custom-columns=STATUS:.status.phase)
    if [[ "$state" != "Running" ]] && [[ "$state" != "Pending" ]]; then
      # the underlying pod is no longer running, we can give up
      break
    fi

    sleep $SLEEP
    if [[ "$N" -lt 10 ]]; then SLEEP=10; fi
    N=$((N + 1))
done
```

> Note: We loop here, because the client side connection to the server
> will inevitably time out. The sleep is there to protect us from
> unforeseen bugs that might otherwise result in an infinite spin loop.

### Wait for the ray port forwarder to become active

```shell
# Wait for Ray port-forward to become active
N=1
SLEEP=1
while true; do 
    if [[ -f /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster} ]] && [[ "$(cat /tmp/port-forward-ray-${RAY_KUBE_CLUSTER_NAME-mycluster} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]]; then
      break
    else
      sleep $SLEEP
    fi

    state=$(kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${RAY_HEAD_POD} --no-headers -o custom-columns=STATUS:.status.phase)
    if [[ "$state" != "Running" ]] && [[ "$state" != "Pending" ]]; then
      # the underlying pod is no longer running, we can give up
      break
    fi
    
    if [[ "$N" -lt 10 ]]; then SLEEP=10; fi
    N=$((N + 1))
done

echo "🔗 $(tput setaf 3)Ray API is active with $(tput bold)RAY_ADDRESS=http://localhost:${RAY_KUBE_PORT}$(tput sgr 0)"
```
