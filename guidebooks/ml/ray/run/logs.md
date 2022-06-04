# Stream out Ray Job Logs

## Stream GPU Utilization Metrics

We use some bash hacking to `kubectl exec` into each pod that
satisfies the `KUBE_POD_LABEL_SELECTOR` filter. We use `awk` to
display the utilization metric in red text (`[31m`), and to turn "Gpu"
into "Gpu Utilization".

```shell.async
if [ $NUM_GPUS -gt 0 ]; then
    kubectl get pod -l ${KUBE_POD_LABEL_SELECTOR} --context ${KUBE_CONTEXT} -n ${KUBE_NS} -o name | xargs -I {} -n1 kubectl exec --context ${KUBE_CONTEXT} -n ${KUBE_NS} {} -- sh -c "nvidia-smi -q -d UTILIZATION -lms 5000 | awk -W interactive -F '           :' '/Gpu/ {print \"\n\033[31m\" \"Gpu Utilization:\", \$2 \"\033[0m\"}'"
fi
```

## Stream Ray Job Logs

Wait for the job to be active.

```shell
while true; do if [ "$(ray job status ${JOB_ID} >& /dev/null && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

Then stream out the logs.

```shell
ray job logs -f ${JOB_ID} 2> /dev/null
```
