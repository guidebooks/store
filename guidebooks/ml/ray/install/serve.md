---
imports:
    - ../../../python/pip/fastapi.md
    - ../../../python/pip/uvicorn.md
    - ../../../python/pip/aiorwlock.md
    - ../../../python/pip/scikit-learn.md
---

# Install Ray Serve

--8<-- "../glossary/serve.md"

To get started with Ray Serve, you will need to install a library.

```shell
---
validate: pip-show ray[serve]
---
pip3 install -U "ray[serve]"
```

