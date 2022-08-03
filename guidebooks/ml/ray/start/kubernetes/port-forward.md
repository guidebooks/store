# Start up a Kubernetes port-forwards to the cluster

In order to facilitate communication from one's personal computer to
the Kubernetes services, we set up a number of Kubernetes
[port-forwards](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/).

--8<-- "./port-forward/ray.md"

## Wait, if requested

In some debugging cases it might be useful to wait for a bit. TODO:
this really should be wait, if we are executing this as a top-level
guidebook. That is, if the user only wants to set up the port
forwarding, then we shouldn't exit. This is the hack for now: set
`WAIT=true` when running this guidebook in this scenarios.

```shell
if [ -n "$WAIT" ]; then sleep 100000; fi
```
