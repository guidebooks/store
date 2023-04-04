echo "👉 $(tput setaf 6)Logs will be stored in this local staging directory: $(tput bold)${LOGDIR_STAGE}$(tput sgr0)"

kubectl logs -f \
        --prefix \
        --timestamps \
        --ignore-errors \
        --pod-running-timeout=3h \
        --max-log-requests=128 \
        ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
        -l ${TORCHX_INSTANCE_LABEL} \
    | sed -uE "s|pod/$TORCHX_INSTANCE-([0-9]+)/$TORCHX_INSTANCE-[0-9]+|W\1|" \
    | sed -uE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//' \
    | awk '{sub(/^[[:digit:]]{4}-/,"",$2); sub(/T/," ",$2); sub(/\.[[:digit:]]+/,"",$2); printf "\x1b[33;1m%s \x1b[0;2m%s\x1b[0m", $1, $2; for (i=3; i<=NF; i++) printf " %s", $i; print ""; fflush()}' \
    | tee "${STREAMCONSUMER_LOGS}job.txt"
