if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/pod-memory.txt > "${STREAMCONSUMER_RESOURCES}pod-memory.txt"
    exit
fi

# staggered starts
# sleep 0.$(shuf -i 10000-11000 -n1)

if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

if [ -z "$STREAMCONSUMER_RESOURCES" ]; then STREAMCONSUMER_RESOURCES="/tmp/"; fi

# Use the user's timezone, to help with readability
TZ=$(date +%Z)

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
        --field-selector=status.phase==Running \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "kubectl exec --pod-running-timeout=1h ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"while true; do echo \\\"\\\$(hostname) \\\$(cat /sys/fs/cgroup/memory/memory.usage_in_bytes 2> /dev/null || cat /sys/fs/cgroup/memory.current) \\\$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes 2> /dev/null || cat /sys/fs/cgroup/memory.max)\\\" | awk -Winteractive -v now=\\\"\\\$(TZ=$TZ date +'%Y-%m-%d %H:%M:%S %Z')\\\" '{printf(\\\"\\\x1b[34m%s %13s %13s   [Mem Utilization %5.1f%%] %s\\\x1b[0m\\\n\\\", \\\$1, \\\$2, \\\$3, 100*\\\$2/\\\$3, now)}'; sleep 5; done\"" \
    | sed -lE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//g' \
    | tee -a "${STREAMCONSUMER_RESOURCES}pod-memory.txt" \
    1>&2
