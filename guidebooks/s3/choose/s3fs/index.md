=== "My code needs S3 data, and assumes it will be pre-mounted as a local filesystem"
    If your input data is in S3, but your application logic is coded to assume the shards can be accessed as local files, select this option. **This option requires your cluster already be configured with S3FS support.**

    :import{s3/choose/bucket}
    :import{./kubernetes}

=== "My code will access S3 via APIs"
    For example, you may program to the [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html) APIs.
    ```shell
    echo "nothing to do"
    ```

