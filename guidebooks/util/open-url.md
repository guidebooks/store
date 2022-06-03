# Open an URL

Given the environment variable OPEN_THIS_URL, this guidebook opens up
a local browser tab to display that URL.

=== "MacOS"
    ```shell
    open "${OPEN_THIS_URL}"
    ```
    
=== "Linux"
    ```shell
    xdg-open "${OPEN_THIS_URL}"
    ```

=== "Windows"
    ```shell
    start "${OPEN_THIS_URL}"
    ```
