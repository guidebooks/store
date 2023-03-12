set -e
set -o pipefail

scheduler=kubernetes_mcad
component=dist.ddp

# sigh, torchx's --num-cpus flag does not understand millicores, such as 250m, nor fractional cores at all
# this maps 250m => 1 and 2500m => 3 and 4 => 4
NUM_CPUS_INTEGER=$(echo ${NUM_CPUS-250m} | awk 'function ceil(x, y){y=int(x); return(x>y?y+1:y)} /[^m]$/ { print $1 } /m$/ { sub("m",""); print ceil($1/1000) }')

# sigh, torchx does not handle Mi units
NUMERIC_PART=$(echo $WORKER_MEMORY | sed -E 's/[MGTP]i?//')
SCALE_PART=$(echo $WORKER_MEMORY | sed 's/Mi/1/' | sed -E 's/^.+Gi$/1024/' | sed -E 's/^.+Ti$/1024 * 1024/' | sed -E 's/^.+Pi$/1024 * 1024 * 1024/')
WORKER_MEMORY_MB=$(($NUMERIC_PART * $SCALE_PART))

ns="namespace=${KUBE_NS}"
imagePullSecret="image_secret=all-icr-io"
image="--image ${RAY_IMAGE}"
volumes="--mounts type=volume,src=$S3_S3FS_CLAIM,dst=$S3_DATAPATH"
script="$(echo $CUSTOM_COMMAND_LINE_PREFIX | sed -E 's/^python[[:digit:]]+[ ]+//')"

if [ "$KUBE_POD_SCHEDULER" = "coscheduler" ]; then
    coscheduler=",coscheduler_name=scheduler-plugins-scheduler"
fi

if [ -n "$RAY_IMAGE" ]; then
    repo="image_repo=$(dirname $RAY_IMAGE)"
fi

cd $CUSTOM_WORKING_DIR && \
    torchx run --workspace="" \
           --dryrun \
           --scheduler $scheduler \
           --scheduler_args $ns,$repo,$imagePullSecret$coscheduler \
           $component \
           -j ${MAX_WORKERS}x1 --gpu ${NUM_GPUS} --cpu ${NUM_CPUS_INTEGER} --memMB ${WORKER_MEMORY_MB} \
           $volumes \
           $image \
           --script=$script \
        2>&1 \
        | awk '$0=="=== SCHEDULER REQUEST ===" {on=1} on==2 { print $0 } on==1{on=2}' \
        | sed "s/main-pg/pg/" \
        | sed -E "s/main-[a-zA-Z0-9]+/$TORCHX_INSTANCE/g" \
        | sed -E 's#(python -m torch.distributed.run)#if [ -f /tmp/configmap/workdir/workdir.tar.bz2 ]; then export PYTHONPATH="${PYTHONPATH}:/tmp/workdir"; echo "Unpacking workspace with PYTHONPATH=$PYTHONPATH"; mkdir /tmp/workdir; tar -C /tmp/workdir -jxvf /tmp/configmap/workdir/workdir.tar.bz2; fi; cd /tmp/workdir; \1#' \
        | awk '{ idx=index($0, "volumeMounts:"); print $0; if (idx > 0) { for (i=1; i<idx; i++) printf " "; print "- name: workdir-volume"; for (i=1; i<idx+2; i++) printf " "; print "mountPath: /tmp/configmap/workdir"; for (i=1; i<idx+2; i++) printf " "; print "readOnly: true"} }' \
        | awk -v clusterName=$TORCHX_INSTANCE '{ idx=index($0, "volumes:"); print $0; if (idx > 0) { for (i=1; i<idx; i++) printf " "; print "- name: workdir-volume"; for (i=1; i<idx+2; i++) printf " "; print "configMap:"; for (i=1; i<idx+4; i++) printf " "; print "name: workdir-" clusterName} }' \
        > $HELM_ROLL_YOUR_OWN
set +x

echo "Torchx resources have been staged in $HELM_ROLL_YOUR_OWN"
