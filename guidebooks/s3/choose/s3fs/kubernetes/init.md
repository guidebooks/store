---
imports:
    - util/jobid
---

```shell
export S3_DATA=premounted
```

```shell
export S3_S3FS_CLAIM="s3fs.claim.${JOB_ID}.${S3_BUCKET}"
```

```shell
export S3_S3FS_SECRET="s3fs.secret.${JOB_ID}.${S3_BUCKET}"
```
