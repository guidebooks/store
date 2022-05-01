---
codeblocks:
    - match: openshift
      validate: which oc
---

# Install the Openshift CLI

The `oc` CLI gives you command line access to your
[OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift)
cluster.

=== "MacOS"

    === "Intel"
        ```shell
        curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-mac.tar.gz | tar zxf - oc
        sudo mv oc /usr/local/bin
        ```

    === "Apple Silicon"
        ```shell
        curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-mac-arm64.tar.gz | tar zxf - oc
        sudo mv oc /usr/local/bin
        ```

=== "Linux"
    ```shell
    curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz | tar zxf - oc
    sudo mv oc /usr/local/bin
    ```


=== "Win32"
    ```shell
    curl -s --retry 10 -L https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-windows.zip
    unzip openshift-client-windows.zip oc
    ```

    <!-- TODO here, where do we install oc on windows? -->
