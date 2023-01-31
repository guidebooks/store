# Create the S3FS Secret

```shell
kubectl create ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
  secret generic \
  --save-config --dry-run=client -o yaml \
  ${S3_S3FS_SECRET} \
  --type=ibm/ibmc-s3fs \
  --from-literal=access-key=${AWS_ACCESS_KEY_ID} \
  --from-literal=secret-key=${AWS_SECRET_ACCESS_KEY} \
  | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
```
