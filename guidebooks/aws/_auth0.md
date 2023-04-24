# AWS Credentials

You may also manually store your AWS credentials in ~/.aws/credentials. The file will look something like

```
[default]
aws_access_key_id = xxx
aws_secret_access_key = yyy
```

```shell
export S3_ENDPOINT_FROM_CONFIG=$(cat ~/.aws/config | awk -v AWS_PROFILE=${_AWS_PROFILE-default} '$1 == "[" AWS_PROFILE "]" {on=1} $1 ~ "]" && $1 != "[" AWS_PROFILE "]" {on=0} on==1 && $0 ~ "endpoint_url" {sub(/endpoint_url *= */,""); print $0}')
```

This seems to be the de facto standard way to communicate the endpoint
url to libraries.
```shell
export S3_ENDPOINT=${S3_ENDPOINT_FROM_CONFIG:=https://s3.amazonaws.com}
```

Some libraries seem to use this minor variant.
```shell
export S3_ENDPOINT_URL=${S3_ENDPOINT}
```

PyTorch Lightning doesn't currently (as of 20230424) support the de
facto standard `S3_ENDPOINT` environment variable.
```shell
export LIGHTNING_BUCKET_ENDPOINT_URL=${S3_ENDPOINT}
```

```shell
export S3_ACCESS_KEY_ID=$(cat ~/.aws/credentials | awk -v AWS_PROFILE=${_AWS_PROFILE-default} '$1 == "[" AWS_PROFILE "]" {on=1} $1 ~ "]" && $1 != "[" AWS_PROFILE "]" {on=0} on==1 && $0 ~ "aws_access_key_id" {sub(/aws_access_key_id *= */,""); print $0}' | sed 's/ //g')
```

```shell
export AWS_ACCESS_KEY_ID=${S3_ACCESS_KEY_ID}
```

```shell
export S3_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials | awk -v AWS_PROFILE=${_AWS_PROFILE-default} '$1 == "[" AWS_PROFILE "]" {on=1} $1 ~ "]" && $1 != "[" AWS_PROFILE "]" {on=0} on==1 && $0 ~ "aws_secret_access_key" {sub(/aws_secret_access_key *= */,""); print $0}' | sed 's/ //g')
```

```shell
export AWS_SECRET_ACCESS_KEY=${S3_SECRET_ACCESS_KEY}
```
