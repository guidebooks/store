## Create a Staging Directory

Create a staging directory for the clone of the Ray Helm chart.

```shell
export CUSTOM_WORKING_DIR=$(mktemp -d)
```

```shell
export ML_CODEFLARE_ROBERTA_WORKDIR=$CUSTOM_WORKING_DIR
```

```shell
export ML_CODEFLARE_ROBERTA_GITHUB=${ML_CODEFLARE_ROBERTA_GITHUB-github.ibm.com}
```

```shell
export ML_CODEFLARE_ROBERTA_ORG=${ML_CODEFLARE_ROBERTA_ORG-ai-foundation}
```

```shell
export ML_CODEFLARE_ROBERTA_REPO=${ML_CODEFLARE_ROBERTA_REPO-foundation-model-stack}
```

```shell
export ML_CODEFLARE_ROBERTA_BRANCH=${ML_CODEFLARE_ROBERTA_BRANCH-0-0-x}
```

```shell
export ML_CODEFLARE_ROBERTA_SUBDIR=${ML_CODEFLARE_ROBERTA_SUBDIR-RoBERTa/training}
```

```shell
export APP_NAME=roberta
```

## Set up the PIP requirements

```shell
cat << EOF > $CUSTOM_WORKING_DIR/requirements.txt
--8<-- "./requirements.txt"
EOF
```

## Set up the Source Code

Clone the code.

```shell
--8<-- "./clone.sh"
```

Inject our wrapper script

```shell
--8<-- "./wrapper.sh"
```
