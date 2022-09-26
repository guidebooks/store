# Fetch Tensboard Log Files to this Machine

## "Run on a Kubernetes Cluster"

In this case, we will need to rsync the data over. We will be using `rsync` to do that.

:import{../../../openshift/oc.md}

Instead of pointing Tensorboard to `<ourLocalTempDir>`
(e.g. `/tmp/random123`), we point it to `<ourLocalTempDir>/<jobid>`
(e.g. `/tmp/random123/random456`), to it focused on this job. This is
why we tack on the `$(basename TB_LOCAL_LOGDIR)`.

```shell
export TB_LOCAL_LOGDIR_FOR_RSYNC=$(mktemp -d)
```

```shell
export TB_LOCAL_LOGDIR="${TB_LOCAL_LOGDIR_FOR_RSYNC}/$(basename ${TB_LOGDIR})"
```

```shell.async
while true; do kubectl get pod -l ${KUBE_POD_LABEL_SELECTOR} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} --template '{{range .items}}{{.metadata.name}}{{end}}' | xargs -I POD -n1 rsync --inplace --archive --no-owner --no-group --omit-dir-times --numeric-ids --quiet --rsh="oc rsh ${KUBE_NS_ARG} ${KUBE_CONTEXT_ARG}" POD:${TB_LOGDIR} ${TB_LOCAL_LOGDIR_FOR_RSYNC}; sleep 10; done
```
