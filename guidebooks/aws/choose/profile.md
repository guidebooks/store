# Choose an AWS Profile

The simplest way to manage your S3 secrets is by populating the ~/.aws/config and ~/.aws/credentials files. Note: if your S3 endpoint is *not* AWS, make sure to add an `endpoint_url` field to the config entry.

```shell
if [ ! -d ~/.aws ]; then mkdir ~/.aws; fi
if [ ! -f ~/.aws/config ]; then echo "[default]" > ~/.aws/config; fi
```

> Note the leading underscore. We don't want to pass this through to
> any CLI tools or libraries that application code may use. This is
> just for our internal consumption; e.g. aws/auth

=== "expand(cat ~/.aws/credentials | grep -E '^\\[' | tr -d '[]')"
    ```shell
    export _AWS_PROFILE="${choice}"
    ```
