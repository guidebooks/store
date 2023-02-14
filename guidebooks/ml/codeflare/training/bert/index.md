---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3.md
    - ml/ray/v1
    - ml/ray/start
    - ./setup
    - ./submit
finally:
    - ./cleanup
    - ml/ray/stop/kubernetes/with-known-cluster-name
---

# Distributed Language Modeling with BERT

This demo contains code for pre-training a bare-bones BERT model on the Masked Language Modeling (MLM) task, using Ray for distribution on OpenShift. We will be using a pre-tokenized version of Wikitext-103, a small dataset mainly for functional tests. This code is based off the HuggingFace BERT demo, but is free of all dependencies.
