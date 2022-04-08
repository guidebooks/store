---
title: Prerequisites
imports:
    - ../../../../kubernetes/kubectl.md
---

## Prerequisites

!!! caution
    The system requirements provided are recommendations only. The requirements for your installation might vary, depending on whether you use optional components, such as a networking layer.

- You have a cluster that uses Kubernetes v1.21 or newer.
- You have installed the [`kubectl` CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
- Your Kubernetes cluster must have access to the internet, because Kubernetes needs to be able to fetch images. To pull from a private registry, see [Deploying images from a private container registry](/docs/serving/deploying-from-private-registry/).
