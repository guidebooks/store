---
imports:
    - kubernetes/choose/ns
finally:
    - ./cleanup
---

# Provision a Self-destruct for our Helm Chart

```shell
cat << EOF | kubectl apply $KUBE_CONTEXT_ARG $KUBE_NS_ARG -f -
--8<-- "./self-destruct.yaml"
EOF
```

