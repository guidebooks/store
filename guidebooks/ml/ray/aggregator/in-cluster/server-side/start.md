---
imports:
    - ./setup
    - ../../with-jobid
---

# Start up Log Aggregator inside a Kubernetes Cluster

This guidebook is intended to be run *inside* your Kubernetes
cluster. If you are looking for the guidebook to deploy this
in-cluster pod, look at `../client-side/deploy.md`; to start an
aggregation instance, look at `../client-side/start.md`.

This guidebook is the same as the `../../with-jobid` guidebook, in
that it assumes some external agent has set the `JOB_ID` environment
variable.

