if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/pod-vmstat.txt > "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
    exit
fi

# staggered starts
# sleep 0.$(shuf -i 5000-7000 -n1)

if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"vmstat 5 --timestamp | awk -Winteractive -v pod=\\\$(hostname) 'FNR>2 {printf(\\\"%s %2s %2s %2s %2s %2s        %5.2f%% [CPU Utilization]\\\n\\\", pod, \\\$13, \\\$14, \\\$15, \\\$16, \\\$17, \\\$13+\\\$14)}'\"" \
    | sed -lE 's/^ray-.+-(ray-.+)$/\x1B[33m\1\x1B[0m/' \
    | tee -a "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
