# Stream out Ray Job Logs

Here, we use `kubectl exec` to stream out Ray job logs.

```shell
# Stream out Ray Logs

TAIL=-1
while true; do
    kubectl logs ${RAY_HEAD_POD} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f --all-containers --tail=$TAIL \
        | tee "${STREAMCONSUMER_LOGS}job.txt" && break

    state=$(kubectl get pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${RAY_HEAD_POD} --no-headers -o custom-columns=STATUS:.status.phase || echo "Error")
    if [[ "$state" != "Running" ]] && [[ "$state" != "Pending" ]]; then
      # the underlying pod is no longer running, we can give up
      break
    fi

    TAIL=0
    sleep 1
done
```
