# Provide custom base image to be used
<!-- this will override the default ray image choice in ml/ray/run -->
=== "Provide custom base image, if any [default: rayproject/ray:1.13.1-py37]"    
    ```shell
    export RAY_IMAGE=${choice}
    ```
