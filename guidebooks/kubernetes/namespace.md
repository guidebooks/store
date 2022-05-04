---
imports:
    - ../kubectl.md
---

# Choose a Kubernetes namespace

=== "expand(kubectl get ns --no-headers -o custom-columns='\:metadata.name' | grep -Ev 'openshift|kube-|ibm-|calico-system|tigera-operator')"
    ```shell
    kubectl config set-context --current --namespace "${choice}"
    ```
