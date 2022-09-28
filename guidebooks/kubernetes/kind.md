---
imports:
    - docker/install
---

# Install kind

[kind](https://kind.sigs.k8s.io/docs/user/quick-start)(Kubernetes in
Docker) enables you to run a local Kubernetes cluster with Docker
container nodes.

=== "MacOS"
    ```shell
    ---
    validate: which kind
    ---
    brew install kind
    ```

=== "Linux"
    ```shell
    ---
    validate: which kind
    ---
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.16.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    ```
    
=== "Windows"
    ```shell
    ---
    validate: which kind
    ---
    choco install kind
    ```
