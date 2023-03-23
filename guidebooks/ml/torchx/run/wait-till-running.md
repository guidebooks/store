---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
    - ./instance-label
---

# Wait till Torchx Pods are Running

```shell
ITER=0
while true; do
    if kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${TORCHX_INSTANCE_LABEL} 2>/dev/null | grep -q torchx; then break; fi

    if [[ $(($ITER % 10)) = 0 ]]; then echo "⌛ Waiting for PyTorch Workers"; sleep 1; fi
    ITER=$(($ITER + 1))
done

echo "Waiting for Torchx workers to be running"
kubectl wait pod \
    --timeout=-1s \
    --for=condition=Ready \
    ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
    -l ${TORCHX_INSTANCE_LABEL}
```
