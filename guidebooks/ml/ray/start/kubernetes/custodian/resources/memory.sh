#!/usr/bin/env bash

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} -o name \
        --field-selector=status.phase==Running \
    | xargs -P512 -I {} -n1 \
            sh -c 'kubectl exec {} -- sh -c "while true; do echo \"\$(cat /sys/fs/cgroup/memory/memory.usage_in_bytes 2> /dev/null || cat /sys/fs/cgroup/memory.current) \$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes 2> /dev/null || cat /sys/fs/cgroup/memory.max) \$(date -u +%Y-%m-%dT%H:%M:%SZ)\"; sleep 5; done" | awk -v pod={} -f /tmp/memory.awk'
