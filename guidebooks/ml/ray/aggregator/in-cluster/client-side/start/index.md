---
imports:
    - ml/ray/run/choose
    - ./with-jobid
---

# Start a Log Aggregation Instance (client-side)

This guidebook communicates with previously deployed (via
`./deploy.md`) log aggregator pod to start streaming. It will first
query the user for identify a job.
