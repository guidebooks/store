---
imports:
    - ./resources
    - ml/torchx/install/path
---

```shell
export HELM_ROLL_YOUR_OWN=$(mktemp)
```

```shell
--8<-- "ml/torchx/install/activate.sh"
--8<-- "./start.sh"
```

```shell
export RAY_KUBE_CLUSTER_NAME=$(cat $HELM_ROLL_YOUR_OWN | grep -A2 'kind: AppWrapper' | grep name: | sed 's/  name: //')
```

```shell
export KUBE_POD_MANAGER=mcad
```
