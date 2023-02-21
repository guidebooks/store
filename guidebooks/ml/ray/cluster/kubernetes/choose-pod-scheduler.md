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

=== "Use the Multi-user Enhanced Kubernetes Scheduler"

    :import{kubernetes/mcad/choose/scheduler}
