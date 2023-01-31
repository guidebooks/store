---
imports:
    - s3/choose/_bucket
    - kubernetes/choose/ns
    - ./storage-class
---

```shell
export S3_DATA=premounted
```

```shell
export S3_S3FS_CLAIM="s3fs.claim.${S3_BUCKET}"
```

```shell
export S3_S3FS_SECRET="s3fs.secret.${S3_BUCKET}"
```

# Specify an S3 folder

Under the given bucket, which path do you wish to be mounted? Note:
your data will be mounted under `$S3_DATAPATH`. Make sure your code
uses this environment variable to find the input data.

=== "S3 path to be mounted [default: input/]"

    ```shell
    export S3_OBJECTPATH="${choice}"
    ```

    ```shell
    export S3_DATAPATH="/data/${choice}"
    ```

## Create the S3FS Secret

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

## Create the S3FS PersistentVolumeClaim

```shell
cat << EOF | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./pvc.yaml"
EOF
```

## Configure helm to mount the pvc

```shell
export HELM_EXTRA="${HELM_EXTRA} --set pvcs.rayWorkerType[0].claim=${S3_S3FS_CLAIM} --set pvcs.rayWorkerType[0].mountPath=${S3_DATAPATH}"
```
