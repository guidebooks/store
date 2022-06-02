---
imports:
    - ./kubectl.md
---

# Choose a Kubernetes context

=== "expand(kubectl config get-contexts -o name, Kubernetes contexts)"
    ```shell
    kubectl config use-context "${choice}"
    ```
    
    ```shell
    export KUBE_CONTEXT="${choice}"
    ```
