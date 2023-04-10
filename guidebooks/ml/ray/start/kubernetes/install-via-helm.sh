# Prepare and submit cluster to Kubernetes

set -e
set -o pipefail

# remember the CWD, because we do a cd just below
CURDIR=$(pwd)

if [ -z "$TERM" ]; then export TERM=xterm-256color; fi

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
    BRANCH=${RAY_CHART_BRANCH-7.5.18} # <-- will get updated by @release-it/bumper; see top-level package.json
    SUBDIR=${RAY_CHART_SUBDIR-guidebooks/ml/ray/start/kubernetes/chart}

    if [ "$KUBE_POD_MANAGER" = mcad ]
    then MCAD_ENABLED=true
    fi
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
echo "$(tput setaf 3)[Setup]$(tput sgr0) Fetching templates https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT}$(tput sgr0)"
LOG=$(mktemp)
set +e
(git clone --quiet --no-checkout --filter=blob:none https://${GITHUB}/${ORG}/${REPO}.git ${BRANCHOPT} 2>> $LOG > /dev/null && \
    cd $REPO && \
    git sparse-checkout set --cone $SUBDIR  2>> $LOG > /dev/null && git checkout -q ${BRANCH-main}  2>> $LOG > /dev/null)
if [ $? != 0 ]; then cat $LOG; exit $?; fi
set -e

