# Choose an S3FS Storage Class

=== "expand(kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} get sc --no-headers | grep s3fs |awk '{print $1}', S3FS Storage Classes)
    ```shell
    export S3_STORAGE_CLASS="${choice}"
    ```
