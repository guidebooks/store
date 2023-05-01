echo "👉 $(tput setaf 6)Logs will be stored in this local staging directory: $(tput bold)${LOGDIR_STAGE}$(tput sgr0)"

while true; do
    kubectl logs -f \
            --prefix \
            --tail=10000 \
            --ignore-errors \
            --pod-running-timeout=3h \
            --max-log-requests=128 \
            ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} \
            -l ${TORCHX_INSTANCE_LABEL} \
        | sed -uE "s|(\[)pod/$TORCHX_INSTANCE-([0-9]+)/$TORCHX_INSTANCE-[0-9]+(\])|\x1b[33;1m\1W\2]\x1b[0m|" \
        | tee "${STREAMCONSUMER_LOGS}job.txt" && break

    sleep 1
done

# this might help with tqdm progress bars... but isn't useful with more than one worker... and versus torchx's use of torchrun --tee 3, hence commented out for now; if we ever do use this, then remove the `-f` part of `logs -f` above
#kubectl get pod -l ${TORCHX_INSTANCE_LABEL} ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -o name \
#        --field-selector=status.phase==Running \
#    | xargs ${REPLSIZE} -o -P128 -I {} -n1 \
#            kubectl attach -it -q ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} {} \
#    | tee -a "${STREAMCONSUMER_LOGS}job.txt"

# used to be after first sed
# | sed -uE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//' \
