---
codeblocks:
    - match: .*
      validate: which ibmcloud
---

# Install the IBM Cloud CLI

The installation command in this tutorial installs the latest stand-alone IBM Cloud CLI version available.

=== "MacOS"
    ```shell
    curl -fsSL https://clis.cloud.ibm.com/install/osx | sh
    ```
    
=== "Linux"
    ```shell
    curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
    ```

=== "Windows"
    ```shell
    iex(New-Object Net.WebClient).DownloadString('https://clis.cloud.ibm.com/install/powershell')
    ```

=== "Windows Subsystem for Linux"
    ```shell
    curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
    ```
