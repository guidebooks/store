---
imports:
    - kubernetes/choose/ns
---

# Select an Active Ray Cluster Running in Kubernetes

=== "expand(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} deploy -l type=ray -o name)"
    ```shell
    export RAY_KUBE_CLUSTER_NAME=$(kubectl get -n ray --no-headers ${choice} -o custom-columns=CLUSTER:.metadata.labels.ray-cluster-name)
    ```

=== "Nevermind, apparently I do not have any active Ray clusters"
    No Ray clusters were found.
    ```shell
    # Indicate an realy exit to madwizard
    exit 90
    ```
