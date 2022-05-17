# Pick a Ray Target

=== "Run Locally"
    This will install Ray on your laptop.
    
    === "Intel"
        If you are running on x86/Intel hardware.

        ```shell
        ---
        validate: pip-show ray
        ---
        pip install -U ray
        ```

    === "Apple Silicon"
        If you are running on Apple Silicon/ARM hardware.
        
        :import{../../python/conda/install.md}
        
        ```shell
        ---
        validate: pip show ray && conda list | grep grpcio
        ---
        conda activate
        pip uninstall grpcio
        conda install grpcio
        pip install ray
        ```
        
    ```shell
    ray stop
    ray start --head
    ```
    
    ```shell
    export RAY_ADDRESS=http://127.0.0.1:8265
    ```

=== "Run on a Kubernetes Cluster"
    --8<-- "kubernetes.md"
