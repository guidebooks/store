Now we can capture what the server-side is streaming to its
(server-side) ephemeral directory, and stream it to the local LOGDIR.

TODO we should capture this from the server-side, rather than hard-coding here.
```shell
export LOG_AGGREGATOR_LOGDIR=/root/.local/share/madwizard-nodejs/default/jobs/$JOB_ID
```

