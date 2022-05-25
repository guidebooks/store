---
imports:
    - ../kubectl.md
    - ../context.md
---

# Target Kubernetes Namespace for Ray Cluster

=== "expand(kubectl --context ${KUBE_CONTEXT} get ns -o name | grep -Ev 'openshift|kube-' | sed 's#namespace/##')"
    ```shell
    export RAY_KUBE_NS=${choice}
    ```

=== "Create a namespace"
    ```shell
    kubectl create ns madns
    ```
    
    ```shell
    export RAY_KUBE_NS=madns
    ```
    
