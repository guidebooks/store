---
imports:
    - ../../choose/instance.md
    - ../../kubernetes/choose/ns.md
---

# Create a Kubernetes Secret to Access your S3 Data

```shell
kubectl create secret generic ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} guidebook-s3-${S3_SERVICE} --from-literal S3_ACCESS_KEY_ID="${S3_ACCESS_KEY_ID}" --from-literal S3_SECRET_ACCESS_KEY="${S3_SECRET_ACCESS_KEY}" --from-literal S3_ENDPOINT="${S3_ENDPOINT}"
```
