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
export S3_ENDPOINT_URL=http://minio-svc:9000
```

```shell
export AWS_ACCESS_KEY_ID=minioadmin
```

```shell
export AWS_SECRET_ACCESS_KEY=minioadmin
```

```shell
---
validate: kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod minio
---
kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} exec minio-client -- mc alias set minio $S3_ENDPOINT_URL $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY
```
