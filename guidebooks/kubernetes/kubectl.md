---
title: Install kubectl
codeblocks:
    - match: ^\(kubectl version --client >& /dev/null\) && echo "You have kubectl!" \|\| echo "Please install kubectl"
      validate: $body
---

### The [Kubernetes CLI (`kubectl`)](https://kubernetes.io/docs/tasks/tools/install-kubectl){target=_blank}

Runs commands against Kubernetes clusters. You can use `kubectl` to deploy applications, inspect and manage cluster resources, and view logs.

```bash
(kubectl version --client >& /dev/null) && echo "You have kubectl!" || echo "Please install kubectl"
```