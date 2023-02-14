## Create a Staging Directory

```shell
export CUSTOM_WORKING_DIR=$(mktemp -d)
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
