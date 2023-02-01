# Configure helm to mount the pvc

```shell
export HELM_EXTRA="${HELM_EXTRA} --set pvcs.rayWorkerType[0].claim=${S3_S3FS_CLAIM} --set pvcs.rayWorkerType[0].mountPath=\"${S3_DATAPATH}\""
```
