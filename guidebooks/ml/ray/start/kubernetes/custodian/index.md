---
imports:
    - kubernetes/choose/ns
    - ./image
    - ../label-selectors
---

# Provision a Custodian for our Helm Chart

```shell
# Install custodian pod

# CPU FILES
AWKFILE=$(mktemp)
cat << 'EOF' | base64 > $AWKFILE
--8<-- "./resources/cpu.awk"
EOF
export CPU_AWK_B64=$(cat $AWKFILE)
rm -f $AWKFILE
SHELLFILE=$(mktemp)
cat << EOF | base64 > $SHELLFILE
--8<-- "./resources/cpu.sh"
EOF
export CPU_B64=$(cat $SHELLFILE)
rm -f $SHELLFILE

# MEMORY FILES
AWKFILE=$(mktemp)
cat << 'EOF' | base64 > $AWKFILE
--8<-- "./resources/memory.awk"
EOF
export MEMORY_AWK_B64=$(cat $AWKFILE)
rm -f $AWKFILE
SHELLFILE=$(mktemp)
cat << EOF | base64 > $SHELLFILE
--8<-- "./resources/memory.sh"
EOF
export MEMORY_B64=$(cat $SHELLFILE)
rm -f $SHELLFILE

cat << EOF | kubectl apply $KUBE_CONTEXT_ARG $KUBE_NS_ARG -f -
--8<-- "./custodian.yaml"
EOF
```

