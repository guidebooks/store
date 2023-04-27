# Stream out Ray Job Logs

Here, we use `kubectl exec` to stream out Ray job logs.

```shell
# Stream out Ray Logs

kubectl logs ${RAY_HEAD_POD} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f --all-containers \
    | tee "${STREAMCONSUMER_LOGS}job.txt"
```
