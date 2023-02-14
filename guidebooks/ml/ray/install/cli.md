---
imports:
    - python/venv/setup
---

# Install the Ray CLI

```shell
export RAY_VENV_PATH=${GUIDEBOOK_GLOBAL_DATA_PATH}/venvs/ray/${RAY_PIP_VERSION-2.1}
```

```shell
---
validate: |
  [ -n "${RAY_VENV_PATH}" ] && [ -e "${RAY_VENV_PATH}/bin/ray" ]
---
if [ ! -d "${RAY_VENV_PATH}" ]; then
    echo "Creating python venv ${RAY_VENV_PATH}"
    python3 -m venv "${RAY_VENV_PATH}"
fi
source "${RAY_VENV_PATH}"/bin/activate
pip3 install grpcio==1.52.0 "ray[default]==${RAY_PIP_VERSION-2.1}"
```
