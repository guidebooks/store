(kubectl exec ${RAY_HEAD_POD} -- \
        sh -c "tail -F /tmp/ray/session_latest/logs/runtime_env_agent.log 2> /dev/null | grep -v 'raylet\|Unused\|deleted'" \
    | sed -E 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}//' \
    | while read line ; do echo -e "\x1b[1;2;36m[Pips \x1b[0;36mInstalling\x1b[1;2;36m]\x1b[0;2;36m pod/${RAY_HEAD_POD} \$line \x1b[0;36m(date -u +%Y-%m-%dT%H:%M:%SZ)\x1b[0m" ; done) &

kubectl exec ${RAY_HEAD_POD} -- \
        sh -c 'tail -F /tmp/ray/session_latest/logs/runtime_env_setup-01000000.log 2> /dev/null' \
    | sed -E 's/[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}//' \
    | while read line ; do echo -e "\x1b[1;2;36m[Pips \x1b[0;36mInstalling\x1b[1;2;36m]\x1b[0;2;36m pod/${RAY_HEAD_POD} \$line \x1b[0;36m\$(date -u +%Y-%m-%dT%H:%M:%SZ)\x1b[0m" ; done

