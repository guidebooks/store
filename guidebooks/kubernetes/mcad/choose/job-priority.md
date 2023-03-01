# Job Priority

=== "Default Priority"
    My job can run with the default scheduling priority.
    
    To keep things simpler, here we simply do not enable the priority bits (hence the NO_NEED part).
    ```shell
    export KUBE_POD_SCHEDULING_PRIO_NO_NEED=default-priority
    ```

=== "Low Priority"
    My job is not urgent.
    ```shell
    export KUBE_POD_SCHEDULING_PRIO=low-priority
    ```

=== "High Priority"
    !! Please select this only if your job is urgent !!
    ```shell
    export KUBE_POD_SCHEDULING_PRIO=high-priority
    ```
