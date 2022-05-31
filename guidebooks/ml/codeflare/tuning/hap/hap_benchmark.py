#!/usr/bin/env python

# Copyright 2021 IBM Corp.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import sys
import time
import datetime
import boto3
import tarfile
import subprocess
import ray
import argparse
from glob import glob
import logging
import socket


# ------------ validate S3 -----------
# Validate bucket and object in bucket

def Validate_S3(logger,bucket,object):
  param = os.environ.get('S3_ACCESS_KEY_ID')
  if param == None:
    logger.warning("S3_ACCESS_KEY_ID is missing from environment")
    return False
  param = os.environ.get('S3_SECRET_ACCESS_KEY')
  if param == None:
    logger.warning("S3_SECRET_ACCESS_KEY is missing from environment")
    return False
  param = os.environ.get('S3_ENDPOINT')
  if param == "":
    logger.warning("S3_ENDPOINT is empty, assuming AWS object store")
    client = boto3.client(
      's3',
      aws_access_key_id = os.environ.get('S3_ACCESS_KEY_ID'),
      aws_secret_access_key = os.environ.get('S3_SECRET_ACCESS_KEY')
    )
  else:
    client = boto3.client(
      's3',
      aws_access_key_id = os.environ.get('S3_ACCESS_KEY_ID'),
      aws_secret_access_key = os.environ.get('S3_SECRET_ACCESS_KEY'),
      endpoint_url = os.environ.get('S3_ENDPOINT')
    )

  try:
    check = client.head_bucket(Bucket=bucket)
  except Exception as e:
    logger.warning(f"bucket={bucket} not found")
    return False

  try:
    check = client.head_object(Bucket=bucket, Key=object)
  except Exception as e:
    logger.warning(f"key={object} not found in bucket={bucket}")
    return False

  return True


# ------------ detached ray actor: DataRefs -----------
# pulls data from S3 and caches in Plasma for local scaleout
# returns objref for data previously cached
# S3 credentials must be defined in the env

@ray.remote
class DataRefs:
  def __init__(self,bucket):
    self.state = {}
    self.refs = {}
    self.bucket = bucket
    param = os.environ.get('S3_ENDPOINT')
    if param == "":
      self.client = boto3.client(
        's3',
        aws_access_key_id = os.environ.get('S3_ACCESS_KEY_ID'),
        aws_secret_access_key = os.environ.get('S3_SECRET_ACCESS_KEY')
      )
    else:
      self.client = boto3.client(
        's3',
        aws_access_key_id = os.environ.get('S3_ACCESS_KEY_ID'),
        aws_secret_access_key = os.environ.get('S3_SECRET_ACCESS_KEY'),
        endpoint_url = os.environ.get('S3_ENDPOINT')
      )

  # check if data for key is already cached
  # if not, try to get data from s3 and put it in plasma
  def Get_dataref(self,key):
    if key in self.state:
      if self.state[key] == 'Cached':
        return self.refs[key]
    print(f"  try to get {key} from s3")
    try:
      dataobject = self.client.get_object(Bucket=self.bucket, Key=key)
      data = dataobject['Body'].read()
      print(f"  try to put {key} data into plasma")
      self.refs[key] = ray.put(data)
      self.state[key] = 'Cached'
      return self.refs[key]
    except Exception as e:
      print("Unable to retrieve/put object contents: {0}\n\n".format(e))
      self.state[key] = 'Failed'
      return None

  def Get_state(self):
    return self.state


# ------------ Fetch dataref into plasma -----------
# Calls actor to get objref of S3 data cached in Plasma
def Fetch_data_to_cache(logger,dataRefs,key):
  try:
    st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    logger.info(f"{st} Get {key} data reference from data actor")
    ref = ray.get(dataRefs.Get_dataref.remote(key))
    if ref == None:
      logger.warning(f"Could not get {key} data reference from data actor")
      return False
    return True

  except Exception as e:
    logger.warning(f"Unable to retrieve {key} dataset: {0}".format(e))
    return False

