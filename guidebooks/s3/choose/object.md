---
imports:
    - ./bucket.md
---

# Choose an S3 Object

=== "expand([ -n "$MC_CONFIG_DIR" ] && mc -q --config-dir ${MC_CONFIG_DIR} ls ${S3_FILEPATH} | awk '{print $NF}', S3 Objects)"
    ```shell
    export S3_OBJECT="${choice}"
    ```

    ```shell
    export S3_FILEPATH="${S3_FILEPATH}/${choice}"
    ```
