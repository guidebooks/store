echo "👉 $(tput setaf 6)Logs will be stored in this local staging directory: $(tput bold)${LOGDIR_STAGE}$(tput sgr0)"

kubectl logs -f \
    --timestamps \
    --ignore-errors \
    --pod-running-timeout=3h \
    --max-log-requests=128 \
    ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
    -l ${TORCHX_INSTANCE_LABEL} \
    | awk '{sub(/\.[[:digit:]]+/,"",$1); printf "\x1b[2m" $1 "\x1b[0m"; for (i=2; i<=NF; i++) printf " " $i; print ""}' \
    | tee "${STREAMCONSUMER_LOGS}job.txt"
