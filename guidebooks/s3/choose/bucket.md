---
imports:
    - ./instance.md
    - ../install/cli.md
    - ../install/auth.md
---

# Choose an S3 Bucket

=== "expand([ -n "$MC_CONFIG_DIR" ] && mc -q --config-dir ${MC_CONFIG_DIR} ls s3 | awk '{print substr($NF, 1, length($NF) - 1)}', S3 Buckets)"
    ```shell
    export S3_BUCKET="${choice}"
    ```

    ```shell
    export S3_FILEPATH="s3/${choice}"
    ```
