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

=== "Use GPUs"
    Select this if your system has Nvidia GPUs that can be used to accelerate the job.

    ```shell
    export GPU_OPTION="--use-gpu"
    ```

    ```shell
    export NUM_WORKERS=${NUM_GPUS-1}
    ```

=== "Don't use GPUs"
    Otherwise, the training will run much more slowly, using your CPUs.

    ```shell
    export GPU_OPTION="--no-use-gpu"
    ```
    
    ```shell
    export NUM_WORKERS=${NUM_CPUS-1}
    ```

```python
---
exec: ray-submit --job-id ${JOB_ID} --no-wait -- --datapath /tmp/ --modelpath /tmp/ --num_workers ${NUM_WORKERS} ${GPU_OPTION}
---
--8<-- "ray-bert-vanilla.py"
```

--8<-- "../../../ray/run/logs.md"

