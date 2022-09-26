---
imports:
    - util/jq
    - kubernetes/kubectl
    - kubernetes/choose/ns
---

## Verify UID Range for your Namespace

For certain versions of OpenShfit, it might be necessary to edit the
default UID range so that pods in this namespace run as user ray=1000
by default ([reference](https://access.redhat.com/solutions/2801791)).

#### Run on a Kubernetes Cluster

```shell
---
validate: |
  --8<-- "./uid-range-validate.sh"
---
--8<-- "./uid-range-update.sh"
```

Not changing the UID can cause permissions problems when the Ray
Operator attempts to initialize a new Ray Cluster. In these cases, the
RayCluster will appear in the list from `kubectl get raycluster`, but `kubectl
describe raycluster your-cluster-name` will show permissions errors. If
you skip this step initially, you will need to delete the cluster and
scale down the operator, apply this step, and scale the operator back
up, then recreate the cluster.

