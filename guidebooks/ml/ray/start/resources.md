# Configure your Ray Resource Requirements

=== "Number of CPUs [default: 1]"
    ```shell
    export NUM_CPUS=${choice}
    ```
    
=== "Number of GPUs [default: 0]"
    ```shell
    export NUM_GPUS=${choice}
    ```

=== "Minimum Workers [default: 2]"
    ```shell
    export MIN_WORKERS=${choice}
    ```

=== "Maximum Workers [default: 3]"
    ```shell
    export MAX_WORKERS=${choice}
    ```

=== "Worker Memory [default: 1Gi]"
    ```shell
    export WORKER_MEMORY=${choice}
    ```

=== "Head Memory [default: 1Gi]"
    ```shell
    export HEAD_MEMORY=${choice}
    ```