# ------------ Fetch data to local dir -----------
# pulls data from Plasma and unpack in local directory
def Fetch_data_to_local_dir(logger,dataRefs,key):
  if not Fetch_data_to_cache(logger,dataRefs,key):
    return False
  try:
    time_start = time.time()
    ref = ray.get(dataRefs.Get_dataref.remote(key))
    if ref == None:
      logger.warning(f"Could not get {key} data reference from data actor")
      return False

    dataset = ray.get(ref)
    time_done = time.time()
    st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    logger.info(f"{st} getting data length={len(dataset)} took {time_done-time_start:.2f}s")
    tmpdata = f"/tmp/{key}.tgz"
    f = open(tmpdata, "wb")
    f.write(dataset)
    f.close
    time_start = time.time()
    file = tarfile.open(tmpdata)
    file.extractall('./')
    file.close()
    time_done = time.time()
    st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    logger.info(f"{st} unpacking {key} tarfile took {time_done-time_start:.2f}s")
    return True

  except Exception as e:
    logger.warning(f"Unable to retrieve/unpack {key} dataset: {0}".format(e))
    return False


# -------------------- Process_task -----------------
@ray.remote(num_gpus=1)
def process_task(dataRefs,dataset_path,rank,worldsize,results_path):
  # clean up local result directory
  subprocess.run(['rm', '-rf', results_path])
  subprocess.run(['mkdir', '-p', results_path])

  # create console handler at DEBUG and logfile hander at INFO
  logger = logging.getLogger(__name__)
  logger.setLevel(logging.DEBUG)
  consoleHandler = logging.StreamHandler(sys.stdout)
  consoleHandler.setLevel(logging.DEBUG)
  logger.addHandler(consoleHandler)
  fileHandler = logging.FileHandler(f"{results_path}/rank.log")
  fileHandler.setLevel(logging.INFO)
  logger.addHandler(fileHandler)

  # Reuse local dataset directory or try to create it
  if not os.path.isdir('./'+dataset_path):
    print(f"did not find {dataset_path}")
    if not Fetch_data_to_local_dir(logger, dataRefs, dataset_path):
      print(f"Fetch_data_to_local_dir for {dataset_path} failed")
      time.sleep(5)
      return ['ERROR',f"Fetch_data_to_local_dir for {dataset_path} failed"]
  else:
    logger.info(f"Reusing previous existing {dataset_path}")

  # change location of transformer cache
  os.environ['TRANSFORMERS_CACHE'] = '/tmp/cache/'

  runargs = ["python","./simple_dbg_bck.py"]
  runargs.extend(["--dataset_path",dataset_path])
  runargs.extend(["--rank",str(rank)])
  runargs.extend(["--worldsize",str(worldsize)])
  runargs.extend(["--results_path",results_path])

  time_start = time.time()
  print(f"runargs={runargs}")
  proc = subprocess.Popen(runargs,stdout=subprocess.PIPE, stderr=subprocess.STDOUT,universal_newlines=True)
  for line in proc.stdout:
    if not line == "\n":
      logger.info(line.rstrip())
  proc.wait()
  time_proc = time.time()-time_start

  files = glob(os.path.join(results_path, f"*.csv"))
  files.append(os.path.join(results_path, "rank.log"))
  taskres = {}
  taskres["dataset_path"] = dataset_path
  taskres["rank"] = rank
  taskres["worldsize"] = worldsize
  taskres["results_path"] = results_path
  taskres["time"] = time_proc
  taskres["hostname"] = socket.gethostname()
  for f in files:
    with open(f, "rb") as afile:
      data = afile.read()
    taskres[os.path.basename(f)] = data

  # flush logfile
  logger.removeHandler(consoleHandler)
  logger.removeHandler(fileHandler)
  del logger, consoleHandler, fileHandler

  # clean up local result directory
  subprocess.run(['rm', '-rf', results_path])

  return taskres



