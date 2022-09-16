CHART_DIR=guidebooks/ml/mlflow/start/kubernetes/chart

MLFLOW_CLONE_TEMPDIR=$(mktemp -d)
cd $MLFLOW_CLONE_TEMPDIR

git clone -q --no-checkout --filter=blob:none https://github.com/guidebooks/store.git && \
    cd store && \
    git sparse-checkout set --cone $CHART_DIR && git checkout main

helm --kube-context ${KUBE_CONTEXT} -n ${KUBE_NS} \
     upgrade --install --wait --timeout 30m \
     mlflow $CHART_DIR \
     --set s3.endpoint=${S3_ENDPOINT} \
     --set s3.bucket=${S3_BUCKETMLFLOW} \
     --set s3.AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
     --set s3.AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
