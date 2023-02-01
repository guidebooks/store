```shell
export S3_DATA=premounted
```

```shell
export S3_S3FS_CLAIM="s3fs.claim.${RAY_KUBE_CLUSTER_NAME}.${S3_BUCKET}"
```

```shell
export S3_S3FS_SECRET="s3fs.secret.${RAY_KUBE_CLUSTER_NAME}.${S3_BUCKET}"
```
