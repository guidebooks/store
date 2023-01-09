---
imports:
    - util/jobid
    - ./form
    - kubernetes/secrets/image-pull
    - s3/choose/bucket/maybe
    - ml/ray/storage/s3/maybe
    - ml/ray/run/logs/init.md
    - ml/ray/start
    - ./submit
    - ml/ray/stop/kubernetes/with-known-cluster-name
---

# Bring Your Own Code

This path provides a way for you to run your own custom code on a
remote ray cluster.  Specify the location of your source code and the
base image you would like to use. Currently, there is a convention for
your code source directory: the main Python file should named
**main.py**; the directory may also include a **requirements.txt**
file.
