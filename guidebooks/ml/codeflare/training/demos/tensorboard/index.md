---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ./setup
    - ml/ray/start
finally:
    - ./cleanup
    - ml/ray/stop/kubernetes/with-known-cluster-name
---

# Simple Training Demo that uses Tensorboard

This quickstart will show how to quickly get started with TensorBoard. Using the [MNIST](https://en.wikipedia.org/wiki/MNIST_database) dataset as the example, normalize the data and write a function that creates a simple Keras model for classifying the images into 10 classes.
