---
imports:
    - ../../../ray/hacks/openshift/uid-range.md
    - ../../../ray/start/index.md
    - ../../../../util/jobid.md
    - ../../../../python/pip/torch.md
---

# Distributed Language Modeling with BERT

This demo contains code for pre-training a bare-bones BERT model on the Masked Language Modeling (MLM) task, using Ray for distribution on OpenShift. We will be using a pre-tokenized version of Wikitext-103, a small dataset mainly for functional tests. This code is based off the HuggingFace BERT demo, but is free of all dependencies.

## Run it

Submit the job.

```python
---
exec: ray-submit --job-id ${JOB_ID} --no-wait -- --datapath /tmp/ --modelpath /tmp/ --gpus ${NUM_GPUS-1}
---
--8<-- "ray-bert-vanilla.py"
```

--8<-- "../../../ray/run/logs.md"

