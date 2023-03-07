if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/pod-vmstat.txt > "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
    exit
fi

# staggered starts
# sleep 0.$(shuf -i 5000-7000 -n1)

if [ $(uname) = "Darwin" ]; then
    export REPLSIZE="-S5000"
fi

if [ -z "$STREAMCONSUMER_RESOURCES" ]; then STREAMCONSUMER_RESOURCES="/tmp/"; fi

# Use the user's timezone, to help with readability
TZ=$(date +%Z)

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
        --field-selector=status.phase==Running \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "kubectl exec --pod-running-timeout=1h ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"TZ=$TZ vmstat --timestamp 5 | awk -Winteractive -v timezone=$TZ -v pod=\\\$(hostname | sed -E 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//') '\\\$NF !~ /timestamp/ && \\\$3 != \\\"swpd\\\" {printf(\\\"\\\x1b[1;33m[CPU Utilization %5.1f%%] \\\x1b[0;33m%-30s \\\x1b[2m%14s %2s %2s %2s %2s %2s %s %s %s\\\x1b[0m\\\n\\\", \\\$13+\\\$14, pod, \\\$4, \\\$13, \\\$14, \\\$15, \\\$16, \\\$17, \\\$(NF-1), \\\$NF, timezone)}'\"" \
    | tee -a "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt" \
    1>&2
