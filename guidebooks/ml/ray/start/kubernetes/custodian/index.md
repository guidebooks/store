---
imports:
    - kubernetes/choose/ns
    - ../label-selectors
---

# Provision a Custodian for our Helm Chart

```shell
cat << EOF | kubectl apply $KUBE_CONTEXT_ARG $KUBE_NS_ARG -f -
--8<-- "./custodian.yaml"
EOF
```

