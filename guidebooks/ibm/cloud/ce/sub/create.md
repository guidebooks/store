---
imports:
    - ../../cli/plugins/ce.md
    - ../project.md
---

# IBM Cloud Code Engine: Subcribing to cron events

With this tutorial, you can learn how to subscribe to cron events by using the IBM Cloud® Code Engine CLI.

With Code Engine, your applications or jobs can receive events of interest by subscribing to event producers. Code Engine supports two types of event producers: Cron and IBM Cloud Object Storage. Event information is received as POST HTTP requests for applications and as environment variables for jobs.

## Choose a job or application

=== "Choose an application"

    :import{../app/choose.md}

=== "Choose a job"

    :import{../job/choose.md}

## Create a subcription

=== "Create a cron subcription"

    After your app is ready, create a subscription to the cron event producer and connect it to your app.

    The following example creates a cron subscription that is called cron-sub and specifies the cron-app application as its destination. The subscription uses the --data option to include a JSON string in the cron event. It also specifies the cron schedule by using the --schedule option with a value of * * * * * to send an event every minute of every day to the cron-app application.

    ```shell
    ---
    validate: ibmcloud ce sub cron list | grep cron-sub-${uuid}
    ---
    ibmcloud ce sub cron create --name cron-sub-${uuid} --destination ${ce_resource} --dt ${ce_resource_type} --data '{"mydata":"hello world"}' --schedule '* * * * *'
    ```