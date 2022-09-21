# envsubst

Substitutes environment variables with their value in shell format
strings. Variables to be replaced should be in either `${var}` or
`$var` format. [More
information](https://www.gnu.org/software/gettext/manual/html_node/envsubst-Invocation.html)

=== "MacOS"
    ```shell
    ---
    validate: which envsubst
    ---
    brew install gettext
    ```

=== "Linux"
    ```shell
    ---
    validate: which envsubst
    ---
    apt install gettext-base
    ```

=== "Windows"
    ```shell
    echo "envsubst not supported on Windows" && exit 1
    ```
