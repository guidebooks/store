while true; do
    sleep 10

    kubectl get node --context ${KUBE_CONTEXT} --watch \
            -o custom-columns='NAME:.metadata.name,GPUCap:.status.capacity.nvidia\.com/gpu,GPUFree:.status.allocatable.nvidia\.com/gpu,CPUCap:.status.capacity.cpu,CPUFree:.status.allocatable.cpu,MemCap:.status.capacity.memory,MemFree:.status.allocatable.memory,DiskCap:.status.capacity.ephemeral-storage,DiskFree:.status.allocatable.ephemeral-storage,Type:.metadata.labels.beta\.kubernetes\.io/instance-type' \
        | while read line ; do echo -e "$(date +"%Y-%m-%d %H:%M:%S")\t $line" ; done \
              >> "${STREAMCONSUMER_RESOURCES}node-stats.txt"
done
