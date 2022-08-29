BEGIN {
    nReadyHead = 0;
    nReadyWorkers = 0;

    if (MAX_WORKERS == 0) {
        if (KUBE_POD_MANAGER == "ray") {
            cmd = "kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} get raycluster ${RAY_KUBE_CLUSTER_NAME-mycluster} -o json | jq \".spec.podTypes | .[] | select(.name==\\\"rayWorkerType\\\") | .maxWorkers\"";
            cmd | getline MAX_WORKERS;
        } else {
            cmd = "kubectl --context ${KUBE_CONTEXT} -n ${KUBE_NS} get deploy ${RAY_KUBE_CLUSTER_NAME-mycluster}-ray-worker -o json | jq -r \".spec.replicas\"";
            cmd | getline MAX_WORKERS;
        }
    }
}

$2 == "head" {
    if ($3 == "Running") readyHead="1/1";
    else readyHead = "0/1";
    print "head   ", readyHead;
    fflush();
}

$2 == "worker" {
    if ($3 == "Running") {
        if (ready[$1] != 1) { ready[$1]=1; nReadyWorkers++; }
    } else if (ready[$1] == 1) {
        nReadyWorkers--;
        if (nReadyWorkers < 0) nReadyWorkers = 0;
        ready[$1] = 0
    }

    print "workers", nReadyWorkers "/" MAX_WORKERS;
    fflush();
}
