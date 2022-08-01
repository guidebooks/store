---
imports:
    - ./kubectl.md
---

# Choose a Kubernetes context

If you don't see a context you need, download or append new enteries to your `.kube/config`.

=== "expand(kubectl config get-contexts -o name, Kubernetes contexts)"
    ```shell
    export KUBE_CONTEXT="${choice}"
    ```
