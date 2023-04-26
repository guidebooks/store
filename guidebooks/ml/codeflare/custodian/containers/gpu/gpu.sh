#!/usr/bin/env bash

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} -o name \
        --field-selector=status.phase==Running \
    | xargs -P512 -I {} -n1 \
            sh -c 'kubectl exec {} -- sh -c "nvidia-smi --query-gpu=timestamp,utilization.gpu,utilization.memory,memory.total,temperature.gpu,name --format=csv,noheader -l 10" | awk -v pod={} -F, -f /tmp/gpu.awk' \
            2> /dev/null
