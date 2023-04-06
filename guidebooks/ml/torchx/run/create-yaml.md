---
imports:
    - ml/torchx/install/cli
---

```shell
export HELM_ROLL_YOUR_OWN=$(mktemp)
```

```shell
# Create deployment description using torchx

--8<-- "ml/torchx/install/activate.sh"
--8<-- "./invoke-torchx.sh"
```

```shell
export RAY_KUBE_CLUSTER_NAME=$(cat $HELM_ROLL_YOUR_OWN | grep -A2 'kind: AppWrapper' | grep name: | sed 's/  name: //')
```

```shell
export KUBE_POD_MANAGER=mcad
```
