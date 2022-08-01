---
imports:
    - ../kubectl.md
    - ../context.md
---

# If you have an existing ray namespace, select it here. Otherwise, press enter to create one.

<!-- # TODO: check for namespace existing first. Bug here on initial workflow. -->

<!-- TODO: either select existing namespace from list, or create new. Sounds hard, ask nick. -->

=== "expand([ -z ${KUBE_CONTEXT} ] && exit 1 || kubectl --context ${KUBE_CONTEXT} get ns -o name | grep -Ev 'openshift|kube-' | sed 's#namespace/##', Kubernetes namespaces)"
    ```shell
    export KUBE_NS=${choice}
    ```

<!-- TODO: Check for bug here (not creating custom namespace) -->

# Create a new namespace for the ray cluster

=== "Create a namespace, choose a name [default: ray]"
    ```shell
    export KUBE_NS=${choice}

    # gracefully handle namespace already exists.
    STR=$(kubectl get namespaces | grep "${KUBE_NS}")
    SUB=${choice}
    if [[ "$STR" == *"$SUB"* ]]; 
    then
        echo "Namespace already exists."
    else
        kubectl create ns "${KUBE_NS}"
    fi

    ```
