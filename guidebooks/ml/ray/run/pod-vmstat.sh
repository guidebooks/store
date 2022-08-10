if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/pod-vmstat.txt > "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
    exit
fi

# staggered starts
sleep 0.$(shuf -i 5000-7000 -n1)

if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "sleep 0.\$(shuf -i 100-2000 -n1); kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"vmstat 2 --timestamp | awk -Winteractive -v pod=\\\$(hostname) 'FNR==1 {x=substr(pod,length(\\\"Hostname\\\") + 1); gsub(/./, \\\"-\\\", x); print \\\"Hostname \\\" x,\\\$0} FNR>1 {print pod,\\\$0}'\"" \
    >> "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
