---
imports:
    - ../../../kubernetes/kubectl.md
    - ../../../kubernetes/helm3.md
    - ../../../kubernetes/context.md
    - ./resources.md
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.

```shell
---
validate: kubectl get raycluster mycluster -n ray | grep -v 'No resources' && [ $(kubectl get raycluster mycluster -n ray -o json | jq '.spec.podTypes | .[] | select(.name=="rayWorkerType") | .podConfig.spec.containers[0].resources.requests.cpu') = ${NUM_CPUS-1} ]
---
echo "$(tput setaf 4)Cloning ray repo$(tput sgr0)"
T=$(mktemp -d)
cd $T
git clone --filter=tree:0 --depth 1 --sparse git@github.com:ray-project/ray.git >& /dev/null
cd ray
git sparse-checkout init --cone >& /dev/null
git sparse-checkout set deploy/charts/ray >& /dev/null
echo "$(tput setaf 4)Creating ray cluster num_cpus=$(tput setaf 5)${NUM_CPUS-1} $(tput setaf 4)num_gpus=$(tput setaf 5)${NUM_GPUS-1}$(tput sgr0)"
helm -n ray upgrade --install --wait --timeout 30m mycluster --create-namespace deploy/charts/ray --set podTypes.rayWorkerType.CPU=${NUM_CPUS-1} --set podTypes.rayWorkerType.GPU=${NUM_GPUS-0}
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
kubectl -n ray port-forward $RAY_KUBE_SERVICE $RAY_KUBE_PORT:8265 &
sleep 4
```
