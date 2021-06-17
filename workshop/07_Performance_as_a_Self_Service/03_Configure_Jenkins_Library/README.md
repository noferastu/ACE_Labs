# Configure Keptn library for Jenkins

In this lab you'll learn how to configure the Keptn library for Jenkins.
![keptn](./assets/evalpipeline_animated.gif)

## Step 1: Review Keptn library installation

Following the `everything as code` best practice, we will update the Jenkins deployment using Helm.

1. On the bastion and run the commands below to add the required libraries to the Jenkins deployment:

    ```bash
    (bastion)$ cd
    (bastion)$ rm ~/jenkins/helm/jenkins-values.yml && mv ~/jenkins/helm/jenkins-values-keptn.yml ~/jenkins/helm/jenkins-values.yml
    ```

1. The following code block was added to the Jenkins values file.

    ```yaml
            - defaultVersion: "master"
              name: "keptn-library"
              retriever:
                modernSCM:
                  scm:
                    git:
                      remote: "https://github.com/keptn-sandbox/keptn-jenkins-library.git"
                      traits:
                      - "gitBranchDiscovery"
    ```

1. After adding the keptn Jenkins libraries, the Jenkins global libraries code block looks like this:

    ```yaml
          globalLibraries:
            libraries:
            - name: "dynatrace"
              retriever:
                modernSCM:
                  scm:
                    git:
                      id: "6813bac3-894e-434d-9abb-bd41eeb72f88"
                      remote: "https://github.com/dynatrace-ace/dynatrace-jenkins-library.git"
                      traits:
                      - "gitBranchDiscovery"
            - defaultVersion: "master"
              name: "keptn-library"
              retriever:
                modernSCM:
                  scm:
                    git:
                      remote: "https://github.com/keptn-sandbox/keptn-jenkins-library.git"
                      traits:
                      - "gitBranchDiscovery"
    ```

1. Apply the new configurations to Jenkins via helm by executing the script below:

    ```bash
    (bastion)$ cd
    (bastion)$ ./deployJenkins.sh
    ```

1. Go into Jenkins and review the [keptn library](https://github.com/keptn-sandbox/keptn-jenkins-library.git) installation `Jenkins > Manage Jenkins > Configure System > Global Pipeline Libraries`.
![keptn](./assets/keptn-jenkins-library1.png)

## Step 2: Get Keptn credentials

Retrieve the Keptn credentials using the following

```bash
(bastion)$ export KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
(bastion)$ echo $KEPTN_API_TOKEN
(bastion)$ export KEPTN_BRIDGE=http://$(kubectl -n keptn get ingress keptn -ojsonpath='{.spec.rules[0].host}')/bridge
(bastion)$ echo $KEPTN_BRIDGE
(bastion)$ export KEPTN_ENDPOINT=http://$(kubectl -n keptn get ingress keptn -ojsonpath='{.spec.rules[0].host}')/api
(bastion)$ echo $KEPTN_ENDPOINT
```

## Step 3: Store Keptn credentials in Jenkins

Inside Jenkins go into `Manage Jenkins > Manage credentials ` and select the first element with the house icon.
![keptn](./assets/jenkins-store.png)

Then click `Global credentials > Add credentials`, use the dropdown Kind and select `secret text` and input the values from step 2. Repeat the process for each variable. For the ID field use the name from the images.

#### Keptn API Token Crdential

![keptn](./assets/keptn-api-credential.png)

#### Keptn Bridge Credential

![keptn](./assets/keptn-bridge-credential.png)

#### Keptn Endpoint Credential

![keptn](./assets/keptn-endpoint-credential.png)

[Previous Step: Configure Keptn & Dynatrace integration](../02_Configure_Keptn_Dynatrace_Integration) :arrow_backward: :arrow_forward: [Next Step: Define Request Attributes](../04_Define_Request_Attributes)

:arrow_up_small: [Back to overview](../)
