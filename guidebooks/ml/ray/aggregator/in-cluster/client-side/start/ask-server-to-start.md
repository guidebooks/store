This guidebook communicates with previously deployed (via
`./deploy.md`) log aggregator pod to start streaming. It assumes the
`JOB_ID` environment variable has already been set.

First, wait for the aggregator pod to be ready.
```shell
echo "[Log Aggregator Start Client-side] Waiting for log aggregator" 1>&2
kubectl wait ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/${LOG_AGGREGATOR_POD_NAME} --for=condition=Ready --timeout=240s
```

Now we can stream.
```shell.async
echo "[Log Aggregator Start Client-side] Starting server side" 1>&2
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- env GUIDEBOOK_NAME=log-aggregator-server-side JOB_ID=$JOB_ID codeflare -V ml/ray/aggregator/in-cluster/server-side/start
echo "[Log Aggregator Start Client-side] Starting server [done]" 1>&1
```
