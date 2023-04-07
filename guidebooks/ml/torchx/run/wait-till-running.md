---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
    - ./instance-label
---

# Wait till Torchx Pods are Running

```shell
# Wait till Torchx Pods are Running

function status() {
    local N=$1
    local L=$(($MAX_WORKERS - $N))

    echo -n "Scheduled Workers $N/$MAX_WORKERS "
        
    if [[ $N > 0 ]]; then for i in $(seq 1 $N); do echo -en '\x1b[36m■\x1b[0m'; done; fi
    if [[ $L > 0 ]]; then for i in $(seq 1 $L); do echo -en '\x1b[2m■\x1b[0m'; done; fi
    echo ""
}

echo "⌛ Waiting for Torchx workers to be scheduled"
ITER=0
while true; do
    N=$(kubectl get pod --no-headers ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${TORCHX_INSTANCE_LABEL} 2>/dev/null | grep torchx | wc -l | sed -e 's/^[[:space:]]*//')

    if [[ $MAX_WORKERS = $N ]]
    then break
    elif [[ $(($ITER % 5)) = 0 ]]; then status $N; fi

    ITER=$(($ITER + 1))
    sleep 1
done

status $N
echo "⌛ Waiting for Torchx workers to be running"
kubectl wait pod \
    --timeout=-1s \
    --for=condition=Ready \
    ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
    -l ${TORCHX_INSTANCE_LABEL}
```
