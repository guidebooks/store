---
imports:
    - ml/ray/start/kubernetes/label-selectors
---

# Wait for at least Ray Head to be Ready

```shell
ITER=0
while true; do
    if kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --for=condition=Ready --timeout=-1s
    then break
    fi

    if [[ $(($ITER % 10)) = 0 ]]; then echo "⌛ Waiting for Ray Head"; fi
    ITER=$(($ITER + 1))
    sleep 1
done

echo "🚀 Ray Head is ready"
```
