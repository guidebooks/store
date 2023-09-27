```shell
export TORCHX_PIP_VERSION=${TORCHX_PIP_VERSION-0.6.0}
```

```shell
export KUBERNETES_PIP_VERSION=${KUBERNETES_PIP_VERSION-18.20.0}
```

python 3.9.6 on macOS does not handle spaces in the venv path, and on
macOS the user data path is "~/Library/Application Support", which
contains a space.

```shell
export GUIDEBOOK_GLOBAL_DATA_PATH_HACK=~/.codeflare
```

```shell
mkdir -p "$GUIDEBOOK_GLOBAL_DATA_PATH_HACK"
```

```shell
export TORCHX_VENV_PATH=${GUIDEBOOK_GLOBAL_DATA_PATH_HACK}/venvs/torchx/${TORCHX_PIP_VERSION}
```

