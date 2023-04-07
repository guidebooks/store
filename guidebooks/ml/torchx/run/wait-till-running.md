---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
    - ./instance-label
---

# Wait till Torchx Pods are Running

```shell
# Wait till Torchx Pods are Running

ITER=0
while true; do
    N=$(kubectl get pod --no-headers ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${TORCHX_INSTANCE_LABEL} 2>/dev/null | grep torchx | wc -l | sed -e 's/^[[:space:]]*//' || echo 0)
    if [[ $MAX_WORKERS = $N ]]; then break; fi

    if [[ $(($ITER % 10)) = 0 ]]; then echo "⌛ Waiting for PyTorch Workers"; fi
    ITER=$(($ITER + 1))
    sleep 1
done

echo "Waiting for Torchx workers to be running"
kubectl wait pod \
    --timeout=-1s \
    --for=condition=Ready \
    ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
    -l ${TORCHX_INSTANCE_LABEL}
```
