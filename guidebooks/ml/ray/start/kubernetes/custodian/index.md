---
imports:
    - kubernetes/choose/ns
    - ./image
    - ../label-selectors
---

# Provision a Custodian for our Helm Chart

```shell
# Install custodian pod

AWKFILE=$(mktemp)
cat << 'EOF' | base64 > $AWKFILE
--8<-- "./resources/cpu.awk"
EOF
export POD_VMSTAT_AWK_B64=$(cat $AWKFILE)
rm -f $AWKFILE

SHELLFILE=$(mktemp)
cat << EOF | base64 > $SHELLFILE
--8<-- "./resources/cpu.sh"
EOF
export POD_VMSTAT_B64=$(cat $SHELLFILE)
rm -f $SHELLFILE

cat << EOF | kubectl apply $KUBE_CONTEXT_ARG $KUBE_NS_ARG -f -
--8<-- "./custodian.yaml"
EOF
```