# -------------------- MAIN ------------------
if __name__ == "__main__":
  parser = argparse.ArgumentParser(description='Driver for HAP filtering')
  parser.add_argument('-s','--rank_start', type=int, required=True)
  parser.add_argument('-e','--rank_end', type=int, required=True)
  parser.add_argument('-w','--worldsize', default=24)
  parser.add_argument('-b','--bucket', default='HAP_S3_Ignore', help="S3 bucket name")
  parser.add_argument('-d','--dataset_path', required=True,
                      help="S3 Key and local directory name of input directory data")
  parser.add_argument('-r','--ray_service', default="auto",help="ray_service:port")
  parser.add_argument('-v','--verbose', action='store_true',help="show remote consoles (Default=False)")
  args = parser.parse_args()

  # static args
  results_path='/tmp/HAP_results'

  # create logger for driver stdout and logfile
  logger = logging.getLogger(__name__)
  logger.setLevel(logging.INFO)
  consoleHandler = logging.StreamHandler(sys.stdout)
  consoleHandler.setLevel(logging.INFO)
  logger.addHandler(consoleHandler)
  fileHandler = logging.FileHandler("/tmp/HAPjobs.console")
  fileHandler.setLevel(logging.INFO)
  logger.addHandler(fileHandler)

  st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
  logger.info(f"\n{st} Starting HAP benchmark ---------------")
  logger.info(f"rank_start: {args.rank_start}")
  logger.info(f"rank_end: {args.rank_end}")
  logger.info(f"worldsize: {args.worldsize}")
  logger.info(f"dataset_path: {args.dataset_path}")
  logger.info(f"bucket: {args.bucket}")
  logger.info(f"ray_service: {args.ray_service}")
  logger.info(f"verbose: {args.verbose}")

  # connect to ray cluster
  ray.init(args.ray_service,log_to_driver=args.verbose,namespace="ibm-HAP")

  # check if S3 credentials are set and objects look accessible
  if args.bucket == 'HAP_S3_Ignore':
    dataRefs = 'ignore'
  else:
    if not Validate_S3(logger,args.bucket,args.dataset_path):
      logger.error(f"Fatal error verifying S3 access to {args.dataset_path}")
      time.sleep(5)
      sys.exit()

    # create data actor if not yet exists
    # namespace is required to find a previously persisted actor instance
    data_actor_name = 'DataRefsActor'
    names = ray.util.list_named_actors()
    if any(x == data_actor_name for x in names):
      dataRefs = ray.get_actor(data_actor_name)
      state = ray.get(dataRefs.Get_state.remote())
      logger.info(f" Found actor={data_actor_name} with state {state}")
    else:
      logger.info(f"  actor={data_actor_name} not found ... deploy it")
      dataRefs = DataRefs.options(name=data_actor_name,lifetime="detached").remote(args.bucket)

    # make sure required datasets are cached in actor
    actorstate = ray.get(dataRefs.Get_state.remote())
    if not actorstate.get(args.dataset_path) == 'Cached':
      if not Fetch_data_to_cache(logger,dataRefs,args.dataset_path):
        logger.error(f"Fatal error caching dataset from S3")
        time.sleep(5)
        sys.exit()

  ranks=range(args.rank_start, args.rank_end)
  tasks=[]
  for rank in ranks:
    tasks.append(process_task.remote(dataRefs,args.dataset_path,rank,args.worldsize,results_path))

  # wait for all to be done, one at a time
  # TODO handle remote processing exceptions
  st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
  logger.info(f"{st} Submitted {len(tasks)} ranks")
  incomplete = tasks
  complete = []
  while len(complete) < len(tasks):
    onedone, incomplete = ray.wait(incomplete, num_returns=1, timeout=None)
    results = ray.get(onedone)
    complete.append(onedone)
    taskres = results[0]

    st = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    if "ERROR" in taskres:
      logger.error(f"{st} Fatal error: {taskres['ERROR']}")
      sys.exit()

  # check for valid result
    if any(x.startswith('results_path') for x in taskres):
      logger.info(f"{st} {taskres['dataset_path']} rank={taskres['rank']} worldsize={taskres['worldsize']}"+
                  f" took {taskres['time']:.1f}s on {taskres['hostname']} ... {len(complete)} of {len(tasks)} ranks done")
    else:
      logger.error(f"{st} {taskres['dataset_path']} rank={taskres['rank']} worldsize={taskres['worldsize']}"+
                   f" returned ERROR ... {len(complete)} of {len(tasks)} ranks done")

  # copy results to a known place for access from outside pod; Remove any leftover files
    outfolder = f"/tmp/HAP_summary/{taskres['dataset_path']}-{taskres['rank']}"
    subprocess.run(['mkdir', '-p', outfolder])
    subprocess.run(['rm', '-rf', outfolder+"/*"])

    for key in taskres.keys():
      if key.endswith('csv') or key.endswith('log'):
        f = open(outfolder+'/'+key, "wb")
        f.write(taskres[key])
        f.close
