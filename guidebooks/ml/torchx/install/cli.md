# Install the TorchX CLI

[TorchX](https://pytorch.org/torchx/latest/) is a universal job
launcher for PyTorch applications. TorchX is designed to have fast
iteration time for training/research and support for E2E production ML
pipelines when you’re ready.

```shell
export PATH=~/.local/bin:$PATH:~/Library/Python/3.9/bin:~/Library/Python/3.8/bin:~/Library/Python/3.7/bin:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:/usr/local/opt/python@3.8/Frameworks/Python.framework/Versions/3.8/bin:/usr/local/opt/python@3.7/Frameworks/Python.framework/Versions/3.7/bin
```

```shell
---
validate: which torchx
---
(which torchx >& /dev/null) || pip3 install -U "torchx[dev]"
```
