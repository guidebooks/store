if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/pod-stats.txt > "${STREAMCONSUMER_RESOURCES}pod-stats.txt"
    exit
fi

while true; do
    sleep 10

    echo -e "Sample $(date -Iseconds)" >> "${STREAMCONSUMER_RESOURCES}pod-stats.txt"
    kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
            -l ${KUBE_PODFULL_LABEL_SELECTOR} \
            -o custom-columns='NAME:.metadata.name,GPUReq:.spec.containers[0].resources.requests.nvidia\.com/gpu,CPUReq:.spec.containers[0].resources.requests.cpu,MemReq:.spec.containers[0].resources.requests.memory' \
            >> "${STREAMCONSUMER_RESOURCES}pod-stats.txt"
    echo >> "${STREAMCONSUMER_RESOURCES}pod-stats.txt"
done
