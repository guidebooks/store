# Wait, if requested

In some debugging cases it might be useful to wait for a bit. TODO:
this really should be wait, if we are executing this as a top-level
guidebook. That is, if the user only wants to set up the port
forwarding, then we shouldn't exit. This is the hack for now: set
`WAIT=true` when running this guidebook in this scenarios.

```shell
if [ -n "$WAIT" ]; then echo ${RAY_KUBE_PORT-8266}; sleep 100000; fi
```
