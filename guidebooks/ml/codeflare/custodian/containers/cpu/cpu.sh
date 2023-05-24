#!/usr/bin/env bash

while true; do
    kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} -o name \
            --field-selector=status.phase==Running \
        | xargs -P512 -I {} -n1 \
                sh -c 'kubectl exec {} -- sh -c "while true; do echo \"timestamp \\\$(date -u)\"; echo \"nanos \\\$(date +%s%N)\"; cat /sys/fs/cgroup/cpu.stat; echo ------; sleep 1; done" | awk -v pod={} -f /tmp/cpu.awk'

    if [[ "\$(kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} 2>&1)" =~ "No resources found" ]]; then break; fi
    sleep 1
done
