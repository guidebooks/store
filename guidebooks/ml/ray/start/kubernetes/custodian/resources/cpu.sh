#!/usr/bin/env bash

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} -o name \
        --field-selector=status.phase==Running \
    | xargs -P512 -I {} -n1 \
            sh -c 'kubectl exec {} -- sh -c "TZ=UTC vmstat --timestamp 5" | awk -v pod={} -f /tmp/cpu.awk'
