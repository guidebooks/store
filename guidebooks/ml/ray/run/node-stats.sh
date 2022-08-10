if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/node-stats.txt > "${STREAMCONSUMER_RESOURCES}node-stats.txt"
    exit
fi

while true; do
    sleep 10

    echo -e "Sample $(date -Iseconds)" >> "${STREAMCONSUMER_RESOURCES}node-stats.txt"
    kubectl get node ${KUBE_CONTEXT_ARG} \
            -o custom-columns='NAME:.metadata.name,GPUCap:.status.capacity.nvidia\.com/gpu,GPUFree:.status.allocatable.nvidia\.com/gpu,CPUCap:.status.capacity.cpu,CPUFree:.status.allocatable.cpu,MemCap:.status.capacity.memory,MemFree:.status.allocatable.memory,DiskCap:.status.capacity.ephemeral-storage,DiskFree:.status.allocatable.ephemeral-storage,Type:.metadata.labels.beta\.kubernetes\.io/instance-type' \
            >> "${STREAMCONSUMER_RESOURCES}node-stats.txt"
    echo >> "${STREAMCONSUMER_RESOURCES}node-stats.txt"
done
