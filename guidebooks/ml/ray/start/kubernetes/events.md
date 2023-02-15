# Stream out Events from the Ray Head Node

Kubernetes doesn't give us a great way to filter out events that are
not associated with our job. We pipe to grep here to work around that. 

> Without `--line-buffered`, output is batched up by the `tee`? :(

```shell.async
kubectl get events ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o wide --watch-only | grep --line-buffered ${JOB_ID} | tee "${STREAMCONSUMER_EVENTS-/tmp/}kubernetes.txt"
```

```shell.async
if [ -n "$DEBUG_KUBERNETES" ]; then
    echo "Streaming out Ray Pod Logs"
    kubectl logs ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ray-cluster-name=${RAY_KUBE_CLUSTER_NAME} -f
fi
```
