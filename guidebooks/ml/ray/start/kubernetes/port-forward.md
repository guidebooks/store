---
imports:
    - kubernetes/context
    - kubernetes/choose/ns
---

# Start up a Kubernetes port-forward to the cluster

## Clean up existing port forward

Kill any previously running port-forward. TODO: this does not allow multiple independent jobs.

```shell
export EXISTING_PORTFORWARD_PID=$(ps aux | grep -v grep | grep "port-forward service/${RAY_KUBE_CLUSTER_NAME-mycluster}-ray-head" | awk '{print $2}')
```

## Kill existing port forward

```shell
---
validate: |
  [ -z "$EXISTING_PORTFORWARD_PID" ]
---
kill $EXISTING_PORTFORWARD_PID || exit 0
```

## Launch a new port forwarder

```shell.async
kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} port-forward service/${RAY_KUBE_CLUSTER_NAME-mycluster}-ray-head ${RAY_KUBE_PORT-8266}:8265 > /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME-mycluster}
```

## Wait for the port forwarder to become active

```shell
while true; do if [ -f /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME-mycluster} ] && [ "$(cat /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME-mycluster} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

```shell
if [ -n "$WAIT" ]; then sleep 100000; fi
```
