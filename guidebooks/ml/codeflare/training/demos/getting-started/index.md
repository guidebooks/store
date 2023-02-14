---
imports:
    - util/jobid
    - ml/ray/start
    - ./setup
    - ./submit
finally:
    - ./cleanup
    - ml/ray/stop/kubernetes/with-known-cluster-name
---

# Simple Training Demo

This quickstart will show how to quickly get started with submitting distributed training jobs in CodeFlare.
