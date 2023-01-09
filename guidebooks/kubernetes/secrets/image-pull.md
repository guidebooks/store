---
imports:
    - kubernetes/choose/ns
---

# Select an image pull secret

=== "expand(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} secret --field-selector type=kubernetes.io/dockerconfigjson -o=custom-columns=NAME:.metadata.name --no-headers, Image pull secrets)"
    ```shell
    export IMAGE_PULL_SECRET=${choice}
    ```
    
=== "No secret needed, since my image is public"
    ```shell
    export IMAGE_PULL_SECRET=
    ```
