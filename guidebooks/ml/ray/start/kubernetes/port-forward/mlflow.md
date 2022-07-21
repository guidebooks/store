---
imports:
    - util/shuf
    - kubernetes/context
    - kubernetes/choose/ns
---

# Port-forward to the MLFlow server

```shell
export MLFLOW_PORT=${MLFLOW_PORT-$(shuf -i 8266-9999 -n1)}
```

```shell.async
kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} port-forward service/monitoring-service ${MLFLOW_PORT}:9080 > /tmp/port-forward-mlflow-${RAY_KUBE_CLUSTER_NAME-mycluster}
```

## Wait for the MLFlow port forwarder to become active

```shell
while true; do if [ -f /tmp/port-forward-mlflow-${RAY_KUBE_CLUSTER_NAME-mycluster} ] && [ "$(cat /tmp/port-forward-mlflow-${RAY_KUBE_CLUSTER_NAME-mycluster} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```
