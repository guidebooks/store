---
codeblocks:
    - match: openshift
      validate: which odo
---

# Install the Openshift Developer CLI

`odo` is a CLI that helps developers build on
[OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift)
and [Kubernetes](https://kubernetes.io/) cluster.

=== "MacOS"

    === "Intel"
        ```shell
        curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-darwin-amd64.tar.gz | tar zxf - odo-darwin-amd64
        sudo mv odo-darwin-amd64 /usr/local/bin/odo
        ```

    === "Apple Silicon"
        ```shell
        curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-darwin-arm64.tar.gz | tar zxf - odo-darwin-arm64
        sudo mv odo-darwin-arm64 /usr/local/bin/odo
        ```

=== "Linux"
    ```shell
    curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-linux-amd64.tar.gz | tar zxf - odo-linux-amd64
    sudo mv odo-linux-amd64 /usr/local/bin/odo
    ```

=== "Win32"
    ```shell
    curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/odo/latest/odo-windows.zip
    unzip odo-windows.zip odo
    ```

    <!-- TODO here, where do we install odo on windows? -->
