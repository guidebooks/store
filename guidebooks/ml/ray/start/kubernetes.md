---
imports:
    - kubernetes/kubectl
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
    - ./resources.md
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.

--8<-- "../hacks/openshift/uid-range.md"

### Stream out Events from the Ray Head Node

```shell.async
kubectl get events --context ${KUBE_CONTEXT} -n ${KUBE_NS} --watch-only | tee "${STREAMCONSUMER_EVENTS}kubernetes.txt"
```

### Use Helm to create the Ray Cluster

```shell
---
validate: |
  if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then X=$(kubectl --context ${KUBE_CONTEXT} get raycluster mycluster -n ${KUBE_NS} -o json 2>&1); echo "$X" | grep -v 'No resources' && echo "$X" | grep -v 'not found' && [ $(echo "$X" | jq '.spec.podTypes | .[] | select(.name=="rayWorkerType") | .podConfig.spec.containers[0].resources.requests.cpu') = ${NUM_CPUS-1} ]; else exit 1; fi
---
echo "$(tput setaf 4)Cloning ray repo$(tput sgr0)"
T=$(mktemp -d)
cd $T
git clone --filter=tree:0 --depth 1 --sparse https://github.com/ray-project/ray.git >& /dev/null
cd ray
git sparse-checkout init --cone >& /dev/null
git sparse-checkout set deploy/charts/ray >& /dev/null

if [ -z "${RAY_IMAGE}" ]; then
    if [ "${NUM_GPUS}" != 0 ]
    then RAY_IMAGE=rayproject/ray-ml:1.12.2-py37-gpu
    else RAY_IMAGE=rayproject/ray:latest
    fi
fi

echo "$(tput setaf 4)Creating ray cluster num_cpus=$(tput setaf 5)${NUM_CPUS-1} $(tput setaf 4)num_gpus=$(tput setaf 5)${NUM_GPUS-1} $(tput setaf 4)head_memory=$(tput setaf 5)${HEAD_MEMORY-1Gi} $(tput setaf 4)worker_memory=$(tput setaf 5)${WORKER_MEMORY-1Gi} $(tput setaf 4)minWorkers=$(tput setaf 5)${MIN_WORKERS-2} $(tput setaf 4)maxWorkers=$(tput setaf 5)${MAX_WORKERS-3} $(tput setaf 4)image=$(tput setaf 5)${RAY_IMAGE} $(tput setaf 4)context=$(tput setaf 5)${KUBE_CONTEXT} $(tput setaf 4)namespace=$(tput setaf 5)${KUBE_NS}$(tput sgr0)"

helm -n ${KUBE_NS} upgrade --install --wait --timeout 30m mycluster --create-namespace deploy/charts/ray --set podTypes.rayWorkerType.CPU=${NUM_CPUS-1} --set podTypes.rayWorkerType.GPU=${NUM_GPUS-1} --set podTypes.rayHeadType.memory=${HEAD_MEMORY-1Gi} --set podTypes.rayWorkerType.memory=${WORKER_MEMORY-1Gi} --set podTypes.rayWorkerType.minWorkers=${MIN_WORKERS-2} --set podTypes.rayWorkerType.maxWorkers=${MAX_WORKERS-3} --set image=${RAY_IMAGE}
```

## Wait for Ray Head Node

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} wait pod -n ${KUBE_NS} -l ray-user-node-type=rayHeadType --for=condition=Ready --timeout=600s | grep -v 'no matching resources' 2> /dev/null && break || echo "Waiting for Ray Head node"
    sleep 1
done
```

## The name of the Ray Kubernetes Service

```shell
export RAY_KUBE_CLUSTER_NAME=mycluster
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

--8<-- "./kubernetes/port-forward.md"

## Wait for at least one Worker to be Ready

```shell
export KUBE_POD_LABEL_SELECTOR=ray-user-node-type=rayWorkerType
```

```shell
while true; do
    kubectl --context ${KUBE_CONTEXT} wait pod -n ${KUBE_NS} -l ${KUBE_POD_LABEL_SELECTOR} --for=condition=Ready --timeout=600s | grep -v 'no matching resources' && break || echo "Waiting for Ray Worker nodes"
    sleep 1
done
```
