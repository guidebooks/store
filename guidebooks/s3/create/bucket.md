---
imports:
    - s3/choose/instance
---

# Create an S3 Bucket

You may choose to create a new S3 bucket.

=== "Bucket name [default: mybucket]"
    ```shell
    mc --config-dir ${MC_CONFIG_DIR} mb s3/${choice}
    ```
