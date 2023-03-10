---
imports:
    - python/venv/setup
---

# Install the TorchX CLI

[TorchX](https://pytorch.org/torchx/latest/) is a universal job
launcher for PyTorch applications. TorchX is designed to have fast
iteration time for training/research and support for E2E production ML
pipelines when you’re ready.

```shell
export TORCHX_VENV_PATH=${GUIDEBOOK_GLOBAL_DATA_PATH}/venvs/torchx/${TORCHX_PIP_VERSION-0.5.0dev}
```

```shell
---
validate: |
  [ -n "${TORCHX_VENV_PATH}" ] && [ -e "${TORCHX_VENV_PATH}/bin/torchx" ]
---
if [ ! -d "${TORCHX_VENV_PATH}" ]; then
    echo "Creating python venv ${TORCHX_VENV_PATH}"
    python3 -m venv "${TORCHX_VENV_PATH}"
fi
source "${TORCHX_VENV_PATH}"/bin/activate
pip3 install -e git+https://github.com/pytorch/torchx.git#egg="torchx[dev]"
```
