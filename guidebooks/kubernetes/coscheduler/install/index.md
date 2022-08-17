# Install the Kubernetes Co-scheduler

The Kubernetes [coscheduler](https://github.com/kubernetes-sigs/scheduler-plugins/blob/master/pkg/coscheduling/README.md)
helps avoid livelock, where multiple jobs compete for resources in a
way that prevents any of them from making progress. 
*Requires root privileges to your cluster.*
        
```shell
---
validate: kubectl get ${KUBE_CONTEXT_ARG} -n scheduler-plugins deploy scheduler-plugins-controller
---
--8<-- "./coscheduler.sh"
```
