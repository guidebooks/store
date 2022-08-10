if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/pod-memory.txt > "${STREAMCONSUMER_RESOURCES}pod-memory.txt"
    exit
fi

# staggered starts
sleep 0.$(shuf -i 10000-11000 -n1)

if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "sleep 0.\$(shuf -i 100-2000 -n1); kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"while true; do echo \\\"\\\$(hostname) \\\$(cat /sys/fs/cgroup/memory/memory.usage_in_bytes) \\\$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)\\\"; sleep 10; done\"" \
    >> "${STREAMCONSUMER_RESOURCES}pod-memory.txt"
