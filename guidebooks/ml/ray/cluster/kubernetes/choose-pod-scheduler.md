# Choose a Pod Scheduler

To schedule your job's work, you have several scheduler options.

=== "Use Ray Autoscaler"

    If you run one application at a time, whose demand varies greatly as it runs (e.g. from one phase to the next), use the [Ray Autoscaler](https://www.anyscale.com/blog/autoscaling-clusters-with-ray) to manage the workload.

    ```shell
    export KUBE_POD_MANAGER=ray
    ```

=== "Use Multi-user Enhanced Kubernetes Scheduler"

    If you run many unrelated jobs concurrently, use the [Multi-Cluster Application Dispatcher (MCAD)](https://github.com/IBM/multi-cluster-app-dispatcher) with the sophisticated [coscheduler](https://github.com/kubernetes-sigs/scheduler-plugins/blob/master/pkg/coscheduling/README.md). MCAD can be configured to prioritize your workloads, and the coscheduler helps avoid livelock, where multiple jobs compete for resources in a way that prevents any of them from making progress.

    ```shell
    export KUBE_POD_MANAGER=mcad
    ```

    ```shell
    export KUBE_POD_SCHEDULER=coscheduler
    ```

    :import{kubernetes/mcad/install}


=== "Use Default Kubernetes Scheduler"

    If your needs are similar to those described in the Multi-user Enhanced Scheduler option, but you do not wish to use the experimental coscheduler, select this option.

    ```shell
    export KUBE_POD_MANAGER=mcad
    ```

    ```shell
    export KUBE_POD_SCHEDULER=default
    ```

    :import{kubernetes/mcad/install}
