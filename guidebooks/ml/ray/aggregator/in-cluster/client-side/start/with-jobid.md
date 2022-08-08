---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

# Start a Log Aggregation Instance (client-side, given JOB_ID)

This guidebook communicates with previously deployed (via
`./deploy.md`) log aggregator pod to start streaming. It assumes the
`JOB_ID` environment variable has already been set.

TODO this does not belong here?
```shell
export LOG_AGGREGATOR_POD_NAME=guidebook-log-aggregator
```

First, wait for the aggregator pod to be ready.
```shell
kubectl wait ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/${LOG_AGGREGATOR_POD_NAME} --for=condition=Ready
```

Now we can stream.
```shell
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- env JOB_ID=$JOB_ID codeflare
```

