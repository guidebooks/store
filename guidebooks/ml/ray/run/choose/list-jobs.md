# Choose a Ray Run

This guidebook assumes the use of the Ray v2 API.

First, wait a bit until jobs are available.

```shell
if [ -n "$RAY_ADDRESS" ]; then
    N=1
    while ([ "[]" = "$(curl -s $RAY_ADDRESS/api/jobs/)" ] || [ "404: Not Found" = "$(curl -s $RAY_ADDRESS/api/jobs/)" ]) && [ "$N" -lt 10 ]; do
        echo "Waiting for a Ray job to be active"
        sleep 2
        N=$((N + 1))
    done
fi
```

=== "expand([ -z \"$RAY_ADDRESS\" ] && exit 1 || [ "${RAY_VERSION_MAJOR-2}" = 1 ] && curl $RAY_ADDRESS/api/jobs/ | jq -r 'to_entries | sort_by(.value.start_time) | reverse | .[] | \"\\(.key) \\(.value.status) \\(.value.start_time / 1000 | strflocaltime(\"%Y-%m-%dT%H:%M:%S\")) \\(.value.entrypoint)\"' | sed -E 's/python3 ([^[:space:]])+ //g' | awk '{a=$1;b=$2;c=$3; $1=\"\";$2=\"\";$3=\"\"; print a, \"\033[0;36m\" c, \"\033[0;1;33m\" b \"\033[0;2m\" $0 \"\033[0m\"}' || curl $RAY_ADDRESS/api/jobs/ | jq -r 'to_entries | sort_by(.value.start_time) | reverse | .[] | \"\\(.value.submission_id) \\(.value.status) \\(.value.start_time / 1000 | strflocaltime(\"%Y-%m-%dT%H:%M:%S\")) \\(.value.entrypoint)\"' | sed -E 's/python3 ([^[:space:]])+ //g' | awk '{a=$1;b=$2;c=$3; $1=\"\";$2=\"\";$3=\"\"; print a, \"\033[0;36m\" c, \"\033[0;1;33m\" b \"\033[0;2m\" $0 \"\033[0m\"}', Ray Runs)"
    ```shell
    export JOB_ID=$(echo "$choice" | awk '{print $1}')
    ```

=== "I don't see my job. Exit now, and I will try again later."
    ```shell
    exit 90 # early exit
    ```
