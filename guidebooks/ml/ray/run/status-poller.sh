if [ -z "$STREAMCONSUMER_EVENTS" ]; then STREAMCONSUMER_EVENTS="/tmp/"; fi

kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${RAY_HEAD_POD} -- \
        bash -c 'export TERM=xterm-256color; while true; do statusResp="$(ray job status $JOB_ID 2> /dev/null)"; if [[ $? != 0 ]]; then status="Pending"; msg="Waiting for Ray to start up"; else status=$(echo "$statusResp" | grep "Status for job" | awk "{s=\$NF; print toupper(substr(s, 1, 1)) tolower(substr( s, 2 ))}"); msg="$(echo "$statusResp" | grep "Status message" | sed -uE "s/^.+ -- Status message: (.+)\$/\1/")"; echo "$(tput bold)$(tput dim)$(tput setaf 2)[Job $(tput sgr0)$(tput setaf 2)${status}$(tput bold)$(tput dim)$(tput setaf 2)] $(tput sgr0)$(tput dim)$(tput setaf 2)* ${msg}$(tput sgr0)"; fi; sleep 5; done;' \
    | while read line ; do echo -e "$line $(tput sgr0)$(tput dim)$(tput setaf 2)$(date -u +'%Y-%m-%dT%H:%M:%SZ')$(tput sgr0)" ; done \
    | tee -a "${STREAMCONSUMER_EVENTS}job-status.txt"
