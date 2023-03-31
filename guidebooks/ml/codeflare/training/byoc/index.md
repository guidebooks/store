---
imports:
    - ./submitonly
    - ml/ray/aggregator/with-jobid
---

# Bring Your Own Code

This option lets you submit custom [Ray](https://www.ray.io/) code to
run on a [Kubernetes](https://kubernetes.io/) cluster. Identify your
source code and the base image to use, and it will take care of the
rest. Note: there is a convention for your code source directory: the
main Python file should named **main.py**, and the directory may also
include a **requirements.txt** file.
