---
imports:
    - ./local/image.md
---

# JupyterLab on a local server

A JupyterLab server will run on your local computer

--8<-- "../util/working-directory.md"

```shell.async
$DOCKER run --privileged=true \
        --rm --net=host \
        -v $CUSTOM_WORKING_DIR:/home/ray/code \
        -u root \
        --name jupyterlab \
        docker.io/metalcycling/jupyterlab:latest jupyter-lab \
        --notebook-dir=/home/ray/code --port=8888 --no-browser --allow-root
```

```shell
while [ "$($DOCKER ps -q -f name=jupyterlab)" = "" ]
do
    sleep 1
done

sleep 1

server_data=$($DOCKER exec jupyterlab jupyter server list --json)
url=$($DOCKER exec jupyterlab python3 -c "false = False; print(${server_data}['url'])")
token=$($DOCKER exec jupyterlab python3 -c "false = False; print(${server_data}['token'])")
xdg-open ${url}lab?token=${token}

while true
do
    sleep 1
done
```
