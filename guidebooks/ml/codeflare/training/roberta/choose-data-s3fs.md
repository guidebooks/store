---
imports:
    - s3/choose/bucket
    - kubernetes/choose/ns
---

If your input shards are in S3, but your application logic is coded to assume the shards can be accessed as local files, select this option.

```shell
export ML_CODEFLARE_ROBERTA_DATA=premounted
```

```shell
export ML_CODEFLARE_ROBERTA_S3FS_CLAIM=ml.codeflare.roberta.s3fs
```

```shell
export ML_CODEFLARE_ROBERTA_S3FS_SECRET=ml.codeflare.roberta.s3fs
```

What is the path to your folder in S3?

=== "S3 folder that contains input shards [default: input/]"
    ```shell
    export ML_CODEFLARE_ROBERTA_DATAPATH="/data/${choice}"
    ```

## Create the S3FS Secret

```shell
(kubectl delete ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} secret ${ML_CODEFLARE_ROBERTA_S3FS_SECRET} >& /dev/null || exit 0)

kubectl create ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
  secret generic ${ML_CODEFLARE_ROBERTA_S3FS_SECRET} \
  --type=ibm/ibmc-s3fs \
  --from-literal=access-key=${AWS_ACCESS_KEY_ID} \
  --from-literal=secret-key=${AWS_SECRET_ACCESS_KEY}
```

## Create the S3FS PersistentVolumeClaim

```shell
(kubectl delete ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pvc $ML_CODEFLARE_ROBERTA_S3FS_CLAIM >& /dev/null || exit 0)

cat << EOF | kubectl apply ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -f -
--8<-- "./pvc.yaml"
EOF
```

## Configure helm to mount the pvc

```shell
export HELM_EXTRA="${HELM_EXTRA} --set pvcs.rayWorkerType[0].claim=${ML_CODEFLARE_ROBERTA_S3FS_CLAIM} --set pvcs.rayWorkerType[0].mountPath=${ML_CODEFLARE_ROBERTA_DATAPATH}"
```
