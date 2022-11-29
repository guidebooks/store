=== "Use IBM Cloud CodeEngine"

    The [Code Engine](https://cloud.ibm.com/docs/codeengine) service offers a hosted Kubernetes context.
    :import{ibm/cloud/ce/project}
    
    ```shell
    export KUBE_CONTEXT=$(kubectl config current-context)
    ```

    ```shell
    export KUBE_CONTEXT_ARG="--context ${KUBE_CONTEXT}"
    ```

    ```shell
    export KUBE_CONTEXT_ARG_HELM="--kube-context ${KUBE_CONTEXT}"
    ```

    ```shell
    export KUBERNETES_RBAC_ENABLED=false
    ```
    
    ```shell
    export IMAGE_PULL_POLICY=Always
    ```
