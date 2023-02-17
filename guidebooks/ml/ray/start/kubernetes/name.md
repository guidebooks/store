The name of the Ray Kubernetes Service.

```shell
export RAY_KUBE_CLUSTER_NAME=$(echo ${RAY_KUBE_CLUSTER_NAME-ray-${APP_NAME-${USER-myapp}}-${JOB_ID}} | cut -c1-53)
```

> Note that we trim the cluster name so that it does not exceed 53
> characters. This is to help with fitting within the limits of
> Kubernetes, e.g. in the [name of a Helm
> chart](https://github.com/helm/helm/issues/6006).
