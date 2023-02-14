---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ml/mlflow/start
    - ml/ray/start
    - ./setup
    - ./submit
finally:
    - ./cleanup
    - ml/ray/stop/kubernetes/with-known-cluster-name
---

# Simple Training Demo that uses MLFlow

Trains an [MNIST](https://en.wikipedia.org/wiki/MNIST_database) digit recognizer using PyTorch Lightning, and uses
Mlflow to log metrics, params and artifacts.
