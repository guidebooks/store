---
imports:
    - util/jobid
    - ./setup
    - ml/ray/start
    - ml/ray/aggregator/with-jobid
finally:
    - ./cleanup
    - ml/ray/stop/kubernetes/with-known-cluster-name
---

# Simple Training Demo

This quickstart will show how to quickly get started with submitting distributed training jobs in CodeFlare.
