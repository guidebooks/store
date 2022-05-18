---
imports:
    - ../../cli/plugins/ce.md
    - ../project.md
---

# IBM Cloud Code Engine: Choosing Jobs

A [Code Engine
job](https://cloud.ibm.com/docs/codeengine?topic=codeengine-run-job-tutorial)
runs one or more instances of your executable code. Unlike [Code
Engine
applications](https://cloud.ibm.com/docs/codeengine?topic=codeengine-deploy-app-tutorial),
which handle HTTP requests, jobs are designed to run one time and
exit. When you create a job, you can specify workload configuration
information that is used each time that the job is run.

## Choose an existing job or run a new job

=== "expand(ibmcloud ce job list -o json | jq -r '.[] | .metadata.name')"

    ```shell
    export ce_resource=${choice}
    ```

    ```shell
    export ce_resource_type=job
    ```

    ```shell
    export ce_runtime_resource_type=jobrun
    ```

=== "Run a new job"

    :import{run.md}