---
imports:
    - kubernetes/choose/ns
---

# Deploy a Log Aggregator to your Kubernetes Cluster

```shell
cat << EOF | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./aggregator.yaml"
EOF
```
