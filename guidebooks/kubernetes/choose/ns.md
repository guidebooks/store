---
imports:
    - ../kubectl.md
    - ../context.md
---

# Target Kubernetes Namespace for Ray Cluster

The bit of complexity here is intended to handle the situation where
we are running in a restricted OpenShift environment. In some such
cases, we do not have access to the `Namespace` APIs, but we do have
access to the `Project` APIs. In OpenShift, normally the two are the
same, but in a restricted environment, a Project can act as a
Namespace, without the additional security concerns that Namespaces
bring.

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
    
