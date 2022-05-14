# Install Ray

=== "Local Install"
    This will install Ray on your laptop.
    
    === "Intel"
        If you are running on x86/Intel hardware.

        ```shell
        ---
        validate: python3 -c "import ray"
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
        
        hello

=== "Kubernetes Install"
    --8<-- "kubernetes.md"
