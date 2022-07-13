if [ -z "$KUBE_CONTEXT" ] || [ -z "$KUBE_NS" ]; then exit; fi

# staggered starts
sleep 0.$(shuf -i 5000-7000 -n1)

if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} --context ${KUBE_CONTEXT} -n ${KUBE_NS} -o name \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "sleep 0.\$(shuf -i 100-2000 -n1); kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} {} -- sh -c \"vmstat 2 --timestamp | awk -Winteractive -v pod=\\\$(hostname) 'FNR==1 {x=substr(pod,length(\\\"Hostname\\\") + 1); gsub(/./, \\\"-\\\", x); print \\\"Hostname \\\" x,\\\$0} FNR>1 {print pod,\\\$0}'\"" \
    >> "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
