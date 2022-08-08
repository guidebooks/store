---
imports:
    - ./kubectl.md
---

# Choose a Kubernetes context

=== "expand(kubectl config get-contexts -o name, Kubernetes contexts)"
    ```shell
    export KUBE_CONTEXT="${choice}"
    ```

    ```shell
    export KUBE_CONTEXT_ARG="--context ${choice}"
    ```

    ```shell
    export KUBE_CONTEXT_ARG_HELM="--kube-context ${choice}"
    ```
