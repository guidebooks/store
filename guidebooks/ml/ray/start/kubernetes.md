---
imports:
    - ../../../kubernetes/kubectl.md
    - ../../../kubernetes/helm3.md
    - ../../../kubernetes/context.md
    - ../../../kubernetes/choose/ns.md
    - ./resources.md
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.

```shell
---
validate: X=$(kubectl --context ${KUBE_CONTEXT} get raycluster mycluster -n ${RAY_KUBE_NS} -o json); echo "$X" | grep -v 'No resources' && [ $(echo "$X" | jq '.spec.podTypes | .[] | select(.name=="rayWorkerType") | .podConfig.spec.containers[0].resources.requests.cpu') = ${NUM_CPUS-1} ]
---
echo "$(tput setaf 4)Cloning ray repo$(tput sgr0)"
T=$(mktemp -d)
cd $T
git clone --filter=tree:0 --depth 1 --sparse git@github.com:ray-project/ray.git >& /dev/null
cd ray
git sparse-checkout init --cone >& /dev/null
git sparse-checkout set deploy/charts/ray >& /dev/null
if [ "${NUM_GPUS}" != 0 ]; then RAY_IMAGE=rayproject/ray-ml:nightly-gpu; else RAY_IMAGE=rayproject/ray:latest; fi

echo "$(tput setaf 4)Creating ray cluster num_cpus=$(tput setaf 5)${NUM_CPUS-1} $(tput setaf 4)num_gpus=$(tput setaf 5)${NUM_GPUS-1} $(tput setaf 4)head_memory=$(tput setaf 5)${HEAD_MEMORY-1Gi} $(tput setaf 4)worker_memory=$(tput setaf 5)${WORKER_MEMORY-1Gi} $(tput setaf 4)minWorkers=$(tput setaf 5)${MIN_WORKERS-2} $(tput setaf 4)maxWorkers=$(tput setaf 5)${MAX_WORKERS-3} $(tput setaf 4)image=$(tput setaf 5)${RAY_IMAGE} $(tput setaf 4)context=$(tput setaf 5)${KUBE_CONTEXT} $(tput setaf 4)namespace=$(tput setaf 5)${RAY_KUBE_NS}$(tput sgr0)"

helm -n ${RAY_KUBE_NS} upgrade --install --wait --timeout 30m mycluster --create-namespace deploy/charts/ray --set podTypes.rayWorkerType.CPU=${NUM_CPUS-1} --set podTypes.rayWorkerType.GPU=${NUM_GPUS-1} --set podTypes.rayHeadType.memory=${HEAD_MEMORY-1Gi} --set podTypes.rayWorkerType.memory=${WORKER_MEMORY-1Gi} --set podTypes.rayWorkerType.minWorkers=${MIN_WORKERS-2} --set podTypes.rayWorkerType.maxWorkers=${MAX_WORKERS-3} --set image=${RAY_IMAGE}
```

## Wait for Ray Head Node

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} wait pod -n ${RAY_KUBE_NS} -l cluster.ray.io/component=mycluster-ray-head --for=condition=Ready --timeout=600s | grep -v 'no matching resources' && break
    sleep 1
done
```

## The name of the Ray Kubernetes Service

```shell
export RAY_KUBE_CLUSTER_NAME=mycluster
```

```shell
export RAY_KUBE_SERVICE=service/mycluster-ray-head
```

## The local port to use for `ray` operations

Here, we try to avoid using the default port for a local Ray instance.

```shell
export RAY_KUBE_PORT=8266
```
## The URL to use for `ray` operations

```shell
export RAY_ADDRESS="http://127.0.0.1:$RAY_KUBE_PORT"
```

```shell
echo "RAY_KUBE_PORT=$RAY_KUBE_PORT"
echo "RAY_ADDRESS=$RAY_ADDRESS"
```

## Start up a Kubernetes port-forward to the cluster

```shell
PID=$(ps aux | grep -v grep | grep 'port-forward service/mycluster-ray-head' | awk '{print $2}')
[ -n "$PID" ] && kill $(ps aux | grep -v grep | grep 'port-forward service/mycluster-ray-head' | awk '{print $2}')
kubectl --context ${KUBE_CONTEXT} -n ${RAY_KUBE_NS} port-forward $RAY_KUBE_SERVICE $RAY_KUBE_PORT:8265 > /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME} &
while true; do if [ -f /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME} ] && [ "$(cat /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

## Wait for at least one Worker to be Ready

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} wait pod -n ${RAY_KUBE_NS} -l ray-user-node-type=rayWorkerType --for=condition=Ready --timeout=600s && break
    sleep 1
done
```
