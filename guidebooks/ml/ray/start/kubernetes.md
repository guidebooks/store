---
imports:
    - util/jobid
    - kubernetes/kubectl
    - ./resources
    - kubernetes/choose/ns
    - ./kubernetes/name
    - ./kubernetes/events
    - ml/ray/run/job-env
    - ./kubernetes/install-via-helm
    - ml/codeflare/custodian
---

# Install Ray on a Kubernetes Cluster

This will install Ray on a Kubernetes context of your choosing.
