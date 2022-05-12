# Set up Authorization for your IBM Cloud Object Storage Instance

## Choose a Service Key

=== "expand(ibmcloud resource service-keys --output json | jq -r '.[] | select((.crn|test(\"cloud-object-storage\")) and (.credentials|.cos_hmac_keys)) | .name')"
    ```shell
    ibmcloud cos config auth --method HMAC
    ```
    
    ```shell
    export COS_HMAC_ACCESS_KEY_ID=$(ibmcloud resource service-keys --output json | jq -r '.[] | select(.name = "${choice}") | .credentials.cos_hmac_keys.access_key_id')
    export COS_HMAC_SECRET_ACCESS_KEY=$(ibmcloud resource service-keys --output json | jq -r '.[] | select(.name = "${choice}") | .credentials.cos_hmac_keys.secret_access_key')
    cat ~/.bluemix/plugins/cloud-object-storage/config.json | jq ".AccessKeyID = \"${COS_HMAC_ACCESS_KEY_ID}\" | .SecretAccessKey = \"${COS_HMAC_SECRET_ACCESS_KEY}\"" > /tmp/config.json
    cp ~/.bluemix/plugins/cloud-object-storage/config.json ~/.bluemix/plugins/cloud-object-storage/config.json.bak && mv /tmp/config.json ~/.bluemix/plugins/cloud-object-storage/config.json
    ```
