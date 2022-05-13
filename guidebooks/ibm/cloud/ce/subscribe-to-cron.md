---
imports:
    - ../../cli/plugins/ce.md
    - ../project.md
---

# IBM Cloud Code Engine: Subcribing to cron events

With this tutorial, you can learn how to subscribe to cron events by using the IBM Cloud® Code Engine CLI.

With Code Engine, your applications or jobs can receive events of interest by subscribing to event producers. Code Engine supports two types of event producers: Cron and IBM Cloud Object Storage. Event information is received as POST HTTP requests for applications and as environment variables for jobs.

## Create a new app

=== "Create an application called 'cron-app'"

    This app pulls an image that is called icr.io/codeengine/cron. This app logs each event as it arrives, showing the full set of HTTP Headers and HTTP Body payload. For more information about the code that is used for this example, see [cron](https://github.com/IBM/CodeEngine/tree/main/cron)

    ```shell
    ibmcloud ce app create --name cron-app --image icr.io/codeengine/cron 
    ```

# Create a subcription

=== "Create a cron subcription"

    After your app is ready, create a subscription to the cron event producer and connect it to your app.

    The following example creates a cron subscription that is called cron-sub and specifies the cron-app application as its destination. The subscription uses the --data option to include a JSON string in the cron event. It also specifies the cron schedule by using the --schedule option with a value of * * * * * to send an event every minute of every day to the cron-app application.

    ```shell
    ibmcloud ce sub cron create --name cron-sub --destination cron-app --data '{"mydata":"hello world"}' --schedule '* * * * *'
    sleep 5
    ibmcloud ce app logs --name cron-app
    ```