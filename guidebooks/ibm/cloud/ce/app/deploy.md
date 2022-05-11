---
imports:
    - ../../cli/plugins/ce.md
    - ../project.md
---

# IBM Cloud Code Engine: Deploying an Application

With this tutorial, deploy an application with the Code Engine CLI. 

The application scales to zero when not in use. An application runs your code to serve HTTP requests. The number of running instances of an app are automatically scaled up or down (to zero) based on incoming workloads and your configuration settings.

## Deploy your Application

=== "Example: Hello World"

    The following command creates and deploys an app that is named myapp and uses the sample container image icr.io/codeengine/hello, which is a simple Hello World program. 
    
    The program includes an environment variable TARGET, and prints Hello ${TARGET}. If the environment variable is empty, Hello World is returned. For more information about the code that is used for this example, see [hello](https://github.com/IBM/CodeEngine/tree/main/hello).

    ```shell
    ibmcloud ce application create --name myapp-${uuid} --image icr.io/codeengine/hello
    ```