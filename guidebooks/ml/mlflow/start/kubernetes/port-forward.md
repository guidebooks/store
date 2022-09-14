---
imports:
    - util/shuf
    - kubernetes/kubectl
    - kubernetes/context
    - kubernetes/choose/ns
    - ./install
---

# Port-forward to the MLFlow server

```shell
export MLFLOW_PORT=${MLFLOW_PORT-$(shuf -i 8266-9999 -n1)}
```

```shell.async
kubectl port-forward ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} service/mlflow-service ${MLFLOW_PORT}:9080 > /tmp/port-forward-mlflow
```

```shell
echo "👉 $(tput setaf 6)MLFlow URL: $(tput bold)http://localhost:${MLFLOW_PORT}$(tput sgr0)"
```

## Wait for the MLFlow port forwarder to become active

```shell
while true; do if [ -f /tmp/port-forward-mlflow ] && [ "$(cat /tmp/port-forward-mlflow | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

## Wait, if requested

In some debugging cases it might be useful to wait for a bit. TODO:
this really should be wait, if we are executing this as a top-level
guidebook. That is, if the user only wants to set up the port
forwarding, then we shouldn't exit. This is the hack for now: set
`WAIT=true` when running this guidebook in this scenarios.

```shell
if [ -n "$WAIT" ]; then sleep 100000; fi
```
