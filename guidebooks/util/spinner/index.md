# Install Guidebook Spinner Utility

A helpful utility to add spinners to command line executions.

```shell
---
validate: |
  [ -e /tmp/guidebook-spinner.sh ]
---
cat << 'EOF' > /tmp/guidebook-spinner.sh
--8<-- "./guidebook-spinner.sh"
EOF

chmod a+rx /tmp/guidebook-spinner.sh
```

