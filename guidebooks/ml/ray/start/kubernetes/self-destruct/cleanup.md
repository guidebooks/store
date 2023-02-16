---
imports:
    - kubernetes/choose/ns
---

# Uninstall a Self-destruct for our Helm Chart

```shell
---
validate: kubectl get $KUBE_CONTEXT_ARG $KUBE_NS_ARG job $RAY_KUBE_CLUSTER_NAME-self-destruct
---
kubectl delete $KUBE_CONTEXT_ARG $KUBE_NS_ARG job $RAY_KUBE_CLUSTER_NAME-self-destruct
```

