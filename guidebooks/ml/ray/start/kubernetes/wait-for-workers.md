# Wait for at least one Worker to be Ready

```shell
if [ "$MAX_WORKERS" -gt "0" ]; then
    while true; do
        kubectl ${KUBE_CONTEXT_ARG} get pod ${KUBE_NS_ARG} -l ${KUBE_POD_LABEL_SELECTOR} | grep Running > /dev/null && break || echo "Waiting for Ray Worker nodes"
        sleep 1
    done

    kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_LABEL_SELECTOR} --for=condition=Ready --timeout=-1s && \
        echo "Worker node is ready"
fi
```
