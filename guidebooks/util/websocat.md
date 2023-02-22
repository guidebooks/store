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
        F=$(mktemp)
        curl -L https://github.com/vi/websocat/releases/download/v1.8.0/websocat_amd64-linux-static > $F
        chmod a+rx $F
        sudo mv $F /usr/local/bin
        ```
   
    === "ARM"
        ```shell
        F=$(mktemp)
        curl -L https://github.com/vi/websocat/releases/download/v1.8.0/websocat_arm-linux-static > $F
        chmod a+rx $F
        sudo mv $F /usr/local/bin
        ```

=== "Windows"
    ```shell
    echo "Automatic installation not yet supported. Please install via https://github.com/vi/websocat#installation"
    exit 1
    ```
