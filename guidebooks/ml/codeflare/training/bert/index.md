---
imports:
    - ../../../ray/hacks/openshift/uid-range.md
    - ../../../ray/start/index.md
    - ../../../../python/pip/torch.md
---

# Distributed Language Modeling with BERT

This demo contains code for pre-training a bare-bones BERT model on the Masked Language Modeling (MLM) task, using Ray for distribution on OpenShift. We will be using a pre-tokenized version of Wikitext-103, a small dataset mainly for functional tests. This code is based off the HuggingFace BERT demo, but is free of all dependencies.

## Run it

Submit the job.

```python
---
exec: ray-submit --job-id ${uuid} --no-wait -- --datapath /tmp/ --modelpath /tmp/ --gpus ${NUM_GPUS-1}
---
--8<-- "ray-bert-vanilla.py"
```

Wait for the job to flow through into the system.

```shell
while true; do if [ "$(ray job status ${uuid} >& /dev/null && echo 1 || echo 0)" = "1" ]; then break; sleep 1; fi; done
```

And then stream out the logs.

```shell
ray job logs -f ${uuid} 2> /dev/null
```
