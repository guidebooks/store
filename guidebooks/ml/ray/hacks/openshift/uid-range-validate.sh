if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then
    X=$(kubectl get ns ${KUBE_NS} ${KUBE_CONTEXT_ARG} -o json || oc get project ${KUBE_NS} ${KUBE_CONTEXT_ARG} -o json)
    if [ $(echo "$X" | jq -r '.metadata.annotations."openshift.io/sa.scc.uid-range"') = "1000/10000" ]; then
       exit 0
    fi
fi

exit 1
