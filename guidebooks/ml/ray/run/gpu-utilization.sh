kubectl get pod -l ${KUBE_POD_LABEL_SELECTOR} --context ${KUBE_CONTEXT} -n ${KUBE_NS} -o name \
    | xargs -I {} -n1 kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} {} -- \
            sh -c "nvidia-smi -q -d UTILIZATION -lms 5000 | awk -W interactive -F '           :' '/Gpu/ {print \"\n\033[31m\" \"Gpu Utilization:\", \$2 \"\033[0m\"}'"
