---
imports:
    - ./login.md
---

# IBM Cloud: Target a Cloud Region

This guidebook helps you with targeting your [IBM
Cloud](https://www.ibm.com/cloud) operations against a selected
[region](https://www.ibm.com/cloud/data-centers).

=== "expand(ibmcloud regions --output json | jq -r '.[] | .Name')"

    ```shell
    ---
    validate: true
    ---
    ibmcloud target -r "${choice}"
    ```