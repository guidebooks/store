if [[ $(uname) = Linux ]]
then INT="-Winteractive"
fi

# Use the user's timezone, to help with readability
export TZ=$(date +%Z)

ITER=0
while true; do
    if [[ $ITER = 0 ]]
    then WATCH="--watch"
    else WATCH="--watch-only"
    fi

    kubectl get pods -l ${KUBE_PODFULL_LABEL_SELECTOR} \
            --no-headers --ignore-not-found \
            ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $WATCH \
        | while read line ; do echo -e "$line \x1b[0;35m$(date -u +'%Y-%m-%dT%H:%M:%SZ')" ; done \
        | awk $INT '{
printf "\x1b[1;2;35m[Workers \x1b[0;35m%s\x1b[1;2;35m]\x1b[0;2;35m pod/%s %s %s %s\x1b[0m\n", $3, $1, $2, $4, $6, $5;
fflush();
}' \
        | tee -a "${STREAMCONSUMER_EVENTS}pods.txt" \
        | sed -uE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//g'

    ITER=$(($ITER + 1))
    sleep 2
done
