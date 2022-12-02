---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

```shell
export ML_RAY_STORAGE_S3_KUBERNETES_SECRET=ml.ray.s3.kubernetes.secret
```

```shell
---
validate: |
  [ -n "$ML_RAY_STORAGE_S3_KUBERNETES_SECRET" ] && kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} secret $ML_RAY_STORAGE_S3_KUBERNETES_SECRET
---
kubectl create ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} secret generic $ML_RAY_STORAGE_S3_KUBERNETES_SECRET --from-literal=ENDPOINT_URL=${S3_ENDPOINT_URL} --from-literal=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID --from-literal=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
```
