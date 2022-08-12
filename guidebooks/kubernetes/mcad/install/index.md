# Install MCAD

The [multi-cluster-app-dispatcher](https://github.com/IBM/multi-cluster-app-dispatcher) is a Kubernetes controller providing mechanisms for applications to manage batch jobs in a single or mult-cluster environment.

The multi-cluster-app-dispatcher (MCAD) controller is capable of (i) providing an abstraction for wrapping all resources of the job/application and treating them holistically, (ii) queuing job/application creation requests and applying different queuing policies, e.g., First In First Out, Priority, (iii) dispatching the job to one of multiple clusters, where a MCAD queuing agent runs, using configurable dispatch policies, and (iv) auto-scaling pod sets, balancing job demands and cluster availability (future work).

## Install the Kubernetes Co-scheduler

```shell
---
validate: kubectl get deploy -n scheduler-plugins scheduler-plugins-controller
---
--8<-- "./coscheduler.sh"
```

## Install the MCAD Services

```shell
---
validate: kubectl get deploy mcad-controller -n kube-system
---
--8<-- "./mcad.sh"
```
