---
imports:
    - ../../../ray/start/index.md
    - ../../../ray/start/gpus.md
    - ../../../ray/hacks/openshift/uid-range.md
    - ../../../../util/jobid.md
    - ../../../../python/pip/torch.md
---

# Distributed Language Modeling with BERT

This demo contains code for pre-training a bare-bones BERT model on the Masked Language Modeling (MLM) task, using Ray for distribution on OpenShift. We will be using a pre-tokenized version of Wikitext-103, a small dataset mainly for functional tests. This code is based off the HuggingFace BERT demo, but is free of all dependencies.

## Run it

Submit the job.

```python
---
exec: ray-submit --job-id ${JOB_ID} --no-wait -- --datapath /tmp/ --modelpath /tmp/ --num_workers ${NUM_WORKERS} ${GPU_OPTION}
---
--8<-- "ray-bert-vanilla.py"
```

--8<-- "../../../ray/run/logs.md"

