# Instrument Kubernetes Cluster with Dynatrace OneAgent Operator

## Step 1: Define the Cluster Role Binding
1. Get the current cluster user.
    ```
    (bastion$) gcloud config get-value account
    ```

1. Set the *Cluster Role Binding* for your User on *Cluster Admin*.
    ```
    (bastion$) kubectl create clusterrolebinding dynatrace-cluster-admin-binding --clusterrole=cluster-admin --user=<your cluster user>
    ```

## Step 2: Get Dynatrace API URL, API Token, and PaaS Token

1. Get/Set Dynatrace PaaS Token.
    1. Login to Dynatrace.
    1. Go to **Deploy Dynatrace**, **Set up PaaS integration** and click on **Generate new token**.
    1. Specify a name of the token (e.g. *k8s_workshop*) and click on **Generate**.
    1. **Copy** the token to the clipboard. 
    1. Finally, set the PaaS Token as environment variable:
        ```
        (bastion$) export PAAS_TOKEN=<DT_PaaS_Token>
        ```

1. Get/Set Dynatrace API Token
    1. Go to **Settings**, **Integration** and click on **Dynatrace API**.
    1. Click on **Generate token**, specify a name of the token (e.g. *k8s_operator_token*) and click on **Generate**.
    1. Open the API Token and **Copy** the token to the clipboard. 
    1. Finally, set the API Token as environment variable:
        ```
        (bastion$) export API_TOKEN=<DT_API_Token>
        ```
    (Screenshots show how to get the Dynatrace API Token:)

![generate-api-token](../assets/api_token.png)

## Step 3. Rollout Dynatrace OneAgent Operator
1. Create namespace for Dynatrace Operator
    ```
    (bastion$) kubectl create namespace dynatrace
    ```
    
1. Create the Dynatrace Operator.
    ```
    (bastion$) export LATEST_RELEASE=$(curl -s https://api.github.com/repos/dynatrace/dynatrace-oneagent-operator/releases/latest | grep tag_name | cut -d '"' -f 4)
    (bastion$) kubectl create -f https://raw.githubusercontent.com/Dynatrace/dynatrace-oneagent-operator/$LATEST_RELEASE/deploy/kubernetes.yaml
    ```

1. Define Kubernetes Secret to hold Dynatrace API and PaaS Token.
    ```
    (bastion$) kubectl -n dynatrace create secret generic oneagent --from-literal="apiToken=${API_TOKEN}" --from-literal="paasToken=${PAAS_TOKEN}"
    ```

1. Check configuration in `oneagent.yml` and set `HOST_GROUP` parameter to assign hosts to a group.
    ```
      - HOST_GROUP=k8s_cluster_sockshop
    ```

    See the final configuration and make sure to change the `ENVIRONMENT` to your actual tenant url:
    - For SaaS: abc123456.live.dynatrace.com
    - For Managed: mydomain/e/1234567890123456789
    ```
    apiVersion: dynatrace.com/v1alpha1
    kind: OneAgent
    metadata:
      name: oneagent
      namespace: dynatrace
    spec:
      apiUrl: https://ENVIRONMENT/api
      skipCertCheck: false
      tokens: ""
      nodeSelector: {}
      tolerations: []
      image: ""
      args:
      - APP_LOG_CONTENT_ACCESS=1
      - HOST_GROUP=k8s_cluster_sockshop
      env:
      - name: ONEAGENT_ENABLE_VOLUME_STORAGE
        value: "true"
    ```

1. Create Custom Resource for Dynatrace OneAgent
    ```
    (bastion$) kubectl create -f oneagent.yml
    ```

## Step 4. Verifiy OneAgent in Dynatrace
1. Inside Dynatrace navigate to the Hosts screen. After a couple of minutes the kubernetes cluster nodes should appear.
1. **After** the hosts appeared in Dynatrace, restart all pods to get method-level insight into your services
    ```
    (bastion$) kubectl delete pods --all -n dev
    (bastion$) kubectl delete pods --all -n staging
    (bastion$) kubectl delete pods --all -n production
    ```

## Step 5. Execute some load on Sockshop
1. Open the *front-end* URL of your Sockshop in the `dev` namespace and click through the application. To get the IP address execute the following command:
    ```
    (bastion$) kubectl -n dev get svc front-end  
    ```

## Step 6. Explore automated Monitoring Result in Dynatrace

Here are a couple of things that happened *automagically* due to the installation of Dynatrace OneAgent Operator.

1. View Properties and Tags of Hosts in your Cluster.

1. View Process Groups for each application.

    If you run multiple process or docker instances of the same process or container image, Dynatrace will group them all into a single **Process Group Instance (PGI)**. In this case that means that we will see **one** PGI for front-end, **one** for carts, **one** for users, etc. The fact that you have multiple instances of the same container on the same host doesn't give you individual PGIs. That is the default behavior. You have ways to change that behavior through Process Group Detection rules or by using some of the *DT_* environment variables, as shown in a next lab.

---

:arrow_forward: [Next Step: Pass and Extract Meta-Data for Process or Container](../02_Pass_Extract_Meta-Data_for_Process_or_Container)

:arrow_up_small: [Back to overview](../)
