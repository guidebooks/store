# "Set docker executable"
```shell
export DOCKER=docker
```

# If 'docker' is not available use 'podman'
```shell
---
validate: which docker
---
export DOCKER=podman
```

# If 'docker' is not available use 'podman'
```shell
---
validate: which podman
---
echo "No container builder (e.g., docker, podman) was found"
exit 1
```

# "Pulling image"
```bash
$DOCKER pull docker.io/metalcycling/jupyterlab
```
