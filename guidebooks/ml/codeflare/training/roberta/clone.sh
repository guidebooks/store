#!/usr/bin/env bash

# clone the roberta source code repo

set -e
set -o pipefail

if [ -z "$ML_CODEFLARE_ROBERTA_WORKDIR" ]; then
    echo "Missing working directory ML_CODEFLARE_ROBERTA_WORKDIR"
    exit 1
fi
cd "$ML_CODEFLARE_ROBERTA_WORKDIR"

if [ -n "$ML_CODEFLARE_ROBERTA_GITHUB_USER" ] && [ -n "$ML_CODEFLARE_ROBERTA_GITHUB_TOKEN" ]; then
    URL="https://${ML_CODEFLARE_ROBERTA_GITHUB_USER}:${ML_CODEFLARE_ROBERTA_GITHUB_TOKEN}@${ML_CODEFLARE_ROBERTA_GITHUB}/${ML_CODEFLARE_ROBERTA_ORG}/${ML_CODEFLARE_ROBERTA_REPO}.git"
else
    URL="git@${ML_CODEFLARE_ROBERTA_GITHUB}:${ML_CODEFLARE_ROBERTA_ORG}/${ML_CODEFLARE_ROBERTA_REPO}.git"
fi

if [ -f "/tmp/github/id_rsa" ]; then
    eval "$(ssh-agent -s)"
    ssh-add /tmp/github/id_rsa
    mkdir -p ~/.ssh
    ssh-keyscan -H $ML_CODEFLARE_ROBERTA_GITHUB >> ~/.ssh/known_hosts
fi

# sparse clone
if [ -n "$ML_CODEFLARE_ROBERTA_BRANCH" ]; then BRANCHOPT="-b $ML_CODEFLARE_ROBERTA_BRANCH"; fi
echo "Cloning $URL ${BRANCHOPT}"
(git clone -q --no-checkout --filter=blob:none "$URL" ${BRANCHOPT} > /dev/null && \
    cd "$ML_CODEFLARE_ROBERTA_REPO" && \
    git sparse-checkout set --cone "${ML_CODEFLARE_ROBERTA_SUBDIR}" && git checkout ${ML_CODEFLARE_ROBERTA_BRANCH-main} > /dev/null)
