# Introduce a Failure into Front-End

In this lab you will introduce a Java Script error into the front-end. This version will be deployed as version `v2`.

## Step 1: Introduce an error in the front-end service
1. Open the file `server.js` in the master branch of the `front-end` repository and set the property `response-error-probability` to 20: 
    ```js
    ...
    global.acmws['request-latency'] = 0;
    global.acmws['request-latency-catalogue'] = 500; 
    global.acmws['response-error-probability'] = 20;
    ...
    ```

1. Save changes to that file.

1. Commit your changes to your repository and then push it to the remote repository.

    ```console
    $ git add .
    $ git commit -m "Changes in the server component"
    $ git push origin master
    ```

## Step 2: Create a new release
1. We need the new version of the `front-end` service in the `staging` namespace. Therefore, we will create a new release branch in the `front-end` repository using our Jenkins pipeline:

    1. Go to **Jenkins** and **sockshop**.
    1. Click on **create-release-branch** pipeline and **Schedule a build with parameters**.
    1. For the parameter **SERVICE**, enter the name of the service you want to create a release for (**front-end**)

1. After the **create-release-branch** pipeline has finished, we trigger the build pipeline for the `front-end` service and if all goes well, we wait until the new artefacts is deployed to the `staging` namespace.

## Step 3: Deploy the new front-end to production
1. Go to your **Jenkins** and click on **k8s-deploy-production.update**.
1. Click on **Build with Parameters**:
    * SERVICE: *front-end*
    * VERSION: *v2*
1. Hit **Build** and wait until the pipeline shows: *Success*.

---
[Previous Step: Setup Self Healing](../03_Setup_Self_Healing_for_Production) :arrow_backward: :arrow_forward: [Next Step: Simulate Bad Production Build](../05_Simulate_a_Bad_Production_Deployment)

:arrow_up_small: [Back to overview](../)
