# Configure your Resource Requirements

=== "Number of Workers [default: 1]"
    ```shell
    export MAX_WORKERS=${choice}
    ```

=== "CPUs per worker [default: 500m]"
    ```shell
    export NUM_CPUS=${choice}
    ```
    
=== "GPUs per worker [default: 0]"
    ```shell
    export NUM_GPUS=${choice}
    ```

=== "Memory per worker [default: 500Mi]"
    ```shell
    export WORKER_MEMORY=${choice}
    ```

=== "Ephemeral Storage per worker [default: 5Gi]"
    ```shell
    export RAY_EPHEMERAL_STORAGE=${choice}
    ```
