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
    ```shell
    ---
    validate: which helm
    ---
    bash $<(curl -L https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3)
    ```

=== "Windows"
    ```shell
    ---
    validate: which helm
    ---
    bash $<(curl -L https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3)
    ```
