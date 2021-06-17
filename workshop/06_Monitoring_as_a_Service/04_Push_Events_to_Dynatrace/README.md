# Push Deployment & Configuration Change Events to Dynatrace

Passing meta-data is one way to enrich the meta-data in Smartscape and the automated PG, PGI and Service detection/tagging. Additionally to meta data, you can also push deployment and configuration changes events to these Dynatrace entities. The Dynatrace Event API provides a way to either push a *Custom Annotation* or a *Custom Deployment Event* to a list of entities that match certain tags. More on the [Dynatrace Event API can be found here](https://www.dynatrace.com/support/help/dynatrace-api/events/how-do-i-push-events-from-3rd-party-systems/).

In this lab you'll learn how to push deployment and configuration events to Dynatrace.

## Step 1: Add additional Step to Carts Pipeline
To push deployment events to Dynatrace, extend the `Jenkinsfile` for `carts` service as follows:
1. Open the `Jenkinsfile` in the `~/repositories/carts` folder (Or edit the file directly on the Gitea carts repository within your Organization). 
1. Add the following **DT Deploy Event** stage after the **Deploy to dev namespace** stage.

    ```groovy
    stage('DT Deploy Event') {
      when {
          expression {
          return env.BRANCH_NAME ==~ 'release/.*' || env.BRANCH_NAME ==~'master'
          }
      }
      steps {
        container("curl") {
          script {
            def status = pushDynatraceDeploymentEvent (
              tagRule : tagMatchRules,
              customProperties : [
                [key: 'Jenkins Build Number', value: "${env.BUILD_ID}"],
                [key: 'Git commit', value: "${env.GIT_COMMIT}"]
              ]
            )
          }
        }
      }
    }
    ```
1. Commit/Push the changes to your Gitea Repository *carts*.

## Step 2: Add additional Step to Staging Pipeline
Besides, it is necessary to update the staging pipeline to push deployment events for each service that gets deployed to the staging environment.

1. Open the `Jenkinsfile` in the `~/repositories/k8s-deploy-staging/` folder (Or edit the file directly on the Gitea k8s-deploy-staging repository within your Organization).
1. Add the following **DT Deploy Event** stage after the **Deploy to staging namespace** stage:

    ```groovy
    stage('DT Deploy Event') {
      steps {
        container("curl") {
          script {
            tagMatchRules[0].tags[0].value = "${env.APP_NAME}"
            def status = pushDynatraceDeploymentEvent (
              tagRule : tagMatchRules,
              customProperties : [
                [key: 'Jenkins Build Number', value: "${env.BUILD_ID}"],
                [key: 'Git commit', value: "${env.GIT_COMMIT}"]
              ]
            )
          }
        }
      }
    }
    ```
1. Commit/Push the changes to your Gitea Repository *k8s-deploy-staging*.

## Step 3: Verify the pushed Events in Dynatrace

1. Create another release branch for carts and verify it makes it to staging by successfully passing ```k8s-deploy-staging```.
1. Go to **Transaction & services**.
1. Click in **Filtered by** edit field.
1. Enter `environment` and select `dev`.
1. Select the service `carts` and open it.
1. You should now see the deployment event on the right side.

![deployment_events](../assets/deployment_events.png)

---

[Previous Step: Tagging of Services](../03_Tagging_and_Naming_of_Services) :arrow_backward: :arrow_forward: [Next Step: Define Management Zones](../05_Define_Management_Zones)

:arrow_up_small: [Back to overview](../)
