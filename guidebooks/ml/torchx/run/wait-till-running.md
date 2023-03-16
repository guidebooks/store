---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
    - ./instance-label
---

# Wait till Torchx Pods are Running

```shell
while true; do
    kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${TORCHX_INSTANCE_LABEL} | grep Running > /dev/null && break || echo "Waiting for Torchx workers to be deployed"
    sleep 2
done

echo "Waiting for Torchx workers to be running"
kubectl wait pod \
    --timeout=-1s \
    --for=condition=Ready \
    ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
    -l ${TORCHX_INSTANCE_LABEL}
```
