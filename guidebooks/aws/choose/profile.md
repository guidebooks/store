# Choose an AWS Profile

```shell
if [ ! -d ~/.aws ]; then mkdir ~/.aws; fi
if [ ! -f ~/.aws/config ]; then echo "[default]" > ~/.aws/config; fi
```

> Note the leading underscore. We don't want to pass this through to
> any CLI tools or libraries that application code may use. This is
> just for our internal consumption; e.g. aws/auth

=== "expand(cat ~/.aws/config | grep -E '^\\[' | tr -d '[]')"
    ```shell
    export _AWS_PROFILE="${choice}"
    ```
