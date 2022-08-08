---
imports:
    - ../kubectl.md
    - ../context.md
---

# Target Kubernetes Namespace for Ray Cluster

=== "expand([ -z ${KUBE_CONTEXT} ] && exit 1 || kubectl --context ${KUBE_CONTEXT} get ns -o name | grep -Ev 'openshift|kube-' | sed 's#namespace/##', Kubernetes namespaces)"
    ```shell
    export KUBE_NS=${choice}
    ```

    ```shell
    export KUBE_NS_ARG="-n ${choice}"
    ```

=== "Create a namespace"
    ```shell
    kubectl create ns madns
    ```
    
    ```shell
    export KUBE_NS=madns
    ```
    
