---
imports:
    - util/jobid
    - kubernetes/kubectl
    - ./resources
    - kubernetes/choose/ns
    - ./kubernetes/name
    - ./kubernetes/events
    - ./kubernetes/install-via-helm
    - ml/ray/start/kubernetes/self-destruct
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.
