# Install Helm v3

This guide shows how to install the Helm CLI. Helm can be installed either from source, or from pre-built binary releases.

=== "MacOS"
    === "Homebrew"
        ```shell
        ---
        validate: which helm
        ---
        brew install helm
        ```
    
    === "curl"
        ```shell
        ---
        validate: which helm
        ---
        bash $<(curl -L https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3)
        ```

=== "Linux"
    In a docker container, the `$<(...)` magic may not work. "$/dev/fd/63: No such file or directory".
    ```shell
    ---
    validate: which helm
    ---
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    ```

=== "Windows"
    ```shell
    ---
    validate: which helm
    ---
    bash $<(curl -L https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3)
    ```
