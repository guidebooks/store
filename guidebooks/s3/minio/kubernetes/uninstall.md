---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

# Uninstall MinIO in Kubernetes

```shell
cat << EOF | kubectl delete ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./minio.yaml"
---
--8<-- "./minio-client.yaml"
EOF
```
