# envsubst

Substitutes environment variables with their value in shell format
strings. Variables to be replaced should be in either `${var}` or
`$var` format. [More
information](https://www.gnu.org/software/gettext/manual/html_node/envsubst-Invocation.html)

=== "MacOS"
    ```shell
    ---
    validate: which envsubst2
    ---
    cd /tmp && curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-`uname -s`-`uname -m` -o envsubst2 && chmod a+rx envsubst2 && sudo cp envsubst2 /usr/local/bin
    ```

=== "Linux"
    ```shell
    ---
    validate: which envsubst2
    ---
    cd /tmp && curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst-`uname -s`-`uname -m` -o envsubst2 && chmod a+rx envsubst2 && sudo cp envsubst2 /usr/local/bin
    ```

=== "Windows"
    TODO, /usr/local/bin isn't right.
    
    ```shell
    ---
    validate: which envsubst2
    ---
    cd /tmp && curl -L https://github.com/a8m/envsubst/releases/download/v1.2.0/envsubst.exe -o envsubst2.exe && chmod a+rx envsubst2.exe && sudo cp envsubst2.exe /usr/local/bin
    ```
