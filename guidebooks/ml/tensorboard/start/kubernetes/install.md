---
imports:
    - kubernetes/kubectl
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
    - ml/ray/run/logs-in-s3
---

# Run The Tensorboard Server in Kubernetes

Run The Tensorboard Server in Kubernetes.

```shell
export S3_BUCKETTENSORBOARD=${S3_BUCKETRAYLOGS}/tensorboard
```

```shell
---
validate: |
  if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} deploy tensorboard; else exit 1; fi
---
--8<-- "./install.sh"
```
