kubectl annotate namespace ${KUBE_NS} ${KUBE_CONTEXT_ARG} --overwrite openshift.io/sa.scc.uid-range=1000/10000 \
    || oc annotate project ${KUBE_NS} ${KUBE_CONTEXT_ARG} --overwrite openshift.io/sa.scc.uid-range=1000/10000
