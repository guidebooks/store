set -e
set -o pipefail

# A staging directory for the clone of the Ray Helm chart.
WORKDIR=$(mktemp -d) && cd $WORKDIR

# base ray chart
GITHUB=github.com
ORG=starpit # ray-project
REPO=ray
BRANCH=operator-cpu # ""
SUBDIR=deploy/charts/ray

if [ "$KUBE_POD_MANAGER" = mcad ] || [ "$KUBE_POD_MANAGER" = kubernetes ]; then
    # MCAD-enabled helm chart; this chart also allows mcad-free operation, hence the ||
    GITHUB=github.com
    ORG=${RAY_CHART_ORG-guidebooks}
    REPO=${RAY_CHART_REPO-store}
    BRANCH=${RAY_CHART_BRANCH-5.4.2} # <-- will get updated by @release-it/bumper; see top-level package.json
    SUBDIR=${RAY_CHART_SUBDIR-guidebooks/ml/ray/start/kubernetes/chart}

    if [ "$KUBE_POD_MANAGER" = mcad ]
    then MCAD_ENABLED=true
    fi
fi

if [ "$KUBE_POD_MANAGER" = ray ]; then
    OPERATOR_IMAGE="--set operatorImage=${RAY_OPERATOR_IMAGE}"
fi

if [ -n "$KUBE_POD_MANAGER_NON_ROOT" ]; then
    # user does not have root access to their kubernetes cluster
    CLUSTER_ONLY=true
    SKIP_CRDS="--skip-crds"
else
    CLUSTER_ONLY=false
    CREATE_NAMESPACE="--create-namespace"
fi

# sparse clone
if [ -n "$BRANCH" ]; then BRANCHOPT="-b $BRANCH"; fi
echo "$(tput setaf 4)[Helm] $(tput setaf 5)Cloning https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT}$(tput sgr0)"
(git clone -q --no-checkout --filter=blob:none https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT} > /dev/null && \
    cd $REPO && \
    git sparse-checkout set --cone $SUBDIR && git checkout ${BRANCH-main})

