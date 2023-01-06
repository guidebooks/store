# How do you wish to access S3 data?

=== "My credentials are stored AWS-style"

    My credentials are in ~/.aws/credentials. This does not mean that your S3 endpoint is in AWS, only that you are storing your S3 credentials on your laptop using [this convention](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

    ```shell
    export S3_PROVIDER=aws
    ```

    :import{aws/auth}
