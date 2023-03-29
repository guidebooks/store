---
imports:
    - kubernetes/choose/ns
---

```shell
export JOB_NAME=GettingStartedDemo
```

## Create a Staging Directory

```shell
export CUSTOM_WORKING_DIR=$(mktemp -d)
```

## Base image

```shell
export RAY_VERSION=2.3.0
```

```shell
export RAY_TAG_SUFFIX=$(if [[ $KUBE_CONTEXT =~ kind ]] && [[ $(uname -m) = arm64 ]]; then echo '-aarch64'; fi)
```

## Set up the PIP requirements

```shell
cat << EOF > $CUSTOM_WORKING_DIR/requirements.txt
--8<-- "./requirements.txt"
EOF
```

## Set up the Source Code

```shell
cat << EOF > $CUSTOM_WORKING_DIR/main.py
--8<-- "./main.py"
EOF
```
