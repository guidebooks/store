---
imports:
    - ../../../util/jq.md
    - ../target.md
    - ../cli/plugins/ce.md
---

# IBM Cloud Code Engine: Select a Project

A project is a grouping of [Code
Engine](https://cloud.ibm.com/docs/codeengine) entities such as
[applications, jobs, and
builds](https://cloud.ibm.com/docs/codeengine?topic=codeengine-about#terminology). Projects
are used to manage resources and provide access to its entities.

=== "Create a new project"

    You may create a fresh Code Engine project.
    ```shell
    ibmcloud ce project create --name myproject-${uuid}
    ```

=== "expand(ibmcloud ce project list -o json | jq -r '.[] | select(.state == \"active\")  | \"\\(.name) \\(.region_id)\"', Code Engine Projects)"

    ```shell
    export DESIRED_IBMCLOUD_REGION=$(echo "$choice" | awk '{print $2}')
    ```

    ```shell
    ---
    validate: ibmcloud ce project current | grep ${choice}
    ---
    ibmcloud target -r ${DESIRED_IBMCLOUD_REGION}
    ibmcloud ce project target --name $(echo "$choice" | awk '{print $1}')
    ```
