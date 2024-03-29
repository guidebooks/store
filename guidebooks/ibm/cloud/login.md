---
barrier: true
validate: ibmcloud target | tail -1 | grep -qv "Not logged in"
imports: 
    - ./cli/ibmcloud.md
---

# IBM Cloud: Log in

This guidebook helps you with securing credentials for use with [IBM
Cloud](https://www.ibm.com/cloud). Select your authentication method.

=== "Single Sign-on/OTP"
    You may use your browser to acquire a one-time password.
    ```shell.stdin
    ibmcloud login --sso
    ```
    
=== "Username and Password"
    Normal accounts can be authenticated using a username and password.
    ```shell.stdin
    ibmcloud login
    ```

=== "Authenticate with apikey"
    If you have a acquired an [IBM Cloud apikey](https://www.ibm.com/docs/en/app-connect/containers_cd?topic=servers-creating-cloud-api-key), you can avoid having to periodically re-authenticate.
    ```shell.stdin
    ibmcloud login --apikey=@~/.config/ibm/apikey
    ```
