# staggered starts
sleep 0.$(shuf -i 10000-11000 -n1)

if [ $(uname) = "Darwin" ]; then export REPLSIZE="-S5000"; fi

kubectl get pod -l ${KUBE_PODFULL_LABEL_SELECTOR} --context ${KUBE_CONTEXT} -n ${KUBE_NS} -o name \
    | xargs ${REPLSIZE} -P128 -I {} -n1 \
            sh -c "sleep 0.\$(shuf -i 100-2000 -n1); kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} {} -- sh -c \"while true; do echo \\\"\\\$(hostname) \\\$(cat /sys/fs/cgroup/memory/memory.usage_in_bytes) \\\$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)\\\"; sleep 10; done\"" \
    >> "${STREAMCONSUMER_RESOURCES}pod-memory.txt"
