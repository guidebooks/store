
=== "expand([ -n "$MC_CONFIG_DIR" ] && [ -n "$S3_FILEPATH${S3_BUCKET_SUFFIX}" ] && mc -q --config-dir ${MC_CONFIG_DIR} ls "s3/$S3_FILEPATH${S3_BUCKET_SUFFIX}" | awk '{print $NF}', S3 Objects)"
    ```shell
    export S3_OBJECT${S3_SUFFIX}="${choice}"
    ```

    ```shell
    export S3_FILEPATH${S3_SUFFIX}="$S3_FILEPATH${S3_BUCKET_SUFFIX}/${choice}"
    ```
