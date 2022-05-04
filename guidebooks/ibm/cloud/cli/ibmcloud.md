# Install the IBM Cloud CLI

The installation command in this tutorial installs the latest stand-alone IBM Cloud CLI version available.

=== "MacOS"
    ```shell
    ---
    validate: which ibmcloud
    ---
    curl -fsSL https://clis.cloud.ibm.com/install/osx | sh
    ```
    
=== "Linux"
    ```shell
    ---
    validate: which ibmcloud
    ---
    curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
    ```

=== "Windows"
    ```shell
    ---
    validate: which ibmcloud
    ---
    iex(New-Object Net.WebClient).DownloadString('https://clis.cloud.ibm.com/install/powershell')
    ```

=== "Windows Subsystem for Linux"
    ```shell
    ---
    validate: which ibmcloud
    ---
    curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
    ```
