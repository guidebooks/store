# Choose an AWS Profile

```shell
if [ ! -d ~/.aws ]; then mkdir ~/.aws; fi
if [ ! -f ~/.aws/config ]; then echo "[default]" > ~/.aws/config; fi
```

=== "expand(cat ~/.aws/config | grep -E '^\\[' | tr -d '[]')"
    ```shell
    export AWS_PROFILE="${choice}"
    ```
