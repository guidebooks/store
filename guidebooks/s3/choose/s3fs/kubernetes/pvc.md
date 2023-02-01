# Create the S3FS Persistent Volume Claim

In order to allow your code access to an S3 data via S3FS, you will
need to create a "claim" against the storage that S3FS exposes. In
Kubernetes, this claim is manifested by creating a
[`PersistentVolumeClaim`](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
resource.

## Delete Existing PVC, if needed

Kubernetes does not allow apply-updating a PVC with a different
storage class. So we will need to delete the existing PVC if the
desired storage class does not match the current storage class.

```shell
EXISTING_STORAGE_CLASS=$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pvc "$S3_S3FS_CLAIM" -o custom-columns=.SC:.spec.storageClassName --no-headers --ignore-not-found)
if [ -n "$EXISTING_STORAGE_CLASS" ] && [ "$EXISTING_STORAGE_CLASS" != "${S3_STORAGE_CLASS-ibmc-s3fs-standard-cross-region}" ]; then
    echo "Deleting existing PVC because storage class has changed"
    kubectl delete ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pvc "$S3_S3FS_CLAIM"
fi
```

## Create PVC

Now we are ready to create the PVC.

```shell
cat << EOF | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./pvc.yaml"
EOF
```
