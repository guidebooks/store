---
imports:
    - ../kubectl.md
    - ../context.md
---

# Target Kubernetes Namespace for Ray Cluster

=== "expand([ -z ${KUBE_CONTEXT} ] && exit 1 || X=$(kubectl ${KUBE_CONTEXT_ARG} get ns -o name || oc ${KUBE_CONTEXT_ARG} get projects -o name); echo "$X" | sed -E 's#(namespace|project\.project\.openshift\.io)/##' | grep -Ev 'openshift|kube-', Kubernetes namespaces)"
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
    
