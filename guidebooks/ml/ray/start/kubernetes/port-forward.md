## Start up a Kubernetes port-forward to the cluster

```shell
PID=$(ps aux | grep -v grep | grep "port-forward service/${RAY_KUBE_CLUSTER_NAME-mycluster}-ray-head" | awk '{print $2}')
[ -n "$PID" ] && kill $(ps aux | grep -v grep | grep "port-forward service/${RAY_KUBE_CLUSTER_NAME-mycluster}-ray-head" | awk '{print $2}')

kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} port-forward service/${RAY_KUBE_CLUSTER_NAME-mycluster}-ray-head ${RAY_KUBE_PORT-8266}:8265 > /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME-mycluster} &

while true; do if [ -f /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME-my-cluster} ] && [ "$(cat /tmp/port-forward-${RAY_KUBE_CLUSTER_NAME-mycluster} | grep -q 'Forwarding from' && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```
