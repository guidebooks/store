---
imports:
    - ../../../../kubernetes/kubectl.md
    - ../../../../util/jq.md
---

## Verify UID Range for your Namespace

For certain versions of OpenShfit, it might be necessary to edit the
default UID range so that pods in this namespace run as user ray=1000
by default ([reference](https://access.redhat.com/solutions/2801791)).

=== "Run Locally"
    Nothing to do.
    ```shell
    echo "Good to go"
    ```
    
=== "Run on a Kubernetes Cluster"
    ```shell
    ---
    validate: |
      [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ] && [ $(kubectl get ns ${KUBE_NS} --context ${KUBE_CONTEXT} -o json | jq -r '.metadata.annotations."openshift.io/sa.scc.uid-range"') = "1000/10000" ]
    ---
    kubectl annotate namespace ${KUBE_NS} --context ${KUBE_CONTEXT} --overwrite openshift.io/sa.scc.uid-range=1000/10000
    ```

    Not changing the UID can cause permissions problems when the Ray
    Operator attempts to initialize a new Ray Cluster. In these cases, the
    RayCluster will appear in the list from `kubectl get raycluster`, but `kubectl
    describe raycluster your-cluster-name` will show permissions errors. If
    you skip this step initially, you will need to delete the cluster and
    scale down the operator, apply this step, and scale the operator back
    up, then recreate the cluster.

