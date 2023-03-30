---
imports:
    - ml/ray/start/kubernetes/label-selectors
---

# Wait for at least Ray Head to be Ready

```shell
ITER=0
while true; do
    if kubectl wait pod ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} --for=condition=Ready --timeout=-1s 2> /dev/null
    then break
    fi

    if [[ $(($ITER % 10)) = 0 ]]; then echo "⌛ Waiting for Ray Head"; fi
    ITER=$(($ITER + 1))
    sleep 1
done

echo "🚀 Ray Head is ready"
```

```shell.async
if [[ -n "$DEBUG_KUBERNETES" ]]; then
    kubectl logs ${KUBE_CONTEXT_ARG} ${KUBE_NS_ARG} -l ${KUBE_POD_RAY_HEAD_LABEL_SELECTOR} \
        | while read line ; do echo -e "$(tput bold)$(tput dim)$(tput setaf 1)[Debug $(tput sgr0)$(tput setaf 1)Ray.Head$(tput bold)$(tput dim)$(tput setaf 1)] $(tput sgr0)$(tput dim)$(tput setaf 1)* $line $(tput sgr0)$(tput dim)$(tput setaf 1)$(date -u +'%Y-%m-%dT%H:%M:%SZ')$(tput sgr0)" ; done
fi
```
