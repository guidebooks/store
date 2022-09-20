#!/usr/bin/env bash

# generate a main.sh in the provided $ML_CODEFLARE_ROBERTA_WORKDIR
# working directory that deals with fetching the data from s3

if [ "$ML_CODEFLARE_ROBERTA_DATA" = "public" ]; then
    # use sample data
    R_DATA_ENDPOINT=${ML_CODEFLARE_ROBERTA_S3_ENDPOINT_URL-s3.direct.us-east.cloud-object-storage.appdomain.cloud}
    R_DATA_BUCKET=${ML_CODEFLARE_ROBERTA_S3_BUCKET-codeflare-roberta-public}
    R_DATA_OBJECT=${ML_CODEFLARE_ROBERTA_S3_OBJECT-roberta-sample-input-0.0.1.tar.gz}
    R_ARGS=${ML_CODEFLARE_ROBERTA_ARGS-"--simulated_gpus 4 --num_steps 100 --report_interval 10 --b_size 12 --logdir=/tmp/"}
    # ^^^ here we are using a quite conservative b_size, to allow for running on a 16GiB GPU
else
    # bring your own data
    R_DATA_ENDPOINT=$S3_ENDPOINT_URL
    R_DATA_BUCKET=$S3_BUCKET
    R_DATA_OBJECT=$S3_OBJECT
    R_ARGS="--simulated_gpus 8 --b_size 64"
fi

DATAPATH=${ML_CODEFLARE_ROBERTA_DATAPATH-/tmp/roberta-sample-input}

set -e
set -o pipefail

if [ -z "$ML_CODEFLARE_ROBERTA_WORKDIR" ]; then
    echo "Missing working directory ML_CODEFLARE_ROBERTA_WORKDIR"
    exit 1
fi
cd "$ML_CODEFLARE_ROBERTA_WORKDIR"

# this script will be run on the target machines, not the user's laptop
if [ "$ML_CODEFLARE_ROBERTA_DATA" = "premounted" ]; then
    cat << EOF > main.sh
echo "Spawning job with --datapath=$DATAPATH $R_ARGS \$@"
(cd "$ML_CODEFLARE_ROBERTA_REPO/$ML_CODEFLARE_ROBERTA_SUBDIR" && python3 train_roberta.py --datapath=$DATAPATH $R_ARGS \$@)
EOF
else
    cat << EOF > main.sh
set -e
set -o pipefail
if [ ! -s /tmp/$R_DATA_OBJECT ]; then
  if [ ! -f /tmp/s5cmd ]; then
      PLATFORM=Linux-64bit
      echo "Fetching s5cmd for platform=\$PLATFORM"
      (cd /tmp && wget -q -O- https://github.com/peak/s5cmd/releases/download/v2.0.0/s5cmd_2.0.0_\${PLATFORM}.tar.gz | tar zxf - s5cmd && chmod +x s5cmd)
  fi

   export S3_ENDPOINT_URL=$R_DATA_ENDPOINT
   if [ "\$S3_ENDPOINT_URL" = "s3.direct.us-east.cloud-object-storage.appdomain.cloud" ]; then
     set +e
     X=\$(wget -t1 --connect-timeout=4 --spider "\$S3_ENDPOINT_URL" 2>&1)
     if echo "\$X" | grep "Giving up"; then
         # then we must not be internal to ibmcloud; we cannot use the direct endpoint
         export S3_ENDPOINT_URL=s3.us-east.cloud-object-storage.appdomain.cloud
         echo "Using public endpoint"
     else
         echo "Using ibmcloud endpoint"
     fi
   fi

   echo "Fetching data from \$S3_ENDPOINT_URL"
   time /tmp/s5cmd --no-sign-request cp s3://$R_DATA_BUCKET/$R_DATA_OBJECT /tmp/$R_DATA_OBJECT
   echo "Fetching data done"
   echo "Disseminating data to workers"
   time kubectl get pod -l ray-node-type=worker -o name | sed 's#pod/##g' | xargs -P4 -I POD -n1 bash -c "kubectl cp /tmp/$R_DATA_OBJECT POD:/tmp/$R_DATA_OBJECT && kubectl exec POD -- bash -c \"rm -rf $DATAPATH && mkdir -p $DATAPATH && cd $DATAPATH && tar -zxf /tmp/$R_DATA_OBJECT\""
   echo "Disseminating data to workers done"
fi

echo "Spawning job with --datapath=$DATAPATH $R_ARGS \$@"
(cd "$ML_CODEFLARE_ROBERTA_REPO/$ML_CODEFLARE_ROBERTA_SUBDIR" && python3 train_roberta.py --datapath=$DATAPATH $R_ARGS \$@)
EOF
fi

chmod +x main.sh
