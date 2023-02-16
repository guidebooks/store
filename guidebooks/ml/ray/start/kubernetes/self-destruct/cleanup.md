---
imports:
    - kubernetes/choose/ns
---

# Uninstall a Self-destruct for our Helm Chart

```shell
---
validate: |
  kubectl get $KUBE_CONTEXT_ARG $KUBE_NS_ARG job $RAY_KUBE_CLUSTER_NAME-self-destruct && exit 1 || exit 0
---
kubectl delete $KUBE_CONTEXT_ARG $KUBE_NS_ARG job $RAY_KUBE_CLUSTER_NAME-self-destruct || exit 0
```

