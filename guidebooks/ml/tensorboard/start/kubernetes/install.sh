BRANCH=0.14.3 # <-- will get updated by @release-it/bumper; see top-level package.json
CHART_DIR=guidebooks/ml/tensorboard/start/kubernetes/chart

TENSORBOARD_CLONE_TEMPDIR=$(mktemp -d)
cd $TENSORBOARD_CLONE_TEMPDIR

git clone -q --no-checkout --filter=blob:none https://github.com/guidebooks/store.git $BRANCH && \
    cd store && \
    git sparse-checkout set --cone $CHART_DIR && git checkout $BRANCHx

helm --kube-context ${KUBE_CONTEXT} -n ${KUBE_NS} \
     upgrade --install --wait --timeout 30m \
     tensorboard $CHART_DIR \
     --set s3.endpoint=${S3_ENDPOINT} \
     --set s3.bucket=s3://${S3_BUCKETTENSORBOARD} \
     --set s3.AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
     --set s3.AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
