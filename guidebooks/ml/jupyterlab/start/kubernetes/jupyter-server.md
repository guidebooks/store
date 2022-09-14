---
imports:
    - ml/ray/cluster/head
---

# Create working directory and copy everything in the local working directory to the server working directory

```shell
oc exec -it $RAY_HEAD_POD -- mkdir -p /home/ray/work
tar -zcvf .work.tar -C $CUSTOM_WORKING_DIR .
kubectl cp .work.tar $RAY_HEAD_POD:/home/ray/work
oc exec $RAY_HEAD_POD -- bash -c -- "tar -xvf /home/ray/work/.work.tar -C /home/ray/work; rm /home/ray/work/.work.tar"
rm .work.tar
```

# Initiate Jupyter-lab server on the head node of the Ray cluster

```shell
oc exec -it $RAY_HEAD_POD -- jupyter-lab --port=8888 --no-browser --notebook-dir=/home/ray/work
```

# On completion of the Jupyter-lab cluster work, copy everything back to the local working directory

```shell
oc exec $RAY_HEAD_POD -- tar -zcvf .work.tar -C /home/ray/work .
kubectl cp $RAY_HEAD_POD:/home/ray/.work.tar $CUSTOM_WORKING_DIR/.work.tar
oc exec $RAY_HEAD_POD -- rm /home/ray/.work.tar
tar -xvf $CUSTOM_WORKING_DIR/.work.tar -C $CUSTOM_WORKING_DIR .
rm $CUSTOM_WORKING_DIR/.work.tar
```
