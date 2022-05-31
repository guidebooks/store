
Wait for the job to be active, and then stream out the logs.

```shell
if [ $NUM_GPUS > 0 ]; then
    kubectl get pod -l ray-user-node-type=rayWorkerType -n nvidia-gpu-operator -o name  | xargs -I {} -n1 kubectl exec -n nvidia-gpu-operator {} -- sh -c "nvidia-smi -q -d UTILIZATION -lms 5000 | awk -W interactive -F '           :' '/Gpu/ {print \"\n\033[31m\" \"Gpu Utilization:\", \$2 \"\033[0m\"}'" &
fi
```

```shell
while true; do if [ "$(ray job status ${JOB_ID} >& /dev/null && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
ray job logs -f ${JOB_ID} 2> /dev/null
```
