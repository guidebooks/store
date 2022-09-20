---
imports:
    - ml/ray/cluster/head
---

```shell
export RAY_KUBE_CLUSTER_NAME=$(kubectl get pod --no-headers -l ray-node-type=head -o custom-columns=NAME:.metadata.labels.ray-cluster-name | head -1 )
```

# Start the JupyterLab server, create working directory, and copy everything in the local working directory to the server working directory

```shell
---
validate: |
    if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} get deploy ${RAY_KUBE_CLUSTER_NAME}-jupyterlab; else exit 1; fi
---

--8<-- "./install.sh"

while [ "${JUPYTERLAB_POD}" = "" ];
do
    JUPYTERLAB_POD=$(python3 -c "pod = '''$(kubectl get pods --selector app=jupyterlab-pod | grep Running)'''.split(); print(pod[0]) if len(pod) > 0 else print()")
done

echo -n "Instillaing JupyterLab..."

while [ $(oc exec $JUPYTERLAB_POD -- which jupyter-lab &> /dev/null && echo 1 || echo 0) -eq 0 ]
do
    echo -n "."
done

echo

oc exec -it $JUPYTERLAB_POD -- mkdir -p /home/ray/work
tar -zcvf .work.tar -C $CUSTOM_WORKING_DIR .
kubectl cp .work.tar $JUPYTERLAB_POD:/home/ray/work
oc exec $JUPYTERLAB_POD -- bash -c -- "tar -xvf /home/ray/work/.work.tar -C /home/ray/work; rm /home/ray/work/.work.tar"
```

```shell
export JUPYTERLAB_POD=$(python3 -c "pod = '''$(kubectl get pods --selector app=jupyterlab-pod | grep Running)'''.split(); print(pod[0]) if len(pod) > 0 else print()")
```

# Port-forward to the Jupyter-lab server

```shell.async
date > /tmp/port-forward-jupyterlab

NUM_SERVERS=0

while [ ${NUM_SERVERS} -eq 0 ];
do
    SERVER_LIST=$(oc exec $JUPYTERLAB_POD -- jupyter server list)
    NUM_SERVERS=$(oc exec $JUPYTERLAB_POD -- python3 -c "response = '''${SERVER_LIST}'''.split('\n'); print(len(response) - 1)")
    echo "Waiting for server to start..." >> /tmp/port-forward-jupyterlab
    sleep 1
done

kubectl ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} port-forward service/${RAY_KUBE_CLUSTER_NAME}-jupyterlab 8888:8888 >> /tmp/port-forward-jupyterlab
```

# Initiate Jupyter-lab server on the pod

```shell
oc exec -it $JUPYTERLAB_POD -- jupyter-lab --port=8888 --no-browser --notebook-dir=/home/ray/work
```

# On completion of the Jupyter-lab cluster work, copy everything back to the local working directory

```shell
oc exec $JUPYTERLAB_POD -- tar -zcvf .work.tar -C /home/ray/work .
kubectl cp $JUPYTERLAB_POD:/home/ray/.work.tar $CUSTOM_WORKING_DIR/.work.tar
oc exec $JUPYTERLAB_POD -- rm /home/ray/.work.tar
tar -xvf $CUSTOM_WORKING_DIR/.work.tar -C $CUSTOM_WORKING_DIR .
rm $CUSTOM_WORKING_DIR/.work.tar
```
