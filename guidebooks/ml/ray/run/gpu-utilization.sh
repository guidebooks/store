if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

if [ -z "$STREAMCONSUMER_RESOURCES" ]; then STREAMCONSUMER_RESOURCES="/tmp/"; fi

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
        --field-selector=status.phase==Running \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "sleep 0.\$(shuf -i 100-2000 -n1); kubectl exec --pod-running-timeout=1h ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"nvidia-smi --query-gpu=timestamp,utilization.gpu,utilization.memory,memory.total,temperature.gpu,name --format=csv,noheader -l 10 | awk -Winteractive -v pod=\\\$(hostname) -F, '{sub(/ /, \\\"T\\\", \\\$1); printf \\\"\\\x1b[1;31m[GPU Utilization %4.1f%%] \\\x1b[0;31m%s \\\x1b[0;2;31m%s \\\x1b[0;31m%s\\\n\\\", \\\$2, pod, \\\$6, \\\$1; printf \\\"\\\x1b[1;31m[Mem Utilization %4.1f%%] \\\x1b[0;31m%s \\\x1b[0;2;31m%s \\\x1b[0;31m%s\\\n\\\", \\\$3, pod, \\\$4, \\\$1; printf \\\"\\\x1b[1;31m[Temp Current %4.1fC] \\\x1b[0;31m%s \\\x1b[0;31m%s\\\n\\\", \\\$5, pod, \\\$1; fflush(); }'\"" \
        > "${STREAMCONSUMER_RESOURCES}gpu.txt"
