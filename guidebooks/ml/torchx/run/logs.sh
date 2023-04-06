echo "👉 $(tput setaf 6)Logs will be stored in this local staging directory: $(tput bold)${LOGDIR_STAGE}$(tput sgr0)"

kubectl logs -f \
        --ignore-errors \
        --pod-running-timeout=3h \
        --max-log-requests=128 \
        ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
        -l ${TORCHX_INSTANCE_LABEL} \
    | tee "${STREAMCONSUMER_LOGS}job.txt"

# used to be after first sed
# | sed -uE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//' \
