---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

# Install MinIO in Kubernetes

```shell
---
validate: kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod minio
---
cat << EOF | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./minio.yaml"
---
--8<-- "./minio-client.yaml"
EOF
```

## Wait for readiness

```shell
kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} wait --for=condition=Ready pod/minio && \
  kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} wait --for=condition=Ready pod/minio-client
```

```shell
---
validate: kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod minio
---
kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} exec minio-client -- mc alias set minio http://minio-svc:9000 minioadmin minioadmin
```
