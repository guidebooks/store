WORKDIR=$(mktemp -d) && cd $WORKDIR

GITHUB=github.com
#ORG=kubernetes-sigs
ORG=asm582
REPO=scheduler-plugins
BRANCH="codeflare"
SUBDIR=manifests

# TODO pin a branch based on capabilities of the kube cluster
# e.g. release-1.22
#                ^^ >= that of the target kube cluster
echo "Installing Enhanced Scheduler Support"

# sparse clone
if [ -n "$BRANCH" ]; then BRANCHOPT="-b $BRANCH"; fi
(git clone -q --no-checkout --filter=blob:none https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT} && \
    cd $REPO && \
    git sparse-checkout set --cone $SUBDIR && git checkout ${BRANCH-master})

cd $REPO/manifests/install/charts && \
    helm upgrade --install --wait scheduler-plugins as-a-second-scheduler/ \
         ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG}
