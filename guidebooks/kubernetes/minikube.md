---
title: Install minikube
imports:
    - docker-guidebook.md
codeblocks:
    - match: ^\(minikube version >& /dev/null\) && echo "You have minikube!" \|\| \(echo "Please install minikube" && exit 1\)$
      validate: $body
---

### [minikube](https://minikube.sigs.k8s.io/docs/start/){target=_blank} (Kubernetes in Docker)

Enables you to run a local Kubernetes cluster with Docker container nodes.

```bash
(minikube version >& /dev/null) && echo "You have minikube!" || (echo "Please install minikube" && exit 1)
```