
# Choose an S3 Bucket

=== "expand([ -n "$MC_CONFIG_DIR" ] && mc -q --config-dir ${MC_CONFIG_DIR} ls s3 | awk '{print substr($NF, 1, length($NF) - 1)}', S3 Buckets)"
    ```shell
    export S3_BUCKET${S3_BUCKET_SUFFIX}="${choice}"
    ```

    ```shell
    export S3_FILEPATH${S3_BUCKET_SUFFIX}="$S3_BUCKET${S3_BUCKET_SUFFIX}"
    ```

--8<-- "util/separator"

=== "📁 Create a new bucket"
    You may choose to create a new S3 bucket.
    :import{s3/create/bucket}
