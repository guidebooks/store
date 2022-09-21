---
imports:
    - ../kubectl.md
---

# Target Kubernetes Namespace for Ray Cluster

The bit of complexity here is intended to handle the situation where
we are running in a restricted OpenShift environment. In some such
cases, we do not have access to the `Namespace` APIs, but we do have
access to the `Project` APIs. In OpenShift, normally the two are the
same, but in a restricted environment, a Project can act as a
Namespace, without the additional security concerns that Namespaces
bring.

=== "expand([ -z ${KUBE_CONTEXT} ] && exit 1 || X=$([ -n "$KUBE_NS_FOR_TEST" ] && echo $KUBE_NS_FOR_TEST || kubectl get ${KUBE_CONTEXT_ARG} ns -o name || oc ${KUBE_CONTEXT_ARG} get projects -o name); echo "$X" | sed -E 's#(namespace|project\.project\.openshift\.io)/##' | grep -Ev 'openshift|kube-', Kubernetes namespaces)"
    ```shell
    export KUBE_NS=${choice}
    ```

    ```shell
    export KUBE_NS_ARG=$([ -n "$KUBE_NS_FOR_TEST" ] && echo "" || echo "-n ${choice}")
    ```

    > If we are faking a project for tests, then don't use a `-n <namespace` CLI argument for subsequent `kubectl` commands.

=== "Create a namespace"
    ```shell
    ---
    validate: kubectl get ${KUBE_CONTEXT_ARG} ns madns || oc get ${KUBE_CONTEXT_ARG} ns madns
    ---
    kubectl create ${KUBE_CONTEXT_ARG} ns madns || oc new-project ${KUBE_CONTEXT_ARG} madns
    ```
    
    ```shell
    export KUBE_NS=madns
    ```

    ```shell
    export KUBE_NS_ARG="-n madns"
    ```

