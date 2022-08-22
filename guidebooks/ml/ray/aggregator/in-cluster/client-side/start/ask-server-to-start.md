This guidebook communicates with previously deployed (via
`./deploy.md`) log aggregator pod to start streaming. It assumes the
`JOB_ID` environment variable has already been set.

First, wait for the aggregator pod to be ready.
```shell
kubectl wait ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/${LOG_AGGREGATOR_POD_NAME} --for=condition=Ready
```

Now we can stream.
```shell.async
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- env GUIDEBOOK_NAME=log-aggregator-server-side JOB_ID=$JOB_ID codeflare -V ml/ray/aggregator/in-cluster/server-side/start
```
