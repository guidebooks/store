# Configure S3 for use with Ray Workflows

=== "Use MinIO"

    To set up a [MinIO](https://minio.io/) S3 service within your cluster just for use with Ray Workflows, select this option.
    :import{./minio}
    :import{./kubernetes/secret}

=== "Use my Cloud provider for S3"
    If you would like to use AWS or your own provider for S3, select this option.

    :import{s3/choose/bucket}
    :import{./setenv}
    :import{./kubernetes/secret}
