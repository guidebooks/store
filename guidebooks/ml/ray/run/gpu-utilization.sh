if [ -n "$LOG_AGGREGATOR_POD_NAME" ] && [ -n "$LOG_AGGREGATOR_LOGDIR" ]; then
    kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- \
            wait-for-and-tailf "$LOG_AGGREGATOR_LOGDIR"/resources/gpu.txt > "${STREAMCONSUMER_RESOURCES}gpu.txt"
    exit
fi


if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

if [ -z "$QUIET_CONSOLE" ]; then
    kubectl get pod -l ${KUBE_POD_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
        | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "sleep 0.\$(shuf -i 100-2000 -n1); kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"nvidia-smi --query-gpu=timestamp,utilization.gpu,utilization.memory,memory.total,temperature.gpu,name --format=csv,noheader -l 2 | awk -Winteractive -v pod=\\\$(hostname) -F, '{printf \\\"\n\033[31;1m%s \033[0;31mGPUType\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$6, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mUtilization.GPU\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$2, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mUtilization.Memory\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$3, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mMemory.Total\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$4, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mTemperature.GPU\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$5, pod, \\\$1; }'\"" \
            | tee "${STREAMCONSUMER_RESOURCES}gpu.txt"
else
    kubectl get pod -l ${KUBE_POD_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
        | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "sleep 0.\$(shuf -i 100-2000 -n1); kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} -- sh -c \"nvidia-smi --query-gpu=timestamp,utilization.gpu,utilization.memory,memory.total,temperature.gpu,name --format=csv,noheader -l 2 | awk -Winteractive -v pod=\\\$(hostname) -F, '{printf \\\"\n\033[31;1m%s \033[0;31mGPUType\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$6, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mUtilization.GPU\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$2, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mUtilization.Memory\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$3, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mMemory.Total\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$4, pod, \\\$1; printf \\\"\033[31;1m%s \033[0;31mTemperature.GPU\t\t\t\033[0;2m%s %s\033[0m\n\\\", \\\$5, pod, \\\$1; }'\"" \
            > "${STREAMCONSUMER_RESOURCES}gpu.txt"
fi
