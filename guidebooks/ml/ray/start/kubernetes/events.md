# Stream out Events from the Ray Head Node

Kubernetes doesn't give us a great way to filter out events that are
not associated with our job. We pipe to grep here to work around that. 

> Without `--line-buffered`, output is batched up by the `tee`? :(

```shell.async
kubectl get events ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} --watch | awk -Winteractive -v id=$JOB_ID 'index($4, id)>0 {sub(/^[0-9]+s[ ]+/, ""); print "\x1b[1;2;36m[Cluster Event] \x1b[0;2m" $0 "\x1b[0m"; fflush()}' | sed -lE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//g'
```

```shell.async
if [ -n "$DEBUG_KUBERNETES" ]; then
    echo "Streaming out Ray Pod Logs"
    kubectl logs ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ray-cluster-name=${RAY_KUBE_CLUSTER_NAME} -f
fi
```
