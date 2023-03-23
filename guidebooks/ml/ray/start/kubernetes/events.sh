if [[ $(uname) = Linux ]]
then INT="-Winteractive"
fi

ITER=0
while true; do
    if [[ $ITER = 0 ]]
    then WATCH="--watch"
    else WATCH="--watch-only"
    fi

    kubectl get events -o custom-columns=KIND:.involvedObject.kind,NAME:.involvedObject.name,TIMESTAMP:.metadata.creationTimestamp,TYPE:.type,REASON:.reason,MESSAGE:.message --ignore-not-found ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} $WATCH \
        | awk $INT -v id=$JOB_ID '
index($2, id) > 0 {
  printf "\x1b[1;2;35m[Workers \x1b[0;35m%s\x1b[1;2;35m]\x1b[0;2;35m", $5;
  printf " \x1b[0;2;35m%s/%s %s", tolower($1), $2, $4; // name and reason
  for (i=6;i<=NF;i++) printf " %s", $i; // message
  print " \x1b[0;35m" $3 "\x1b[0m"; // timestamp
  fflush();
}' \
        | tee -a "${STREAMCONSUMER_EVENTS}kubernetes.txt" \
        | sed -uE 's/-[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}//g'

    ITER=$(($ITER + 1))
    sleep 2
done
