---
imports:
    - kubernetes/choose/ns
---

# Provision a Self-destruct for our Helm Chart

```shell
cat << EOF | kubectl apply $KUBE_CONTEXT_ARG $KUBE_NS_ARG -f -
--8<-- "./self-destruct.yaml"
EOF
```

