---
imports:
    - ../target.md
---

# IBM Cloud CodeEngine: Select a Project

A project is a grouping of Code Engine entities such as applications,
jobs, and builds. Projects are used to manage resources and provide
access to its entities.

=== "expand(ibmcloud ce project list  -o json | jq -r '.[] | select(.state = \"active\").name')"
    ```shell
    ---
    validate: ibmcloud ce project current
    ---
    ibmcloud ce project target --name ${choice}
    ```
