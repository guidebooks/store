# Help us to locate your S3 Credentials

=== "AWS-style"

    My credentials are in ~/.aws/credentials. This does not mean that your S3 endpoint is in AWS, only that you are storing your S3 credentials on your laptop using [this convention](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

    ```shell
    export S3_PROVIDER=aws
    ```

    :import{aws/auth}

=== "IBM Cloud-style"
    
    I am using the "`ibmcloud cos`" CLI to manage my S3 credentials.

    ```shell
    export S3_PROVIDER=ibm
    ```

    :import{ibm/cloud/cos/instance}
