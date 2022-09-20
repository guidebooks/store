#
# Helm deployment of Ray server with JupyterLab
#

GITHUB=github.com
ORG=${JUPYTERLAB_CHART_ORG-guidebooks}
REPO=${JUPYTERLAB_CHART_REPO-store}
BRANCH=${JUPYTERLAB_CHART_BRANCH}
SUBDIR=${JUPYTERLAB_CHART_SUBDIR-guidebooks/ml/jupyterlab/start/kubernetes/chart}

JUPYTERLAB_CLONE_TEMPDIR=$(mktemp -d)

if [ -n "$BRANCH" ]; then
    BRANCH_OPT="-b ${BRANCH}"
fi

git clone --filter=tree:0 --depth 1 --sparse https://${GITHUB}/${ORG}/${REPO}.git ${BRANCH_OPT} ${JUPYTERLAB_CLONE_TEMPDIR} && \
    cd ${JUPYTERLAB_CLONE_TEMPDIR} && \
    git sparse-checkout init --cone && \
    git sparse-checkout set ${SUBDIR}

helm --kube-context ${KUBE_CONTEXT} --namespace ${KUBE_NS} \
     upgrade --install --wait \
     jupyterlab ${JUPYTERLAB_CLONE_TEMPDIR}/${SUBDIR}
