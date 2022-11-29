In Kubernetes,
[namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
provide a mechanism for isolating groups of resources within a single
cluster. Names of resources need to be unique within a namespace, but
not across namespaces. Namespace-based scoping is applicable only for
namespaced objects (e.g. Deployments, Services, etc) and not for
cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes,
etc).


