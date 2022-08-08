---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
    - ../names
---

# Start a Log Aggregation Instance (client-side, given JOB_ID)

This guidebook communicates with previously deployed (via
`./deploy.md`) log aggregator pod to start streaming. It assumes the
`JOB_ID` environment variable has already been set.

First, wait for the aggregator pod to be ready.
```shell
kubectl wait ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/${LOG_AGGREGATOR_POD_NAME} --for=condition=Ready
```

Now we can stream.
```shell
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${LOG_AGGREGATOR_POD_NAME} -- env JOB_ID=$JOB_ID codeflare
```

