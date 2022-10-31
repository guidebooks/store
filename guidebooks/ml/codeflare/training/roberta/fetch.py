import subprocess
from os import environ

print("CodeFlare job launcher: starting up")

datapath = environ.get("ML_CODEFLARE_ROBERTA_DATAPATH", "/tmp/roberta-sample-input")

def fetch():
    from os.path import exists

    bucket = environ.get("ML_CODEFLARE_ROBERTA_S3_BUCKET", "codeflare-roberta-public")
    key = environ.get("ML_CODEFLARE_ROBERTA_S3_OBJECT", "roberta-sample-input-0.0.1.tar.gz")
    endpoint_url = environ.get("ML_CODEFLARE_ROBERTA_S3_ENDPOINT_URL", "https://s3.us-east.cloud-object-storage.appdomain.cloud")

    tmp = f"/tmp/{key}"

    if not exists(tmp):
        import boto3

        print(f"CodeFlare job launcher: downloading sample input {endpoint_url}/{bucket}/{key}")

        s3 = boto3.resource(
            's3',
            endpoint_url = endpoint_url
        )

        import botocore
        s3.meta.client.meta.events.register('choose-signer.s3.*', botocore.handlers.disable_signing)

        resp = s3.meta.client.download_file(bucket, key, tmp)

        if not exists(datapath):
            from os import makedirs
            makedirs(datapath)

            if tmp.endswith(".tar.gz"):
                print(f"CodeFlare job launcher: untarring sample input to {datapath}")

                subprocess.run(["tar", "zxf", tmp], cwd=datapath)


defaultArgs = ["--simulated_gpus=8", "--b_size=64", "--logdir=/tmp/"]
if environ.get("ML_CODEFLARE_ROBERTA_DATA") == "public":
    defaultArgs=[
        "--simulated_gpus=4",
        "--num_steps=100",
        "--report_interval=10",
        "--b_size=12",
        "--logdir=/tmp/"
    ]
    fetch()

import sys
print("CodeFlare job launcher: main " + environ.get("ML_CODEFLARE_MAIN"))
args = ["python3", environ.get("ML_CODEFLARE_MAIN", "main.py"), "--datapath", datapath] + defaultArgs + sys.argv[1:]
print(f"CodeFlare job launcher: running {args}")

subprocess.run(args)
