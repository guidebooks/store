---
imports:
    - kubernetes/choose/ns
---

# Select an image pull secret

An [image pull secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) allows your Kubernetes [pods](https://kubernetes.io/docs/concepts/workloads/pods/) to pull images from a private container registry. If your image is public, you may use the "No secret needed" option.

=== "expand([ -z ${KUBE_NS_ARG} ] && exit 1 || kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} secret --field-selector type=kubernetes.io/dockerconfigjson -o=custom-columns=NAME:.metadata.name --no-headers, Image pull secrets)"
    ```shell
    export IMAGE_PULL_SECRET=${choice}
    ```
    
=== "No secret needed, since my image is public"
    ```shell
    export IMAGE_PULL_SECRET=
    ```
