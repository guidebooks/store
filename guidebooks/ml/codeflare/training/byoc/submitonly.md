---
imports:
    - util/jobid
    - ./form
    - kubernetes/choose/secret/image-pull
    - s3/choose/bucket/maybe
    - ml/ray/storage/s3/maybe
    - ml/ray/run/logs/init.md
    - ml/ray/start
---

# Bring Your Own Code

This option lets you submit custom [Ray](https://www.ray.io/) code to
run on a [Kubernetes](https://kubernetes.io/) cluster. Identify your
source code and the base image to use, and it will take care of the
rest. Note: there is a convention for your code source directory: the
main Python file should named **main.py**, and the directory may also
include a **requirements.txt** file.
