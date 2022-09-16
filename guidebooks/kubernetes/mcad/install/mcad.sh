WORKDIR=$(mktemp -d) && cd $WORKDIR

GITHUB=github.com
#ORG=IBM
ORG=starpit
REPO=multi-cluster-app-dispatcher
#BRANCH=quota-management
BRANCH=helm3-qm
SUBDIR=deployment/mcad-controller

echo "Installing Advanced Pod Manager"

# sparse clone
if [ -n "$BRANCH" ]; then BRANCHOPT="-b $BRANCH"; fi
(git clone -q --no-checkout --filter=blob:none https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT} && \
    cd $REPO && \
    git sparse-checkout set --cone $SUBDIR && git checkout ${BRANCH-master})

if [ -n "$CI" ]; then
    # If we are running in a CI setting, we need to dial down the
    # resource consumption. For example, GitHub Actions have only 2
    # cpus to allocate to everything, and Kubernetes itself takes up a
    # fair chunk of that (as much as 750m?)
    RESOURCES="--set resources.limits.cpu=300m --set resources.requests.cpu=300m --set resources.limits.memory=1Gi --set resources.requests.memory=1Gi"
fi

IMAGE=darroyo/mcad-controller
cd $REPO/$SUBDIR &&
    helm upgrade --install --wait mcad . \
         ${KUBE_CONTEXT_ARG_HELM} ${RESOURCES} \
         --namespace kube-system \
         --set loglevel=4 \
         --set image.repository=$IMAGE \
         --set image.tag=quota-management-v1.29.40 \
         --set image.pullPolicy=IfNotPresent \
         --set configMap.name=mcad-controller-configmap \
         --set configMap.quotaEnabled='"false"' \
         --set coscheduler.rbac.apiGroup="scheduling.sigs.k8s.io" \
         --set coscheduler.rbac.resource="podgroups"
