---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

# Select an Active Ray Cluster Running in Kubernetes

Select a Ray cluster from the following list of active clusters in
your current Kubernetes context.

```shell
export FORCE=" "
```

=== "expand([ -z ${KUBE_CONTEXT} ] && exit 1 || kubectl get ${FORCE} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} deploy -l type=ray -o name, Ray clusters)"
    ```shell
    export RAY_KUBE_CLUSTER_NAME=$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} --no-headers ${choice} -o custom-columns=CLUSTER:.metadata.labels.ray-cluster-name)
    ```

=== "Nevermind, apparently I do not have any active Ray clusters"
    No Ray clusters were found.
    ```shell
    # Indicate an early exit to madwizard
    exit 90
    ```
