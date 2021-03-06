if [ -z "$KUBE_CONTEXT" ] || [ -z "$KUBE_NS" ]; then exit; fi

while true; do
    sleep 10

    echo -e "Sample $(date -Iseconds)" >> "${STREAMCONSUMER_RESOURCES}pod-stats.txt"
    kubectl get pod --context ${KUBE_CONTEXT} -n ${KUBE_NS} \
            -l ${KUBE_PODFULL_LABEL_SELECTOR} \
            -o custom-columns='NAME:.metadata.name,GPUReq:.spec.containers[0].resources.requests.nvidia\.com/gpu,CPUReq:.spec.containers[0].resources.requests.cpu,MemReq:.spec.containers[0].resources.requests.memory' \
            >> "${STREAMCONSUMER_RESOURCES}pod-stats.txt"
    echo >> "${STREAMCONSUMER_RESOURCES}pod-stats.txt"
done
