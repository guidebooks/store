CHART_DIR=guidebooks/ml/mlflow/start/kubernetes/chart

MLFLOW_CLONE_TEMPDIR=$(mktemp -d)
cd $MLFLOW_CLONE_TEMPDIR

git clone --filter=tree:0 --depth 1 --sparse https://github.com/guidebooks/store.git >& /dev/null && \
    cd store && \
    git sparse-checkout init --cone >& /dev/null && \
    git sparse-checkout set $CHART_DIR >& /dev/null

helm --kube-context ${KUBE_CONTEXT} -n ${KUBE_NS} \
     upgrade --install --wait --timeout 30m \
     mlflow $CHART_DIR \
     --set s3.endpoint=${S3_ENDPOINT} \
     --set s3.bucket=${S3_BUCKETMLFLOW} \
     --set s3.AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
     --set s3.AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
