---
imports:
    - ml/ray/install/cli
---

# Connect a local port to your Ray cluster

This will define the environment variable `RAY_ADDRESS`.

=== "Run Locally"
    ```shell
    export RAY_ADDRESS=http://127.0.0.1:8265
    ```

=== "Run on a Kubernetes Cluster"
    --8<-- "./kubernetes"

