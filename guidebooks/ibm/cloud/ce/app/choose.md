---
imports:
    - ../../cli/plugins/ce.md
    - ../project.md
---

# IBM Cloud Code Engine: Choosing Applications

Choose an existing application or create a new application using our example images.

The application scales to zero when not in use. An application runs your code to serve HTTP requests. The number of running instances of an app are automatically scaled up or down (to zero) based on incoming workloads and your configuration settings.

## Choose an existing app or create new app

=== "expand(ibmcloud ce app list -o json | jq -r '.items[] | .metadata.name')"

    ```shell
    export ce_resource=${choice}
    ```

    ```shell
    export ce_resource_type=app
    ```

    ```shell
    export ce_runtime_resource_type=jobrun
    ```

=== "Create a new application"

    :import{create.md}