kubectl get pod -l ${KUBE_POD_LABEL_SELECTOR} --context ${KUBE_CONTEXT} -n ${KUBE_NS} -o name \
    | xargs -P0 -I {} -n1 kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} {} -- \
            sh -c "nvidia-smi -q -d UTILIZATION,MEMORY -lms 5000 | awk -W interactive -v IDX={} -F : '\$1 ~ /Timestamp/ { ts=\$2 \":\" \$3 \":\" \$4 } /Total/ && total==0 {total=1;sub(/^ +/, \"\", \$1); print \"\033[31;1m\" \$2, \"Memory\", \$1, \"\033[0m\", IDX, ts } /(Gpu|Memory).+%$/ {sub(/^ +/, \"\", \$1); print \"\033[31;1m\" \$2, \"Utilization\", \$1, \"\033[0m\", IDX, ts}'"
