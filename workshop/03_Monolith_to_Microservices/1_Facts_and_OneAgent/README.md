# Gathering Facts and Installing the OneAgent operator

During this section we will gather all the information that we will lateron use during the labs. We will run a script that places all this information in a credentials file which other scripts can then pick up

## Data needed

* Credentials for `bastion host`
* Access to a `Dynatrace Tenant`.
* A `Dynatrace API token`. More information can be found [here](dynatrace_api_token.md)
* A `Dynatrace PAAS token`.

## Step 1 - Gathering Facts

1. After you have gathered all the information that you need, execute the following command on your bastion host from your home directory:

    ```bash
    (bastion)$ cd ~
    (bastion)$ ./defineCredentials.sh
    ```

1. This will ask you for the following information:
    * Dynatrace Tenant (both without https)
        - For SaaS: abc123456.live.dynatrace.com
        - For Managed: mydomain/e/1234567890123456789
    * Dynatrace API Token
    * Dynatrace PaaS Token

1. Ensure that the `creds.json` has been updated to the correct values:

   ```bash
   (bastion)$ cat creds.json
   {
       "jenkinsUser": "admin",
       "jenkinsPassword": "JENKINS_PASSWORD_PLACEHOLDER",
       "docsOrg": "kristofre",
       "docsRepo": "acl-docs",
       "docsBranch": "master",
       "dynatraceTenant": "<YOUR ACTUAL TENANT>.live.dynatrace.com",
       "dynatraceApiToken": "<YOUR ACTUAL TOKEN>",
       "dynatracePaasToken": "<YOUR ACTUAL TOKEN>",
       "githubUserName": "dynatrace",
       "githubPersonalAccessToken": "PERSONAL_ACCESS_TOKEN_PLACEHOLDER",
       "githubUserEmail": "ace@dynatrace.com",
       "githubOrg": "sockshop"
   } 
   ```

## Step 2 - Deploying the OneAgent operator

Dynatrace can be a great help in rearchitecting a monolithic application to a microservices one. It will give you insights on how many calls are being made to this potential new microservice, which is imperative in microservices design as the overhead of communication might be a deal breaker.

We will cover the intristics of the OneAgent operator in a future section and at this point we will focus only on getting the OneAgent installed.

For that we have provided a OneAgent operator installation script which will perform all the necesary steps for you.

On your bastion, execute the following:

```bash
(bastion)$ cd ~
(bastion)$ ./deployOneAgentOperator.sh
```

This script will take information you have entered in the previous step and use it to automatically deploy the OneAgent. Automation at its finest!

For more information about installing the OneAgent operator visit this [page.](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/monitor-kubernetes-environments/)

---

[Previous Step: Check Prerequisites](../0_Check_Prerequisites) :arrow_backward: :arrow_forward: [Next Step: Lift and shift Ticket Monster](../2_Lift-and-Shift_TicketMonster)

:arrow_up_small: [Back to overview](../)
