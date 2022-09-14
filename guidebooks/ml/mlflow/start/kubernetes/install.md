---
imports:
    - kubernetes/kubectl
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
    - ml/ray/run/logs-in-s3
---

# Run The MLFlow Server in Kubernetes

Run The MLFlow Server in Kubernetes.

```shell
export S3_BUCKETMLFLOW=${S3_BUCKETRAYLOGS}/mlflow
```

```shell
---
validate: |
  if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} deploy mlflow; else exit 1; fi
---
--8<-- "./install.sh"
```
