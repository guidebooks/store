kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} --context ${KUBE_CONTEXT} -n ${KUBE_NS} -o name \
    | xargs -P128 -I {} -n1 kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} {} -- \
            sh -c "vmstat 2 --timestamp | awk -Winteractive -v pod=\$(hostname) 'FNR==1 {x=substr(pod,length(\"Hostname\") + 1); gsub(/./, \"-\", x); print \"Hostname \" x,\$0} FNR>1 {print pod,\$0}'" \
    >> "${STREAMCONSUMER_RESOURCES}pod-vmstat.txt"
