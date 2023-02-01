# Configure helm to mount the pvc

```shell
export HELM_EXTRA="${HELM_EXTRA} --set pvcs.secrets.s3fs[0].name=${S3_S3FS_SECRET} --set pvcs.secrets.s3fs[0].accessKey=$(echo $AWS_ACCESS_KEY_ID | base64) --set pvcs.secrets.s3fs[0].secretKey=$(echo $AWS_SECRET_ACCESS_KEY | base64) --set pvcs.claims[0].name=${S3_S3FS_CLAIM} --set pvcs.claims[0].secret=${S3_S3FS_SECRET} --set pvcs.claims[0].endpoint=${S3_ENDPOINT/s3/s3.direct} --set pvcs.claims[0].bucket=\"${S3_BUCKET}\" --set pvcs.claims[0].storageClass=${S3_STORAGE_CLASS} --set pvcs.claims[0].mountPath=\"${S3_DATAPATH}\""
```
