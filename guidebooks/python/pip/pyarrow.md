# Install pyarrow

[Apache Arrow](https://arrow.apache.org/docs/index.html) is a
development platform for in-memory analytics. It contains a set of
technologies that enable big data systems to store, process and move
data fast.

See the [parent
documentation](https://arrow.apache.org/docs/index.html) for
additional details on the Arrow Project itself, on the Arrow format
and the other language bindings.

The Arrow Python bindings (also named “PyArrow”) have first-class
integration with NumPy, pandas, and built-in Python objects. They are
based on the C++ implementation of Arrow.

```shell
---
validate: pip-show pyarrow
---
pip3 install -U pyarrow
```
