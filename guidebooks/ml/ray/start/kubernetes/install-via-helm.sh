# A staging directory for the clone of the Ray Helm chart.
WORKDIR=$(mktemp -d) && cd $WORKDIR

# base ray chart
GITHUB=github.com
ORG=ray-project
REPO=ray
BRANCH=""
SUBDIR=deploy/charts/ray

if [ $KUBE_POD_MANAGER = mcad ]; then
    # MCAD-enabled helm chart
    GITHUB=github.com
    #ORG=guidebooks
    ORG=starpit
    REPO=store
    BRANCH=mcad
    SUBDIR=guidebooks/ml/ray/start/kubernetes/chart
fi

# sparse clone
if [ -n "$BRANCH" ]; then BRANCHOPT="-b $BRANCH"; fi
(git clone -q --filter=tree:0 --depth 1 --sparse https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT} >& /dev/null && \
    cd $REPO && \
    git sparse-checkout init --cone >& /dev/null && \
    git sparse-checkout set $SUBDIR >& /dev/null)

if [ $KUBE_POD_SCHEDULER = ray ]; then
    sed -i '' -e 's/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g' $REPO/$SUBDIR/templates/*.yaml
fi

echo "$(tput setaf 4)Creating ray cluster num_cpus=$(tput setaf 5)${NUM_CPUS-1} $(tput setaf 4)num_gpus=$(tput setaf 5)${NUM_GPUS-1} $(tput setaf 4)head_memory=$(tput setaf 5)${HEAD_MEMORY-1Gi} $(tput setaf 4)worker_memory=$(tput setaf 5)${WORKER_MEMORY-1Gi} $(tput setaf 4)minWorkers=$(tput setaf 5)${MIN_WORKERS-2} $(tput setaf 4)maxWorkers=$(tput setaf 5)${MAX_WORKERS-3} $(tput setaf 4)image=$(tput setaf 5)${RAY_IMAGE} $(tput setaf 4)operatorImage=$(tput setaf 5)${RAY_OPERATOR_IMAGE} $(tput setaf 4)context=$(tput setaf 5)${KUBE_CONTEXT} $(tput setaf 4)namespace=$(tput setaf 5)${KUBE_NS}$(tput sgr0)"

# sigh, ray's --num-cpus flag does not understand millicores, such as 250m, nor fractional cores at all
# this maps 250m => 1 and 2500m => 3 and 4 => 4
nCPUs=$(echo ${NUM_CPUS-250m} | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} /[^m]$/ { print $1 } /m$/ { sub("m",""); print ceil($1/1000) }')

cd $REPO/$SUBDIR && \
    helm upgrade --install --wait --timeout 30m ${RAY_KUBE_CLUSTER_NAME} . \
         ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} \
         --create-namespace \
         --set clusterNamespace=${KUBE_NS} \
         --set podTypes.rayWorkerType.CPU=${nCPUs} \
         --set podTypes.rayWorkerType.GPU=${NUM_GPUS-0} \
         --set podTypes.rayHeadType.memory=${HEAD_MEMORY-1Gi} \
         --set podTypes.rayWorkerType.memory=${WORKER_MEMORY-1Gi} \
         --set podTypes.rayWorkerType.minWorkers=${MIN_WORKERS-1} \
         --set podTypes.rayWorkerType.maxWorkers=${MAX_WORKERS-1} \
         --set scheduler=${KUBE_POD_SCHEDULER-default} \
         --set image=${RAY_IMAGE}
