# Configure helm to mount the pvc

```shell
export HELM_EXTRA="${HELM_EXTRA} --set pvcs.secrets.s3fs[0].name=${S3_S3FS_SECRET} --set pvcs.secrets.s3fs[0].accessKey=$(echo -n $AWS_ACCESS_KEY_ID | base64) --set pvcs.secrets.s3fs[0].secretKey=$(echo -n $AWS_SECRET_ACCESS_KEY | base64)"
```
