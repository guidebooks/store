---
imports:
    - kubernetes/kubectl
    - kubernetes/choose/ns
    - ../names
    - ./ask-server-to-start
    - ./setup-local-stream
    - ml/ray/aggregator/with-jobid
---

# Start a Log Aggregation Instance (client-side, given JOB_ID)

