echo "👉 $(tput setaf 6)Logs will be stored in this local staging directory: $(tput bold)${LOGDIR_STAGE}$(tput sgr0)"

kubectl logs -f \
        --prefix \
        --timestamps \
        --ignore-errors \
        --pod-running-timeout=3h \
        --max-log-requests=128 \
        ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
        -l ${TORCHX_INSTANCE_LABEL} \
    | sed -E "s|pod/$TORCHX_INSTANCE-([0-9]+)/$TORCHX_INSTANCE-[0-9]+|Worker#\1|" \
    | awk '{sub(/\.[[:digit:]]+/,"",$2); printf "\x1b[33;1m" $1 "\x1b[2m " $2 "\x1b[0m"; for (i=3; i<=NF; i++) printf " " $i; print ""}' \
    | tee "${STREAMCONSUMER_LOGS}job.txt"
