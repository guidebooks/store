# Configure MinIO for Ray Workflows

```shell
export S3_BUCKET=guidebooks
```

```shell
kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} exec minio-client -- mc mb minio/${S3_BUCKET}
```
