---
validate: which websocat
---

# Websocat

Netcat, curl and socat for [WebSockets](https://en.wikipedia.org/wiki/WebSocket).

=== "MacOS"
    ```shell
    ---
    validate: which websocat
    ---
    brew install websocat
    ```
    
=== "Linux"
    === "Intel"
        ```shell
        curl -L https://github.com/vi/websocat/releases/download/v1.8.0/websocat_amd64-linux-static > websocat
        chmod a+rx websocat
        sudo mv websocat /usr/local/bin
        ```
   
    === "ARM"
        ```shell
        curl -L https://github.com/vi/websocat/releases/download/v1.8.0/websocat_arm-linux-static > websocat
        chmod a+rx websocat
        sudo mv websocat /usr/local/bin
        ```

=== "Windows"
    ```shell
    echo "Automatic installation not yet supported. Please install via https://github.com/vi/websocat#installation"
    exit 1
    ```
