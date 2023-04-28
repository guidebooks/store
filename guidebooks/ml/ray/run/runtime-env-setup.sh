if [ -z "$STREAMCONSUMER_EVENTS" ]; then STREAMCONSUMER_EVENTS="/tmp/"; fi

set +e
set +o pipefail

kubectl exec ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} ${RAY_HEAD_POD} -c ray-head -- \
        sh -c "tail -F /tmp/ray/session_latest/logs/runtime_env_setup-01000000.log 2> /dev/null " \
    | sed -uE 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}//' \
    | while read line ; do echo -e "$line \x1b[0;36m$(date -u +'%Y-%m-%dT%H:%M:%SZ')" ; done \
    | sed -uE "s/^(.+)$/\x1b[1;2;36m[Pips \x1b[0;36mInstalling\x1b[1;2;36m]\x1b[0;2;36m pod\/${RAY_HEAD_POD} \1\x1b[0m/" \
    | tee -a "${STREAMCONSUMER_EVENTS}runtime-env-setup.txt"
