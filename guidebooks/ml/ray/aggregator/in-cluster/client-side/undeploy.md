---
imports:
    - kubernetes/choose/ns
---

# Delete a Log Aggregator from your Kubernetes Cluster

```shell
cat << EOF | kubectl delete ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./aggregator.yaml"
EOF
```