if [ "$KUBE_POD_MANAGER" = ray ]; then
    sed -i '' -e 's/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g' $REPO/$SUBDIR/templates/*.yaml
fi

echo "$(tput setaf 4)[Helm] Creating ray cluster num_cpus=$(tput setaf 5)${NUM_CPUS-1} $(tput setaf 4)num_gpus=$(tput setaf 5)${NUM_GPUS-1} $(tput setaf 4)head_memory=$(tput setaf 5)${HEAD_MEMORY-1Gi} $(tput setaf 4)worker_memory=$(tput setaf 5)${WORKER_MEMORY-1Gi} $(tput setaf 4)minWorkers=$(tput setaf 5)${MIN_WORKERS-2} $(tput setaf 4)maxWorkers=$(tput setaf 5)${MAX_WORKERS-3} $(tput setaf 4)image=$(tput setaf 5)${RAY_IMAGE} $(tput setaf 4)operatorImage=$(tput setaf 5)${RAY_OPERATOR_IMAGE} $(tput setaf 4)context="$(tput setaf 5)${KUBE_CONTEXT_ARG_HELM}" $(tput setaf 4)namespace="$(tput setaf 5)${KUBE_NS_ARG}$(tput sgr0)" $(tput setaf 4)clusterOnly=$(tput setaf 5)${CLUSTER_ONLY}$(tput sgr0)"

# sigh, ray's --num-cpus flag does not understand millicores, such as 250m, nor fractional cores at all
# this maps 250m => 1 and 2500m => 3 and 4 => 4
NUM_CPUS_INTEGER=$(echo ${NUM_CPUS-250m} | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} /[^m]$/ { print $1 } /m$/ { sub("m",""); print ceil($1/1000) }')

if [ -n "$RAY_STARTUP_PROBE_INITIAL_DELAY_SECONDS" ]; then
    STARTUP_PROBE="--set startupProbe.initialDelaySeconds=${RAY_STARTUP_PROBE_INITIAL_DELAY_SECONDS}"
fi

if [ -n "$ML_RAY_STORAGE_S3_KUBERNETES_SECRET" ]; then
    storageSecret="--set storage.secret=$ML_RAY_STORAGE_S3_KUBERNETES_SECRET"
fi

if [ -n "$IMAGE_PULL_SECRET" ]; then
    imagePullSecret="--set imagePullSecret=${IMAGE_PULL_SECRET}"
fi

if [ -n "$IMAGE_PULL_POLICY" ]; then
    imagePullPolicy="--set imagePullPolicy=${IMAGE_PULL_POLICY}"
fi

OUTPUT=/tmp/helm.yml
if [ -n "$HELM_DRYRUN" ]; then
    INSTALL="install --dry-run"
    echo "$(tput setaf 4)[Helm] $(tput setaf 5)Performing dry run$(tput sgr0)"
else
    INSTALL="upgrade --install"
fi

if [ -n "$KUBE_POD_SCHEDULING_PRIO" ]; then
    echo "$(tput setaf 4)[Helm] Using job priority=$(tput setaf 5)$KUBE_POD_SCHEDULING_PRIO$(tput sgr0)"
    jobPriority="--set priority=${KUBE_POD_SCHEDULING_PRIO}"
fi

if [ -n "$CUSTOM_WORKING_DIR" ]; then
    if [ -d "$CUSTOM_WORKING_DIR" ]; then
        workdirEnc=$(tar -jcf - --no-xattrs --exclude '*~' --exclude '*.out' --exclude '*.log' --exclude '*.err' -C "$CUSTOM_WORKING_DIR" . | base64)
        workdir="--set workdir=${workdirEnc}"
        echo "$(tput setaf 4)[Helm] Using workdir via configmap=$(tput setaf 5)${#workdir} bytes$(tput sgr0)"
    elif [ ! -e "$CUSTOM_WORKING_DIR" ]; then
        echo "$(tput setaf 1)[Helm] Error: custom working directory specified, but path to directory not found $CUSTOM_WORKING_DIR$(tput sgr0)"
        exit 1
    else
        echo "$(tput setaf 1)[Helm] Error: custom working directory specified, but path does not point to a directory $CUSTOM_WORKING_DIR$(tput sgr0)"
        exit 1
    fi
fi

if [ -n "$GUIDEBOOK_DASHDASH" ]; then
    dashdashEnc=$(echo "$GUIDEBOOK_DASHDASH" | base64)
    dashdash="--set dashdash=${dashdashEnc}"
    echo "$(tput setaf 4)[Helm] Using dashdash=$(tput setaf 5)${GUIDEBOOK_DASHDASH}$(tput sgr0)"
fi

if [ -n "$GUIDEBOOK_ENV" ]; then
    jobEnv="--set jobEnv=$GUIDEBOOK_ENV"
    echo -n "$(tput setaf 4)[Helm] Passing through job env=$(tput setaf 5)"
    echo -n $(echo "$GUIDEBOOK_ENV" | base64 -d)
    echo "$(tput sgr0)"
fi

if [ -n "$JOB_ID" ]; then
    jobId="--set jobId=${JOB_ID}"
fi

if [ -z "$RAY_KUBE_CLUSTER_NAME" ]; then
    echo "$(tput setaf 1)[Helm] Error: ray cluster name not defined$(tput sgr0)"
    exit 1
else
    echo "$(tput setaf 4)[Helm] Using ray cluster name=$(tput setaf 5)${RAY_KUBE_CLUSTER_NAME}$(tput sgr0)"
fi

cd $REPO/$SUBDIR && \
    helm ${HELM_DEBUG} ${INSTALL} --wait --timeout 30m ${RAY_KUBE_CLUSTER_NAME} . \
         ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} \
         ${CREATE_NAMESPACE} ${STARTUP_PROBE} ${OPERATOR_IMAGE} \
         ${HELM_EXTRA} \
         --set clusterName=${RAY_KUBE_CLUSTER_NAME} \
         --set clusterNamespace=${KUBE_NS_FOR_REAL-${KUBE_NS}} \
         --set podTypes.rayHeadType.CPU=${NUM_CPUS-1} \
         --set podTypes.rayHeadType.CPUInteger=${NUM_CPUS_INTEGER-1} \
         --set podTypes.rayHeadType.memory=${HEAD_MEMORY-1Gi} \
         --set podTypes.rayHeadType.storage=${RAY_EPHEMERAL_STORAGE-5Gi} \
         --set podTypes.rayWorkerType.CPU=${NUM_CPUS-1} \
         --set podTypes.rayWorkerType.CPUInteger=${NUM_CPUS_INTEGER-1} \
         --set podTypes.rayWorkerType.GPU=${NUM_GPUS-0} \
         --set podTypes.rayWorkerType.memory=${WORKER_MEMORY-1Gi} \
         --set podTypes.rayWorkerType.storage=${RAY_EPHEMERAL_STORAGE-5Gi} \
         --set podTypes.rayWorkerType.minWorkers=${MIN_WORKERS-1} \
         --set podTypes.rayWorkerType.maxWorkers=${MAX_WORKERS-1} \
         ${jobId} \
         ${jobEnv} \
         ${dashdash} \
         ${workdir} \
         --set operatorResources.cpu=${NUM_CPUS-1} \
         --set mcad.enabled=${MCAD_ENABLED-false} \
         --set mcad.scheduler=${KUBE_POD_SCHEDULER-default} \
         ${jobPriority} \
         --set storage.path=${RAY_STORAGE_PATH-/dev/shm} \
         ${storageSecret} \
         --set namespacedOperator=true \
         --set operatorNamespace=${KUBE_NS} \
         --set rbac.enabled=${KUBERNETES_RBAC_ENABLED-false} \
         ${startupProbe} \
         --set clusterOnly=${CLUSTER_ONLY-false} ${SKIP_CRDS} \
         --set image=${RAY_IMAGE} \
         ${imagePullSecret} \
         ${imagePullPolicy} | tee ${OUTPUT}

if [ -n "$HELM_DRYRUN" ]; then
    # early exit
    echo "[Helm] yaml spec should be in ${OUTPUT}"
    exit 90
fi
