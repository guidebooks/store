# Stream out Ray Job Logs

Here, we use `kubectl exec` to stream out Ray job logs.

> Note: we issue two separate log streamers, because
> `--all-containers` is erratic in some clusters. Odd spurious
> disconnects can result, depending on the cluster version and the
> `kubectl` version.

```shell.async
# Stream out Ray Head Setup Logs

kubectl logs ${RAY_HEAD_POD} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -c ray-head \
    | tee -a "${STREAMCONSUMER_LOGS}job.txt"
```

```shell
# Stream out Ray Logs

kubectl logs ${RAY_HEAD_POD} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -c logs \
    | tee -a "${STREAMCONSUMER_LOGS}job.txt"
```
