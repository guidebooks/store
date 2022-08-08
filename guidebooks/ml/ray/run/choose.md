---
imports:
    - util/jq
    - kubernetes/choose/ns
    - ml/ray/cluster
---

# Choose a Ray Run

=== "expand([ -n \"$RAY_ADDRESS\" ] && curl $RAY_ADDRESS/api/jobs/ | jq -r 'to_entries | sort_by(.value.start_time) | reverse | .[] | \"\\(.key) \\(.value.status) \\(.value.start_time / 1000 | strflocaltime(\"%Y-%m-%dT%H:%M:%S\")) \\(.value.entrypoint)\"' | sed -E 's/python3 ([^[:space:]])+ //g' | awk '{a=$1;b=$2;c=$3; $1=\"\";$2=\"\";$3=\"\"; print a, \"\033[0;36m\" c, \"\033[0;1;33m\" b \"\033[0;2m\" $0 \"\033[0m\"}', Ray Runs)"
    ```shell
    export JOB_ID=$(echo "$choice" | awk '{print $1}')
    ```
