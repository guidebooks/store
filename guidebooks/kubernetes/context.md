---
imports:
    - ./kubectl.md
---

# Choose a Kubernetes context

A Kubernetes
[context](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/)
defines access to a cluster as a particular user.

=== "expand((kubectl config get-contexts -o name | grep -E . >& /dev/null && kubectl config get-contexts -o name) || (kubectl version | grep Server >& /dev/null && echo "${KUBE_CONTEXT_FOR_TEST-In-cluster}" || exit 1), Kubernetes contexts)"
    ```shell
    export KUBE_CONTEXT="${choice}"
    ```

    ```shell
    export KUBE_CONTEXT_ARG=$([ -n "$KUBE_CONTEXT_FOR_TEST" ] && echo "" || echo "--context ${choice}")
    ```

    ```shell
    export KUBE_CONTEXT_ARG_HELM=$([ -n "$KUBE_CONTEXT_FOR_TEST" ] && echo "" || echo "--kube-context ${choice}")
    ```

> The bit of complexity here is intended to handle the situation of
> running a guidebook in a Pod running. In this case, the normal context
> list is empty, but `kubectl` still works as desired. Hence, we first
> check if we have any contexts, via the grep for `.`; if so, we use
> that information. Otherwise, if we have a connection to the apiserver
> (checked via the grep for `Server`), then we use a simulated
> "In-cluster" context.
