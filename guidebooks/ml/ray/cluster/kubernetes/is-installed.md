---
imports:
    - util/jq
    - kubernetes/helm3
    - kubernetes/context
    - kubernetes/choose/ns
---

# Ray-in-Kubernetes Provisioning Status

This guidebook checks whether your Ray cluster has been provisioned in
your Kubernetes cluster. It does not check whether there is a quorum
of head and worker nodes ready. For that, use `ml/ray/cluster/kubernetes/is-ready`

```shell
helm status ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} ${RAY_KUBE_CLUSTER_NAME-mycluster} -o json | jq .info
```

This guidebook will `exit 1` if your Ray cluster has not been
provisioned. If it has, then you should expect JSON like this:

```json
{
  "first_deployed": "2022-07-19T09:08:19.451684-04:00",
  "last_deployed": "2022-07-19T09:13:50.892238-04:00",
  "deleted": "",
  "description": "Upgrade complete",
  "status": "deployed"
}
```

This guidebook will not watch the status of your provisioning. For
that, use `ml/ray/cluster/kubernetes/is-ready`.
