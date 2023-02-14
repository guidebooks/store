---
imports:
    - util/jobid
    - ml/codeflare/job/log/init/s3
    - ml/ray/start
    - ./choose-model
    - ./choose-glue-data
    - ./setup
    - ./submit
---

<!--    - ../../../../s3/create/kubernetes/secret-if-needed.md -->

# The General Language Understanding Evaluation (GLUE) benchmark

The General Language Understanding Evaluation (GLUE) benchmark is a collection of resources for training, evaluating, and analyzing natural language understanding systems. GLUE consists of:

- A benchmark of nine sentence- or sentence-pair language understanding tasks built on established existing datasets and selected to cover a diverse range of dataset sizes, text genres, and degrees of difficulty,
- A diagnostic dataset designed to evaluate and analyze model performance with respect to a wide range of linguistic phenomena found in natural language, and
- A public leaderboard for tracking performance on the benchmark and a dashboard for visualizing the performance of models on the diagnostic set.
