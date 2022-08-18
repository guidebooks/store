# Choose a Pod Scheduler

To schedule your job's work, you have several scheduler options.

=== "Keep It Simple"

    This option installs only two
    [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
    and one
    [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
    in the namespace you specify.
    
    ```shell
    export KUBE_POD_MANAGER=kubernetes
    ```

    ```shell
    export KUBE_POD_MANAGER_NON_ROOT=true
    ```

=== "Use the Ray Autoscaler"

    If you run one application at a time, whose demand varies greatly as
    it runs (e.g. from one phase to the next), use the [Ray
    Autoscaler](https://www.anyscale.com/blog/autoscaling-clusters-with-ray)
    to manage the workload. *Requires root privileges to your cluster.*

    ```shell
    export KUBE_POD_MANAGER=ray
    ```

    :import{ml/ray/hacks/openshift/uid-range}

=== "Use the Multi-user Enhanced Kubernetes Scheduler"

    If you run many unrelated jobs concurrently, use the [Multi-Cluster
    Application Dispatcher
    (MCAD)](https://github.com/IBM/multi-cluster-app-dispatcher) with the
    advanced
    [coscheduler](https://github.com/kubernetes-sigs/scheduler-plugins/blob/master/pkg/coscheduling/README.md). MCAD
    can be configured to prioritize your workloads.

    === "My administrator has already installed and configured MCAD"

        If you are a non-admin user in a multi-tenant cluster, select this option.
        ```shell
        export KUBE_POD_MANAGER=mcad
        ```

        ```shell
        export KUBE_POD_MANAGER_NON_ROOT=true
        ```

    === "MCAD with the Advanced Coscheduler"
    
        The [coscheduler](https://github.com/kubernetes-sigs/scheduler-plugins/blob/master/pkg/coscheduling/README.md)
        helps avoid livelock, where multiple jobs compete for resources in a
        way that prevents any of them from making progress. 
        *Requires root privileges to your cluster.*
        
        ```shell
        export KUBE_POD_MANAGER=mcad
        ```

        ```shell
        export KUBE_POD_SCHEDULER=coscheduler
        ```

        :import{ml/ray/hacks/openshift/uid-range}
        :import{kubernetes/coscheduler/install}
        :import{kubernetes/mcad/install}

    === "MCAD with the Default Kubernetes Scheduler"

        If you do not wish to use the experimental
        coscheduler, select this option.
        *Requires root privileges to your cluster.*

        ```shell
        export KUBE_POD_MANAGER=mcad
        ```

        ```shell
        export KUBE_POD_SCHEDULER=default
        ```

        :import{ml/ray/hacks/openshift/uid-range}
        :import{kubernetes/mcad/install}
