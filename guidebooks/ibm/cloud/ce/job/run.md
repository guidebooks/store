---
imports:
    - ../cli/plugins/ce.md
    - ../project.md
---

# IBM Cloud Code Engine: Run a Job

A [Code Engine
job](https://cloud.ibm.com/docs/codeengine?topic=codeengine-run-job-tutorial)
runs one or more instances of your executable code. Unlike [Code
Engine
applications](https://cloud.ibm.com/docs/codeengine?topic=codeengine-deploy-app-tutorial),
which handle HTTP requests, jobs are designed to run one time and
exit. When you create a job, you can specify workload configuration
information that is used each time that the job is run.

## Choose a Job to Run

=== "Example: Hello World"

    For this example, you do not need to modify the default values for environment variables or runtime settings. For more information aboutthe code that is used for this example, see [firstjob](https://github.com/IBM/CodeEngine/tree/main/job).

    ```shell
    ibmcloud ce jobrun submit --image icr.io/codeengine/firstjob --name helloworld-${uuid}
    sleep 1
    ibmcloud ce jobrun logs -f --jobrun helloworld-${uuid}
    ```
