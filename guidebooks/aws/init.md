---
validate: |
  [ -n "${S3_ACCESS_KEY_ID}" ] && [ -n "${S3_SECRET_ACCESS_KEY}" ]
---

# Provide AWS Credentials

To learn more, and to get your credentials from the AWS console, [look
here](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html).

=== "Profile Name [default: mys3]"
    ```shell
    export S3_PROFILE_NAME=${choice}
    ```

=== "AWS Endpoint [default: https://s3.amazonaws.com]"
    ```shell
    export S3_ENDPOINT=${choice}
    ```

=== "AWS Access Key Id [default: none]"
    ```shell
    export S3_ACCESS_KEY_ID=${choice}
    ```

=== "AWS Secret Access Key [default: none]"
    ```shell
    export S3_SECRET_ACCESS_KEY=${choice}
    ```

```shell
if [ ! -d ~/.aws ]; then mkdir ~/.aws; fi
cat << EOF >> ~/.aws/credentials
[${S3_PROFILE_NAME}]
aws_access_key_id = ${S3_ACCESS_KEY_ID}
aws_secret_access_key = ${S3_SECRET_ACCESS_KEY}
EOF

cat << EOF >> ~/.aws/config
[${S3_PROFILE_NAME}]
endpoint_url = ${S3_ENDPOINT}
EOF
```
