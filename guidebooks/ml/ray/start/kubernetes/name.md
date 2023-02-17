The name of the Ray Kubernetes Service.

```shell
export RAY_KUBE_CLUSTER_NAME=$(echo ${RAY_KUBE_CLUSTER_NAME-ray-${APP_NAME-${USER-myapp}}-${JOB_ID}} | cut -c1-53 | tr '[:upper:]' '[:lower:]')
```

> Note: we trim the cluster name so that it does not exceed 53
> characters. This is to help with fitting within the limits of
> Kubernetes, e.g. in the [name of a Helm
> chart](https://github.com/helm/helm/issues/6006).

> Note: we downcase at the end (using `tr`), as Helm and Kubernetes
> require lowercase characters. For reference, the validation regexp
> is
> `^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$`
