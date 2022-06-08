# AWS Credentials

You may also manually store your AWS credentials in ~/.aws/credentials. The file will look something like

```
[default]
aws_access_key_id = xxx
aws_secret_access_key = yyy
```

```shell
export S3_ENDPOINT=https://s3.amazonaws.com
```

```shell
export S3_ACCESS_KEY_ID=$(grep aws_access_key_id ~/.aws/credentials | awk -F ' = ' '{ print $2 }')
```

```shell
export AWS_ACCESS_KEY_ID=${S3_ACCESS_KEY_ID}
```

```shell
export S3_SECRET_ACCESS_KEY=$(grep aws_secret_access_key ~/.aws/credentials | awk -F ' = ' '{ print $2 }')
```

```shell
export AWS_SECRET_ACCESS_KEY=${S3_SECRET_ACCESS_KEY}
```

:import{./_auth.md}
