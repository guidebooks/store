---
imports:
    - ../install/index.md
---

# Run a Ray Job

=== "Hello world"
    ```python
    import ray
    ray.init()

    @ray.remote
    def f(x):
        return x * x

    futures = [f.remote(i) for i in range(4)]
    print(ray.get(futures)) # [0, 1, 4, 9]
    ```
