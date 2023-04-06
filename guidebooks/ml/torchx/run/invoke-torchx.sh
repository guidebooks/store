set -e
set -o pipefail

scheduler=${TORCHX_SCHEDULER-kubernetes_mcad}
component=${TORCHX_COMPONENT-dist.ddp}

# !!Workaround!! torchx's --num-cpus flag does not understand
# millicores, such as 250m. Below, look for the sed lines where we
# hack in the desired value.
NUM_CPUS_PLACEHOLDER=99999

# !!Workaround!! torchx does not handle Mi units
NUMERIC_PART=$(echo $WORKER_MEMORY | sed -E 's/[MGTP]i?//i')
SCALE_PART=$(echo $WORKER_MEMORY | sed -E 's/^.+Mi$/1/i' | sed -E 's/^.+Gi$/1024/i' | sed -E 's/^.+Ti$/1024 * 1024/i' | sed -E 's/^.+Pi$/1024 * 1024 * 1024/i')
# the /1 bit gets bc to truncate to an integer
WORKER_MEMORY_MB=$(echo "($NUMERIC_PART * $SCALE_PART)/1" | bc)

# TorchX Command Line Options
image="--image ${RAY_IMAGE}"
script="$(echo $CUSTOM_COMMAND_LINE_PREFIX | sed -E 's/^python[[:digit:]]*[ ]+//')"
echo "$(tput setaf 3)[Config]$(tput sgr0) $(tput bold)script$(tput sgr0) $(tput setaf 6)${script}$(tput sgr0)"

# kubernetes_mcad scheduler Options
ns="namespace=${KUBE_NS}"
if [ -n "$IMAGE_PULL_SECRET" ]; then
    imagePullSecret=",image_secret=$IMAGE_PULL_SECRET"
fi
if [ "$KUBE_POD_SCHEDULER" = "coscheduler" ]; then
    coscheduler=",coscheduler_name=scheduler-plugins-scheduler"
fi
if [ -n "$RAY_IMAGE" ]; then
    repo=",image_repo=$(dirname $RAY_IMAGE)"
fi

if [[ "$KUBE_POD_SCHEDULING_PRIO" = "high-priority" ]]; then
    prio=",priority=10,priority_class_name=$KUBE_POD_SCHEDULING_PRIO"
elif [[ "$KUBE_POD_SCHEDULING_PRIO" = "low-priority" ]]; then
    prio=",priority=1,priority_class_name=$KUBE_POD_SCHEDULING_PRIO"
fi

if [[ -n "$TORCHX_MOUNTS" ]]; then
    mounts="--mounts $(echo "$TORCHX_MOUNTS" | sed 's/,$//')"
fi

if [[ -n "$HELM_DRYRUN" ]]; then
    set -x
fi


# We need to set this, for `--dryrun` to work. See
# https://github.com/pytorch/torchx/issues/713
export LOGLEVEL=INFO

if [[ -n "$GUIDEBOOK_ENV_COMMAS" ]]; then
    env="--env $GUIDEBOOK_ENV_COMMAS"
fi

cd "$CUSTOM_WORKING_DIR" && \
    torchx run --workspace="" \
           --dryrun \
           --scheduler $scheduler \
           --scheduler_args $ns$repo$imagePullSecret$coscheduler$prio \
           $component \
           $env \
           --name main \
           -j ${MAX_WORKERS}x1 --gpu ${NUM_GPUS} --cpu ${NUM_CPUS_PLACEHOLDER} --memMB ${WORKER_MEMORY_MB} \
           $mounts \
           $image \
           --script=$script \
        2>&1 \
        | awk '$0=="=== SCHEDULER REQUEST ===" {on=1} on==2 { print $0 } on==1{on=2}' \
        | sed "s/: $((NUM_CPUS_PLACEHOLDER * 1000))m/: ${NUM_CPUS}/g" \
        | sed "s/: $((NUM_CPUS_PLACEHOLDER * 1000 - 100))m/: ${NUM_CPUS}/g" \
        | sed "s/: ${NUM_CPUS_PLACEHOLDER}/: ${NUM_CPUS}/g" \
        | sed "s#$script#$script -- $GUIDEBOOK_DASHDASH#" \
        | sed "s/main-pg/pg/" \
        | sed -E "s/main-[a-zA-Z0-9]+/$TORCHX_INSTANCE/g" \
        | sed -E 's#(python -m torch.distributed.run|torchrun)#if [ -f /tmp/configmap/workdir/workdir.tar.gz ]; then echo "Unpacking workspace with PYTHONPATH=$PYTHONPATH"; mkdir /tmp/workdir; tar -C /tmp/workdir -zxvf /tmp/configmap/workdir/workdir.tar.gz; fi; cd /tmp/workdir; \1#' \
        | awk '{ idx=index($0, "volumeMounts:"); print $0; if (idx > 0) { for (i=1; i<idx; i++) printf " "; print "- name: workdir-volume"; for (i=1; i<idx+2; i++) printf " "; print "mountPath: /tmp/configmap/workdir"; for (i=1; i<idx+2; i++) printf " "; print "readOnly: true"} }' \
        | awk -v clusterName=$TORCHX_INSTANCE '{ idx=index($0, "volumes:"); print $0; if (idx > 0) { for (i=1; i<idx; i++) printf " "; print "- name: workdir-volume"; for (i=1; i<idx+2; i++) printf " "; print "configMap:"; for (i=1; i<idx+4; i++) printf " "; print "name: workdir-" clusterName} }' \
        > $HELM_ROLL_YOUR_OWN

if [[ -n "$GUIDEBOOK_VERBOSE" ]]; then
    echo "Torchx resources have been staged in $HELM_ROLL_YOUR_OWN"
fi
