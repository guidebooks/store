# Stream out Events from the Ray Head Node

Kubernetes doesn't give us a great way to filter out events that are
not associated with our job. We pipe to grep here to work around that. 

```shell.async
--8<-- "./events.sh"
```
