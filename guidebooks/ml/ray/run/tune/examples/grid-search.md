---
imports:
    - ../../../install/tune.md
---

# Tune: Hypermarameter Tuning at Scale

--8<-- "../../../glossary/tune.md"

```python
---
exec: ray-submit --job-id ${JOB_ID}
---
# This example runs a small grid search with an iterative training function.
from ray import tune

# 1. Define an objective function.
def objective(config):
    score = config["a"] ** 2 + config["b"]
    return {"score": score}


# 2. Define a search space.
search_space = {
    "a": tune.grid_search([0.001, 0.01, 0.1, 1.0]),
    "b": tune.choice([1, 2, 3]),
}

# 3. Start a Tune run and print the best result.
analysis = tune.run(objective, config=search_space)
print(analysis.get_best_config(metric="score", mode="min"))
```

