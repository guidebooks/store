kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} --context ${KUBE_CONTEXT} -n ${KUBE_NS} -o name \
    | xargs -P128 -I {} -n1 kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} {} -- \
            sh -c "while true; do echo \"\$(hostname) \$(cat /sys/fs/cgroup/memory/memory.usage_in_bytes) \$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)\"; sleep 10; done" \
    >> "${STREAMCONSUMER_RESOURCES}pod-memory.txt"
