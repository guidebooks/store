---
imports:
    - ./login.md
codeblocks:
    - match: ibmcloud resource groups
      validate: ibmcloud target | grep 'Resource group:' | cut -d ':' -f2 | sed -e 's/^[[:space:]]*//' | grep -qv 'No resource group targeted'
---

# IBM Cloud: Target a Resource Group

This guidebook helps you with targeting your [IBM
Cloud](https://www.ibm.com/cloud) operations against a selected
[resource group](https://cloud.ibm.com/docs/account?topic=account-rgs&interface=ui).

=== "expand(ibmcloud resource groups | grep ACTIVE | cut -d ' ' -f1)"
    ```shell
    ibmcloud target -g "${choice}"
    ```
