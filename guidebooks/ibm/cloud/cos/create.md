---
imports:
    - ../cli/plugins/ce.md
    - ../ce/project.md
    - ../cli/plugins/cos.md
---

# IBM Cloud Code Engine: Subcribing to cos events

With this tutorial, you can learn how to subscribe to Object Storage events by using the IBM Cloud® Code Engine CLI.

With Code Engine, your applications or jobs can receive events of interest by subscribing to event producers. Code Engine supports two types of event producers: Cron and IBM Cloud Object Storage.

IBM Cloud Object Storage: The Object Storage event producer generates events as changes are made to the objects in your object storage buckets. For example, as objects are added to a bucket, an application can receive an event and then perform an action based on that change, perhaps consuming that new object.

## Determine your Object Storage bucket and region

The Object Storage event producer generates events based on operations on objects in IBM Cloud Object Storage buckets.

=== "Create an Object Storage resource instance"

    For example, create an Object Storage resource that is named mycloud-object-storage that uses the IBM Cloud Lite service plan.

    ```shell
    export resource_name=mycloud-object-storage
    ```

    ```shell
    ibmcloud resource service-instance-create ${resource_name} cloud-object-storage lite global
    
    ibmcloud resource service-instance ${resource_name}
    ```

    ```shell
    export ID=ibmcloud resource service-instance mycloud-object-storage --output JSON | jq -r '.[] | .id'
    ```

### Configure your Object Storage CRN 

=== "Specify an Object Storage instance to work with"

    This examples uses the --force option to force the configuration to use the specified CRN, which might be helpful if you have more than one Object Storage instance.

    ```shell
    ibmcloud cos config crn --crn ${ID} --force
    ```

### Choose existing bucket or create a new bucket to subscribe to

=== "expand(ibmcloud cos buckets --output json | jq -r '.Buckets[].Name')"

    ```shell
    export bucket_name=${choice}
    ```

=== "Create a new bucket to subcribe to"

    ```shell
    ibmcloud cos bucket-create -bucket myBucket
    ```

    ```shell
    export bucket_name=myBucket
    ```

## Assigning the Notifications Manager role to Code Engine

Before you can create an Object Storage subscription, you must assign the Notifications Manager role to a Code Engine project. As a Notifications Manager, Code Engine can view, modify, and delete notifications for an Object Storage bucket.

=== "Assign the Notification Manager role"

    For example, to assign the Notifications Manager role to a project named myproject for an Object Storage instance named mycosinstance

    After you assign the Notifications Manager role to your project, you can then create Object Storage subscriptions for any regional buckets in your Object Storage instance that are in the same region as your project.

    ```shell
    # we need an env variable exported in project.md
    ibmcloud iam authorization-policy-create codeengine cloud-object-storage "Notifications Manager" --source-service-instance-name PROJECT --target-service-instance-name ${resource_name}
    
    ibmcloud iam authorization-policies
    ```

## Choose a job or application

=== "Choose an application"

    :import{../ce/app/choose.md}

=== "Choose a job"

    :import{../ce/job/choose.md}

## Create a subcription

=== "Create a cron subcription"

    After your app is ready, create a subscription to the cron event producer and connect it to your app.

    The following example creates a cron subscription that is called cron-sub and specifies the cron-app application as its destination. 

    ```shell
    ---
    validate: ibmcloud ce sub cron list | grep cron-sub-${uuid}
    ---
    ibmcloud ce sub cron create --name cron-sub-${uuid} --bucket ${bucket_name} --event-type all
    ```