# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Attribution: https://github.com/tensorflow/tensorboard/blob/master/docs/get_started.ipynb
# IntegratedBy: @starpit 20220724 modifications marked @starpit

import os
import tensorflow as tf
import datetime

# Optionally, we support loading the mnist.npz data from s3. This is
# only done if the S3_ENDPOINT environment variable is set. Otherwise,
# we use the default path for loading the mnist data -- however
# tensorflow wants to do so.
def load_from_s3():
  import boto3
  import numpy as np
  client = boto3.client(
    's3',
    aws_access_key_id = os.environ.get('S3_ACCESS_KEY_ID'),
    aws_secret_access_key = os.environ.get('S3_SECRET_ACCESS_KEY'),
    endpoint_url = os.environ.get('S3_ENDPOINT')
  )

  bucket=os.environ.get('S3_BUCKET')
  object=os.environ.get('S3_OBJECT')
  file=os.path.join('/tmp', os.path.basename(object))
  print(f"  Data: try remote get {object} from s3")
  client.download_file(bucket, object, file)
  print(f"  Data: done remote get {object} from s3")
  print(f"  Data: try parsing")
  with np.load(file, allow_pickle=True) as f:
    x_train, y_train = f["x_train"], f["y_train"]
    x_test, y_test = f["x_test"], f["y_test"]

    print(f"  Data: done parsing")
    return (x_train, y_train), (x_test, y_test)

# Using the MNIST dataset as the example, normalize the data and write a function that creates a simple Keras model for classifying the images into 10 classes.
if os.getenv("S3_ENDPOINT"):
  (x_train, y_train),(x_test, y_test) = load_from_s3()
else:
  mnist = tf.keras.datasets.mnist
  (x_train, y_train),(x_test, y_test) = mnist.load_data()
  
x_train, x_test = x_train / 255.0, x_test / 255.0

def create_model():
  return tf.keras.models.Sequential([
    tf.keras.layers.Flatten(input_shape=(28, 28)),
    tf.keras.layers.Dense(512, activation='relu'),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(10, activation='softmax')
  ])

# When training with Keras's Model.fit(), adding the tf.keras.callbacks.TensorBoard callback ensures that logs are created and stored. Additionally, enable histogram computation every epoch with histogram_freq=1 (this is off by default)
#
# Place the logs in a timestamped subdirectory to allow easy selection of different training runs.
model = create_model()
model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

log_dir = "/tmp/logdir" # @starpit
print(f"Logging tensorboard to {log_dir}") # @starpit

tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)

model.fit(x=x_train, 
          y=y_train, 
          epochs=5, 
          validation_data=(x_test, y_test), 
          callbacks=[tensorboard_callback])

# Helps with tests # @starpit
print("Final result") # @starpit
