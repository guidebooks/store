cd $HELM_CLONE_TEMPDIR

git clone --filter=tree:0 --depth 1 --sparse https://github.com/guidebooks/ray.git >& /dev/null && \
    cd ray && \
    git sparse-checkout init --cone >& /dev/null && \
    git sparse-checkout set deploy/charts/ray >& /dev/null

echo "$(tput setaf 4)Creating ray cluster num_cpus=$(tput setaf 5)${NUM_CPUS-1} $(tput setaf 4)num_gpus=$(tput setaf 5)${NUM_GPUS-1} $(tput setaf 4)head_memory=$(tput setaf 5)${HEAD_MEMORY-1Gi} $(tput setaf 4)worker_memory=$(tput setaf 5)${WORKER_MEMORY-1Gi} $(tput setaf 4)minWorkers=$(tput setaf 5)${MIN_WORKERS-2} $(tput setaf 4)maxWorkers=$(tput setaf 5)${MAX_WORKERS-3} $(tput setaf 4)image=$(tput setaf 5)${RAY_IMAGE} $(tput setaf 4)operatorImage=$(tput setaf 5)${RAY_OPERATOR_IMAGE} $(tput setaf 4)context=$(tput setaf 5)${KUBE_CONTEXT} $(tput setaf 4)namespace=$(tput setaf 5)${KUBE_NS}$(tput sgr0)"

sed -i '' -e 's/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g' deploy/charts/ray/templates/*.yaml

helm --kube-context ${KUBE_CONTEXT} -n ${KUBE_NS} \
     upgrade --install --wait --timeout 30m \
     ${RAY_KUBE_CLUSTER_NAME} --create-namespace \
     deploy/charts/ray \
     --set podTypes.rayWorkerType.CPU=${NUM_CPUS-1} \
     --set podTypes.rayWorkerType.GPU=${NUM_GPUS-1} \
     --set podTypes.rayHeadType.memory=${HEAD_MEMORY-1Gi} \
     --set podTypes.rayWorkerType.memory=${WORKER_MEMORY-1Gi} \
     --set podTypes.rayWorkerType.minWorkers=${MIN_WORKERS-2} \
     --set podTypes.rayWorkerType.maxWorkers=${MAX_WORKERS-3} \
     --set image=${RAY_IMAGE} \
     --set operatorImage=${RAY_OPERATOR_IMAGE} \
     --set namespacedOperator=true \
     --set operatorNamespace=${KUBE_NS}
