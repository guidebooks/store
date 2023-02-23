if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/pod-vmstat.txt > "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
    exit
fi

# staggered starts
# sleep 0.$(shuf -i 5000-7000 -n1)

if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

# Use the user's timezone, to help with readability
TZ=$(date +%Z)

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"TZ=$TZ vmstat --timestamp 5 | awk -Winteractive -v timezone=$TZ -v pod=\\\$(hostname) 'FNR>2 {printf(\\\"%s %14s %2s %2s %2s %2s %2s [CPU Utilization %5.1f%%] %s %s %s\\\n\\\", pod, \\\$4, \\\$13, \\\$14, \\\$15, \\\$16, \\\$17, \\\$13+\\\$14, \\\$(NF-1), \\\$NF, timezone)}'\"" \
    | sed -lE 's/^(ray-[^-]+-[^-]+)-[a-z0-9-]+(.+)$/\x1B[33m\1\2\x1B[0m/' \
    | grep --line-buffered -v timestamp \
    | tee -a "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt" \
    1>&2
