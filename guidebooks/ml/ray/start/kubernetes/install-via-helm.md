---
imports:
    - ./label-selectors
    - ml/ray/cluster/kubernetes/choose-pod-scheduler
    - ./invoke-helm
    - ./wait-for-head
    - ml/ray/cluster/kubernetes
    - ml/ray/cluster/head
    - ./wait-for-workers
---

# Install Ray in Kubernetes via Helm

This defines the base docker image we will use for the ray head and worker nodes.

