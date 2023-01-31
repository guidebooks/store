# Create the S3FS PersistentVolumeClaim

```shell
cat << EOF | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./pvc.yaml"
EOF
```
