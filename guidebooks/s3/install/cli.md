# Install an S3 CLI

=== "MacOS"
    ```shell
    ---
    validate: which mc
    ---
    brew install minio/stable/mc
    ```

=== "Linux"
    === "x86"
        ```shell
        ---
        validate: which mc
        ---
        curl -LO https://dl.min.io/client/mc/release/linux-amd64/mc
        chmod +x mc
        sudo mv mc /usr/local/bin
        ```
    
    === "ARM"
        ```shell
        echo "Not yet supported" && exit 1
        ```

=== "Windows"
    ```shell
    ---
    validate: which aws
    ---
    curl -LO https://dl.min.io/client/mc/release/windows-amd64/mc.exe
    echo "TODO" && exit 1
    ```
