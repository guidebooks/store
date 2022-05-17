---
imports:
    - ../../../kubernetes/kubectl.md
    - ../../../kubernetes/helm3.md
    - ../../../kubernetes/context.md
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.

```shell
---
validate: kubectl get rayclusters -n ray | grep -v 'No resources'
---
echo "$(tput setaf 4)Cloning ray repo$(tput sgr0)"
T=$(mktemp -d)
cd $T
git clone --filter=tree:0 --depth 1 --sparse git@github.com:ray-project/ray.git >& /dev/null
cd ray
git sparse-checkout init --cone >& /dev/null
git sparse-checkout set deploy/charts/ray >& /dev/null
echo "$(tput setaf 4)Creating ray cluster$(tput sgr0)"
helm -n ray upgrade --install --wait --timeout 30m example-cluster --create-namespace deploy/charts/ray
```

## The name of the Ray Kubernetes Service

```shell
export RAY_KUBE_SERVICE=service/example-cluster-ray-head
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
PID=$(ps aux | grep -v grep | grep 'port-forward service/example-cluster-ray-head' | awk '{print $2}')
[ -n "$PID" ] && kill $(ps aux | grep -v grep | grep 'port-forward service/example-cluster-ray-head' | awk '{print $2}')
kubectl -n ray port-forward $RAY_KUBE_SERVICE $RAY_KUBE_PORT:8265 &
sleep 4
```
