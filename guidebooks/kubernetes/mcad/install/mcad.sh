WORKDIR=$(mktemp -d) && cd $WORKDIR

GITHUB=github.com
ORG=project-codeflare
REPO=multi-cluster-app-dispatcher
BRANCH=v1.34.1
LOCAL=multi-cluster-app-dispatcher
SUBDIR=deployment/mcad-controller

echo "Installing Advanced Pod Manager"

# sparse clone
if [ -n "$BRANCH" ]; then BRANCHOPT="-b $BRANCH $LOCAL"; fi
(git clone -q --no-checkout --filter=blob:none https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT} && \
    cd $REPO && \
    git sparse-checkout set --cone $SUBDIR && git checkout ${BRANCH-master})

if [ -n "$CI" ]; then
    # If we are running in a CI setting, we need to dial down the
    # resource consumption. For example, GitHub Actions have only 2
    # cpus to allocate to everything, and Kubernetes itself takes up a
    # fair chunk of that (as much as 750m?)
    RESOURCES="--set resources.limits.cpu=200m --set resources.requests.cpu=200m --set resources.limits.memory=750Mi --set resources.requests.memory=750Mi"
fi

IMAGE=quay.io/project-codeflare/mcad-controller
cd $REPO/$SUBDIR &&
    helm upgrade --install --wait mcad . \
         ${KUBE_CONTEXT_ARG_HELM} ${RESOURCES} \
         --namespace kube-system \
         --set loglevel=4 \
         --set image.repository=$IMAGE \
         --set image.tag=release-v1.34.1 \
         --set image.pullPolicy=IfNotPresent \
         --set configMap.name=mcad-controller-configmap \
         --set configMap.quotaEnabled='"false"' \
         --set configMap.preemptionEnabled='"true"' \
         --set coscheduler.rbac.apiGroup="scheduling.sigs.k8s.io" \
         --set coscheduler.rbac.resource="podgroups"
