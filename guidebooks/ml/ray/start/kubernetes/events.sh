if [[ $(uname) = Linux ]]
then INT="-Winteractive"
fi

ITER=0
while true; do
    if [[ $ITER = 0 ]]
    then WATCH="--watch"
    else WATCH="--watch-only"
    fi

    kubectl get events --ignore-not-found ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $WATCH | awk $INT -v id=$JOB_ID 'index($4, id)>0 {sub(/^[0-9]+s[ ]+/, ""); print "\x1b[1;2;36m[Cluster Event] \x1b[0;2m" $0 "\x1b[0m"; fflush()}' | sed -uE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//g'
    ITER=$(($ITER + 1))
    sleep 2
done
