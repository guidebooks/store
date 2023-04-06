if [ -z "$STREAMCONSUMER_EVENTS" ]; then STREAMCONSUMER_EVENTS="/tmp/"; fi

if [ $(uname) = "Darwin" ]; then
    export REPLSIZE="-S5000"
fi

set -x
kubectl get pods ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${TORCHX_INSTANCE_LABEL} -o name \
        --field-selector=status.phase==Running \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "kubectl exec --pod-running-timeout=1h ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- tail -F /tmp/status.txt" \
            >> "${STREAMCONSUMER_EVENTS}job-status.txt"
