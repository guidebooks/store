# Install the AWS CLI

=== "MacOS"
    ```shell
    ---
    validate: which aws
    ---
    brew install awscli
    ```
    
=== "Linux"
    === "x86"
        ```shell
        ---
        validate: which aws
        ---
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        ```

    === "ARM"
        ```shell
        ---
        validate: which aws
        ---
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        ```

=== "Windows"
    ```shell
    ---
    validate: which aws
    ---
    echo "Windows AWS Installation not yet supported
    exit 1
    ```
