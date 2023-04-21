---
imports:
    - kubernetes/choose/ns
    - ./image
    - ml/ray/start/kubernetes/label-selectors
---

# Provision a Custodian for our Helm Chart

```shell
# Install custodian pod

TMPFILE=$(mktemp)

# WORKER STATUS
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/status/worker-status.sh"
EOF
export WORKER_STATUS_B64=$(cat $TMPFILE)

# RUNTIME ENV SETUP
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/runtime-env/runtime-env-setup.sh"
EOF
export RUNTIME_ENV_B64=$(cat $TMPFILE)

# CPU FILES
cat << 'EOF' | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/cpu/cpu.awk"
EOF
export CPU_AWK_B64=$(cat $TMPFILE)
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/cpu/cpu.sh"
EOF
export CPU_B64=$(cat $TMPFILE)

# MEMORY FILES
cat << 'EOF' | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/mem/memory.awk"
EOF
export MEMORY_AWK_B64=$(cat $TMPFILE)
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/mem/memory.sh"
EOF
export MEMORY_B64=$(cat $TMPFILE)

YAML=$(mktemp)
cat << EOF > $YAML
--8<-- "./custodian.yaml"
--8<-- "./containers/logs/container.yaml"
--8<-- "./containers/status/container.yaml"
--8<-- "./containers/runtime-env/container.yaml"
--8<-- "./containers/cpu/container.yaml"
--8<-- "./containers/mem/container.yaml"
EOF

# GPU FILES
if [[ "${NUM_GPUS-0}" != "0" ]]; then 
cat << 'EOF' | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/gpu/gpu.awk"
EOF
export GPU_AWK_B64=$(cat $TMPFILE)
cat << EOF | base64 | tr -d '\n' > $TMPFILE
--8<-- "./containers/gpu/gpu.sh"
EOF
export GPU_B64=$(cat $TMPFILE)

cat << EOF >> $YAML
--8<-- "./containers/gpu/container.yaml"
EOF
fi

kubectl apply $KUBE_CONTEXT_ARG $KUBE_NS_ARG -f $YAML

rm -f $YAML $TMPFILE
```

