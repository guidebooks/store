---
imports:
    - ./install
---

# Connect to MinIO client in Kubernetes

Use commands such as `mc ls minio`. Type `exit` when you are finished.

```shell
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod/minio-client -it -- bash
```
