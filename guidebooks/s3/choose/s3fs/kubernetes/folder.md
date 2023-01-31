# Specify an S3 folder

Under the given bucket, which path do you wish to be mounted? Note:
your data will be mounted under `$S3_DATAPATH`. Make sure your code
uses this environment variable to find the input data.

=== "S3 path to be mounted [default: input/]"

    ```shell
    export S3_OBJECTPATH="${choice}"
    ```

    ```shell
    export S3_DATAPATH="/data/${choice}"
    ```
