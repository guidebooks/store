---
imports:
    - s3/install/cli
    - s3/install/auth
---

# Choose an S3 Bucket

=== "multi([ -n "$MC_CONFIG_DIR" ] && mc -q --config-dir ${MC_CONFIG_DIR} ls s3 | awk '{print substr($NF, 1, length($NF) - 1)}', S3 Buckets)"
    ```shell
    export S3_BUCKET${S3_BUCKET_SUFFIX}="${choice}"
    ```

    ```shell
    export S3_FILEPATH${S3_BUCKET_SUFFIX}="$S3_BUCKET${S3_BUCKET_SUFFIX}"
    ```

    ```shell
    export S3_BUCKET_${midx}="$choice"
    ```

    ```shell
    export S3_BUCKETS="$S3_BUCKETS $choice"
    ```

