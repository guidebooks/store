# Where should the S3 bucket be mounted in the filesystem?

Where should the S3 bucket be mounted?

=== "form(echo $S3_BUCKETS | tr ' ' '\n', /$choice)"
    ```shell
    export S3_DATAPATHS="$S3_DATAPATHS ${choice}"
    ```

    ```shell
    export HELM_EXTRA="$HELM_EXTRA --set pvcs.claims[$idx].name=s3fs-${idx}-${JOB_ID} --set pvcs.claims[$idx].secret=${S3_S3FS_SECRET} --set pvcs.claims[$idx].endpoint=${S3_ENDPOINT/s3/s3.direct} --set pvcs.claims[$idx].bucket=\"${S3_BUCKET_${idx}}\" --set pvcs.claims[$idx].storageClass=${S3_STORAGE_CLASS} --set pvcs.claims[$idx].mountPath=\"${choice}\""
    ```

    ```shell
    export TORCHX_MOUNTS="type=volume,src=s3fs-${idx}-${JOB_ID},dst=\"${choice}\",$TORCHX_MOUNTS"
    ```
