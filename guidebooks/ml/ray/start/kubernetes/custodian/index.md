---
imports:
    - kubernetes/choose/ns
    - ./image
    - ../label-selectors
---

# Provision a Custodian for our Helm Chart

```shell
# Install custodian pod

TMPFILE=$(mktemp)

# CPU FILES
cat << 'EOF' | base64 | tr -d '\n' > $TMPFILE
--8<-- "./resources/cpu.awk"
EOF
export CPU_AWK_B64=$(cat $TMPFILE)
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./resources/cpu.sh"
EOF
export CPU_B64=$(cat $TMPFILE)

# MEMORY FILES
cat << 'EOF' | base64 | tr -d '\n' > $TMPFILE
--8<-- "./resources/memory.awk"
EOF
export MEMORY_AWK_B64=$(cat $TMPFILE)
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./resources/memory.sh"
EOF
export MEMORY_B64=$(cat $TMPFILE)

# GPU FILES
cat << 'EOF' | base64 | tr -d '\n' > $TMPFILE
--8<-- "./resources/gpu.awk"
EOF
export GPU_AWK_B64=$(cat $TMPFILE)
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./resources/gpu.sh"
EOF
export GPU_B64=$(cat $TMPFILE)

# RUNTIME ENV SETUP
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./events/runtime-env-setup.sh"
EOF
export RUNTIME_ENV_B64=$(cat $TMPFILE)

rm -f $TMPFILE

cat << EOF | kubectl apply $KUBE_CONTEXT_ARG $KUBE_NS_ARG -f -
--8<-- "./custodian.yaml"
EOF
```

