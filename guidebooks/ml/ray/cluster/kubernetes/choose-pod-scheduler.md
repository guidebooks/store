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

    :import{kubernetes/mcad/choose/scheduler}
