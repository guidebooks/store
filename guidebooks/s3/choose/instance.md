# How do you wish to access S3 data?

If your application needs access to S3 data, you will need to provide credentials. These credentials will be attached to your jobs automatically. The simplest way to manage your S3 secrets is by populating the ~/.aws/config and ~/.aws/credentials files. Note: if your S3 endpoint is *not* AWS, make sure to add an `endpoint_url` field to the config entry.

=== "My credentials are stored AWS-style"

    My credentials are in ~/.aws/credentials. This does not mean that your S3 endpoint is in AWS, only that you are storing your S3 credentials on your laptop using [this convention](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

    ```shell
    export S3_PROVIDER=aws
    ```

    :import{aws/auth}
