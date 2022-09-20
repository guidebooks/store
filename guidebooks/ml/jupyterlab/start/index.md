# Run a JupyterLab Server

[JupyterLab](https://jupyterlab.readthedocs.io/en/stable/index.html) is an open source platform to manage Jupyter notebooks 
from a web console with ease. Jupyter notebooks are interactive Python sessions that allow users to build Python scripts 
in a *comparmentalized* way, with the data living throughout the notebook execution.

=== "Run Locally"
    Start a JupyterLab server on your computer
    --8<-- "./local"

=== "Run on a Kubernetes Cluster"
    Start a JupyterLab server on a Kubernetes cluster
    --8<-- "./kubernetes"

=== "Shut down a Kubernetes Cluster"
    Stop a Kubernetes cluster that maybe running a Jupyter server
    :import{ml/ray/stop/kubernetes}

=== "Shut down a JupyterLab server"
    Stop a JupyterLab server
    :import{ml/jupyterlab/stop/kubernetes}
