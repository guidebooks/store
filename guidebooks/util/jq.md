# Install jq

[jq](https://stedolan.github.io/jq/) is like `sed` for JSON data - you can use it to slice and filter and map and transform structured data with the same ease that `sed`, `awk`, `grep` and friends let you play with text.

=== "MacOS"
    <!-- TODO: Add homebrew tab -->
    ```shell
    ---
    validate: which jq
    ---
    brew install jq
    ```

=== "Linux"
    <!-- FIXME: this is debian/ubuntu-specific. -->
    ```shell
    ---
    validate: which jq
    ---
    sudo apt update && sudo apt -y install jq
    ```
