---
imports:
    - ml/ray/start/kubernetes/label-selectors
---

```shell
ITER=0
while true; do
    if kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} | grep -q ray; then break; fi

    if [[ $(($ITER % 10)) = 0 ]]; then echo "⌛ Waiting for Ray Head"; sleep 1; fi
    ITER=$(($ITER + 1))
done

kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --for=condition=Ready --timeout=-1s && \
    echo "🚀 Ray Head is ready"
```
