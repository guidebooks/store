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

# sparse clone
if [ -n "$ML_CODEFLARE_ROBERTA_BRANCH" ]; then BRANCHOPT="-b $ML_CODEFLARE_ROBERTA_BRANCH"; fi
echo "Cloning $URL ${BRANCHOPT}"
(git clone -q --filter=tree:0 --depth 1 --sparse "$URL" ${BRANCHOPT} > /dev/null && \
    cd "$ML_CODEFLARE_ROBERTA_REPO" && \
    git sparse-checkout init --cone > /dev/null && \
    git sparse-checkout set "${ML_CODEFLARE_ROBERTA_SUBDIR}" > /dev/null)
