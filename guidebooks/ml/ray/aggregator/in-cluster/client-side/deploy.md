---
imports:
    - kubernetes/choose/ns
    - ./names
---

# Deploy a Log Aggregator to your Kubernetes Cluster

```shell
---
validate: |
  [ -n "$KUBE_CONTEXT" ] && [ -n "$KUBE_NS" ] && kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME}
---
cat << EOF | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./aggregator.yaml"
EOF
```

Wait for it to be productive.

```shell
kubectl wait ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/${LOG_AGGREGATOR_POD_NAME} --for=condition=Ready
```
