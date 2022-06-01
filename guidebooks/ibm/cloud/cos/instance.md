---
imports:
    - ../../../util/jq.md
    - ../target.md
    - ../cli/plugins/cos.md
---

# Select an IBM Cloud Object Storage Instance

=== "Create a Cloud Object Storage Instance"
    You may create a new Object Storage instance with either the Lite plan, which is free for low-usage situations, or with the Standard plan.

    ## Choose a Plan

    ```shell
    export S3_SERVICE=madcos-${uuid}
    ```

    === "Lite"
        Storage up to 25 GB/month
        Up to 2,000 Class A (PUT, COPY, POST, and LIST) requests per month
        Up to 20,000 Class B (GET and all others) requests per month
        Up to 10 GB/month of Data Retrieval
        Up to 5GB of egress (Public Outbound)
        Applies to aggregate total across all storage bucket classes

        ```shell
        ibmcloud resource service-instance-create ${S3_SERVICE} cloud-object-storage Lite global
        ```

    === "Standard"
        There is no minimum fee, so you pay only for what you use.

        ```shell
        ibmcloud resource service-instance-create ${S3_SERVICE} cloud-object-storage Standard global
        ```


=== "expand(ibmcloud resource service-instances  --output json | jq -r '.[] | select(.crn|test(\"cloud-object-storage\")) | .name')"
    ```shell
    ibmcloud cos config crn --crn $(ibmcloud resource service-instances  --output json | jq -r '.[] | select(.name|test("${choice}")) | .crn')
    ```
    
    ```shell
    export S3_SERVICE=${choice}
    ```

## S3 Endpoints

Access your data via this HTTP endpoint.

```shell
export S3_ENDPOINT="https://s3.${IBM_CLOUD_REGION}.cloud-object-storage.appdomain.cloud."
```

For intra-cloud data fetches, you can use the lower-cost "direct" endpoint.

```shell
export S3_DIRECT_ENDPOINT="https://s3.direct.${IBM_CLOUD_REGION}.cloud-object-storage.appdomain.cloud."
```

--8<-- "_auth.md"
