---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

# Uninstall a Self-destruct for our Helm Chart

```shell
if [ -z "$RAY_KUBE_CLUSTER_NAME" ]; then exit; fi

kubectl delete --ignore-not-found $KUBE_CONTEXT_ARG $KUBE_NS_ARG job $RAY_KUBE_CLUSTER_NAME-self-destruct
```