if [ "$KUBE_POD_MANAGER" = ray ]; then
    sed -i '' -e 's/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g' $REPO/$SUBDIR/templates/*.yaml
fi

echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)num_cpus$(tput sgr0) $(tput setaf 6)${NUM_CPUS-1}$(tput sgr0)"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)num_gpus$(tput sgr0) $(tput setaf 6)${NUM_GPUS-1}$(tput sgr0)"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)head_memory$(tput sgr0) $(tput setaf 6)${HEAD_MEMORY-1Gi}$(tput sgr0)"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)worker_memory$(tput sgr0) $(tput setaf 6)${WORKER_MEMORY-1Gi}$(tput sgr0)"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)numWorkers$(tput sgr0) $(tput setaf 6)${MAX_WORKERS}$(tput sgr0)"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)image$(tput sgr0) $(tput setaf 6)${RAY_IMAGE}$(tput sgr0)"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)context$(tput sgr0) $(tput setaf 6)${KUBE_CONTEXT}$(tput sgr0)"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)namespace$(tput sgr0) $(tput setaf 6)${KUBE_NS}$(tput sgr0)"

# sigh, ray's --num-cpus flag does not understand millicores, such as 250m, nor fractional cores at all
# this maps 250m => 1 and 2500m => 3 and 4 => 4
NUM_CPUS_INTEGER=$(echo ${NUM_CPUS-250m} | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} /[^m]$/ { print $1 } /m$/ { sub("m",""); print ceil($1/1000) }')

if [ -n "$RAY_STARTUP_PROBE_INITIAL_DELAY_SECONDS" ]; then
    STARTUP_PROBE="--set startupProbe.initialDelaySeconds=${RAY_STARTUP_PROBE_INITIAL_DELAY_SECONDS}"
    echo "$(tput setaf 3)[Config]$(tput sgr0) startupProbe=$(tput setaf 6)$STARTUP_PROBE$(tput sgr0)"
fi

if [ -n "$ML_RAY_STORAGE_S3_KUBERNETES_SECRET" ]; then
    storageSecret="--set storage.secret=$ML_RAY_STORAGE_S3_KUBERNETES_SECRET"
    echo "$(tput setaf 3)[Config]$(tput sgr0) storageSecret=$(tput setaf 6)$ML_RAY_STORAGE_S3_KUBERNETES_SECRET$(tput sgr0)"
fi

if [ -n "$IMAGE_PULL_SECRET" ]; then
    imagePullSecret="--set imagePullSecret=${IMAGE_PULL_SECRET}"
    echo "$(tput setaf 3)[Config]$(tput sgr0) imagePullSecret=$(tput setaf 6)$IMAGE_PULL_SECRET$(tput sgr0)"
fi

if [ -n "$IMAGE_PULL_POLICY" ]; then
    imagePullPolicy="--set imagePullPolicy=${IMAGE_PULL_POLICY}"
    echo "$(tput setaf 3)[Config]$(tput sgr0) imagePullPolicy=$(tput setaf 6)$IMAGE_PULL_POLICY$(tput sgr0)"
fi

if [ -n "$KUBE_POD_SCHEDULING_PRIO" ]; then
    jobPriority="--set priority=${KUBE_POD_SCHEDULING_PRIO}"
    echo "$(tput setaf 3)[Config]$(tput sgr0) job priority=$(tput setaf 6)$KUBE_POD_SCHEDULING_PRIO$(tput sgr0)"
fi

#
# Notes on use of tr -d below: some base64 (e.g. those with gnu utils)
# wrap at 76 columns by default; other systems (e.g. macOS or those
# with BSD-based base64) do not, and also do not provide the `--wrap
# 0` option that gnu's base64 does. sigh. so we instead use `tr -d
# '\n'` to eliminate any newlines in the base64-encoded string
#

# Here we bundle the working directory up into a base64-encoded
# string, so that we can stash it into a configmap (see workdir.yaml)

if [ -n "$CUSTOM_WORKING_DIR" ]; then
    if [ ! -e "$CUSTOM_WORKING_DIR" ] && [ -e "$CURDIR/$CUSTOM_WORKING_DIR" ]; then
        # the specified path may be relative to the current working directory
        CUSTOM_WORKING_DIR="$CURDIR/$CUSTOM_WORKING_DIR"
    fi

    if [ -d "$CUSTOM_WORKING_DIR" ]; then
        # Allow the working directory to specify an exclusion list via
        # a .rayignore at the top level. This file is a
        # newline-separated list of exclusion globs. See the tar
        # manual for more detail on exclusion patterns.
        excludeFile=$(mktemp)
        if [ -f "$CUSTOM_WORKING_DIR"/.rayignore ]; then
            cp "$CUSTOM_WORKING_DIR"/.rayignore $excludeFile
        fi

        workdirTarball=$(mktemp)
        tar -zcf $workdirTarball --no-xattrs \
            --exclude '*~' --exclude '*.out' --exclude '*.log' --exclude '*.err' --exclude '.rayignore' \
            --exclude-vcs \
            --exclude-from $excludeFile \
            -C "$CUSTOM_WORKING_DIR" .\

        workdir="--set-file workdir=${workdirTarball}"
        echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)sizeof.workDir$(tput sgr0) $(tput setaf 6)$(cat $workdirTarball | wc -c | awk '{print $1}') bytes$(tput sgr0)"
    elif [ ! -e "$CUSTOM_WORKING_DIR" ]; then
        echo "$(tput setaf 1)[Setup]$(tput sgr0) Error: custom working directory specified, but path to directory not found $CUSTOM_WORKING_DIR in cwd=$CURDIR$(tput sgr0)"
        exit 1
    else
        echo "$(tput setaf 1)[Setup]$(tput sgr0) Error: custom working directory specified, but path does not point to a directory $CUSTOM_WORKING_DIR$(tput sgr0)"
        exit 1
    fi
fi

if [ -n "$CUSTOM_COMMAND_LINE_PREFIX" ]; then
    commandLinePrefixEnc=$(mktemp)
    echo -n "$CUSTOM_COMMAND_LINE_PREFIX" | tr -d '\n' > $commandLinePrefixEnc
    commandLinePrefix="--set-file commandLinePrefix=$commandLinePrefixEnc"
    echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)commandLinePrefix$(tput sgr0) $(tput setaf 6)${CUSTOM_COMMAND_LINE_PREFIX}$(tput sgr0)"
fi

if [ -n "$GUIDEBOOK_DASHDASH" ]; then
    dashdashEnc=$(mktemp)
    echo -n "$GUIDEBOOK_DASHDASH" | base64 | tr -d '\n' > $dashdashEnc # see above for discussion of tr
    dashdash="--set-file dashdash=${dashdashEnc}"
    echo "$(tput setaf 3)[Config]$(tput sgr0) dashdash=$(tput setaf 6)${GUIDEBOOK_DASHDASH}$(tput sgr0)"
fi

if [ -n "$JOB_ID" ]; then
    jobId="--set jobId=${JOB_ID}"
    echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)jobId$(tput sgr0) $(tput setaf 6)${JOB_ID}$(tput sgr0)"
fi

if [ -z "$RAY_KUBE_CLUSTER_NAME" ]; then
    echo "$(tput setaf 1)[Setup]$(tput sgr0) Error: ray cluster name not defined$(tput sgr0)"
    exit 1
else
    echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)clusterName$(tput sgr0) $(tput setaf 6)${RAY_KUBE_CLUSTER_NAME}$(tput sgr0)"
fi

if [ -n "$GUIDEBOOK_ENV" ]; then
    jobEnvFile=$(mktemp)
    echo "$GUIDEBOOK_ENV" > $jobEnvFile
    jobEnv="--set-file jobEnv=$jobEnvFile"

    if [[ -n "$GUIDEBOOK_VERBOSE" ]]; then
        echo -ne "$(tput setaf 3)[Config]$(tput sgr0) Passing through job env="
        echo -n $(cat "$jobEnvFile" | base64 -d) # see above for discussion of tr
        echo "$(tput sgr0)"
    fi
fi

if [ -f "$HELM_ROLL_YOUR_OWN" ]; then
    rollYourOwn="--set-file rollYourOwn=$HELM_ROLL_YOUR_OWN"

    if [[ -n "$GUIDEBOOK_VERBOSE" ]]; then
        echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)customResources $(tput setaf 6)$HELM_ROLL_YOUR_OWN$(tput sgr0)"
    fi
elif [ -n "$HELM_ROLL_YOUR_OWN" ]; then
    echo "$(tput setaf 1)[Setup]$(tput sgr0) Error: roll your own invalid, expected a filepath: $HELM_ROLL_YOUR_OWN$(tput sgr0)"
    exit 1
fi

if [ -n "$HELM_DRYRUN" ]; then
    TEE="cat" # we don't want to tee the dryrun output to the console
    INSTALL="install --dry-run ${HELM_DEBUG}"
    echo "$(tput setaf 3)[Setup]$(tput sgr0) $(tput setaf 6)Performing dry run$(tput sgr0)"

    set -x # echo the helm command line
else
    TEE="tee" # stream the output of helm install to the console
    INSTALL="upgrade --install"
fi

cd $REPO/$SUBDIR && \
    helm ${INSTALL} --wait --timeout 30m ${RAY_KUBE_CLUSTER_NAME} . \
         ${KUBE_CONTEXT_ARG_HELM} ${KUBE_NS_ARG} \
         ${CREATE_NAMESPACE} ${STARTUP_PROBE} \
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
         ${rollYourOwn} \
         ${jobId} \
         ${jobEnv} \
         ${commandLinePrefix} \
         ${dashdash} \
         ${workdir} \
         --set mcad.enabled=${MCAD_ENABLED-false} \
         --set mcad.scheduler=${KUBE_POD_SCHEDULER-default} \
         ${jobPriority} \
         --set storage.path=${RAY_STORAGE_PATH-/dev/shm} \
         ${storageSecret} \
         --set rbac.enabled=${KUBERNETES_RBAC_ENABLED-false} \
         ${startupProbe} \
         --set image=${RAY_IMAGE} \
         ${imagePullSecret} \
         ${imagePullPolicy} \
         | ${TEE} > ${HELM_OUTPUT-/tmp/helm.yml}
set +x

if [ -n "$HELM_DRYRUN" ]; then
    # early exit
    echo "$(tput setaf 3)[Setup]$(tput sgr0) yaml spec should be in ${HELM_OUTPUT-/tmp/helm.yml}$(tput sgr0)"
    exit 90
fi
