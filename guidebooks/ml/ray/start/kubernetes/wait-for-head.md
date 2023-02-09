---
imports:
    - ml/ray/start/kubernetes/label-selectors
---

```shell
while true; do
    kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} | grep Running > /dev/null && break || echo "Waiting for Ray Head node"
    sleep 1
done

kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --for=condition=Ready --timeout=240s && \
    echo "Head node is ready"
```
