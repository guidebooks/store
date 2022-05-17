---
imports:
    - ../../cli/plugins/ce.md
    - ../project.md
---

# IBM Cloud Code Engine: Create an Application

With this tutorial, create an application with the Code Engine CLI. 

The application scales to zero when not in use. An application runs your code to serve HTTP requests. The number of running instances of an app are automatically scaled up or down (to zero) based on incoming workloads and your configuration settings.

## Create an Application

=== "Example: 'Hello World' application"

    This app pulls an image that is called icr.io/codeengine/cron. This app logs each event as it arrives, showing the full set of HTTP Headers and HTTP Body payload. For more information about the code that is used for this example, see [cron](https://github.com/IBM/CodeEngine/tree/main/cron).

    ```bash
    ---
    validate: ibmcloud ce application get --name hello-${uuid}
    ---
    ibmcloud ce app create --name hello-${uuid} --image icr.io/codeengine/cron
    curl $(ibmcloud ce app get -n hello-${uuid} -o url)
    ```

    ```shell
    export ce_resource_=hello-${uuid}
    ```

    ```shell
    export ce_resource_type=app
    ```

    ```shell
    export ce_runtime_resource_type=app
    ```