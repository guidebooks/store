---
imports:
    - ml/ray/cluster/head
---

```shell
export RAY_KUBE_CLUSTER_NAME=$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pod --no-headers -l ray-node-type=head -o custom-columns=NAME:.metadata.labels.ray-cluster-name | head -1 )
```

# Start the JupyterLab server, create working directory, and copy everything in the local working directory to the server working directory

```shell
---
validate: |
    if [ -n "${KUBE_CONTEXT}" ] && [ -n "${KUBE_NS}" ]; then kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} deploy ${RAY_KUBE_CLUSTER_NAME}-jupyterlab; else exit 1; fi
---

--8<-- "./install.sh"
```

```shell
kubectl wait ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} deploy/${RAY_KUBE_CLUSTER_NAME}-jupyterlab --for=condition=Available

JUPYTERLAB_POD=$(python3 -c "pod = '''$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pods --selector app=jupyterlab-pod | grep Running)'''.split(); print(pod[0]) if len(pod) > 0 else print()")

echo -n "Installing JupyterLab..."

while [ $(kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD -- which jupyter-lab &> /dev/null && echo 1 || echo 0) -eq 0 ]
do
    echo -n "."
done

echo

# This trick is used because 'kubectl cp <source>/* <pod>:<dest>' doesn't work for me
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD -- mkdir -p /home/ray/work
tar -zcvf .work.tar -C $CUSTOM_WORKING_DIR .
kubectl cp ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} .work.tar $JUPYTERLAB_POD:/home/ray/work
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD -- bash -c -- "tar -xvf /home/ray/work/.work.tar -C /home/ray/work; rm /home/ray/work/.work.tar"
```

```shell
export JUPYTERLAB_POD=$(python3 -c "pod = '''$(kubectl get ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} pods --selector app=jupyterlab-pod | grep Running)'''.split(); print(pod[0]) if len(pod) > 0 else print()")
```

# Port-forward to the Jupyter-lab server

```shell.async
date > /tmp/port-forward-jupyterlab

NUM_SERVERS=0

while [ "${NUM_SERVERS}" = "0" ];
do
    SERVER_LIST=$(kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD -- jupyter server list)
    NUM_SERVERS=$(kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD -- python3 -c "response = '''${SERVER_LIST}'''.split('\n'); print(len(response) - 1)")
    echo "Waiting for server to start..." >> /tmp/port-forward-jupyterlab
    sleep 1
done

kubectl port-forward ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} service/${RAY_KUBE_CLUSTER_NAME}-jupyterlab 8888:8888 >> /tmp/port-forward-jupyterlab
```

# Initiate Jupyter-lab server on the pod

```shell
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -it $JUPYTERLAB_POD -- jupyter-lab --port=8888 --no-browser --notebook-dir=/home/ray/work
```

# On completion of the Jupyter-lab cluster work, copy everything back to the local working directory

```shell
# This trick is used because 'kubectl cp <pod>:<source>/* <dest>' doesn't work for me
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD -- tar -zcvf .work.tar -C /home/ray/work .
kubectl cp ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD:/home/ray/.work.tar $CUSTOM_WORKING_DIR/.work.tar
kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $JUPYTERLAB_POD -- rm /home/ray/.work.tar
tar -xvf $CUSTOM_WORKING_DIR/.work.tar -C $CUSTOM_WORKING_DIR .
rm $CUSTOM_WORKING_DIR/.work.tar
```
