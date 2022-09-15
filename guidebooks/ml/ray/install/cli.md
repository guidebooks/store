# Install the Ray CLI

```shell
export PATH=~/.local/bin:$PATH:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:/usr/local/opt/python@3.8/Frameworks/Python.framework/Versions/3.8/bin:/usr/local/opt/python@3.7/Frameworks/Python.framework/Versions/3.7/bin
```

```shell
---
validate: which ray
---
which ray || pip install -U "ray[default]==1.13"
```
