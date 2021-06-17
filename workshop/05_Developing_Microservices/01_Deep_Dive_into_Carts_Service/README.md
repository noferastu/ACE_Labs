# Deep Dive into the Microservice Carts

In this lab you'll first investigate the code structure of a microservice including all artifacts that are needed to build, containerize, and to deploy a service. Based on a solid understanding of the microservice, you will deploy it to a Kubernetes cluster to see the service in action.

## Step 1: Familiarize with Microservice from a Code Perspective

1. The source code of carts is in `carts/src/`.
    * `main` - Contains the Java sources and the Application properties.
    * `test` - Contains all unit tests to test the application logic.

1. The `carts/pom.xml` file is used from Maven to build the Java artifact based on all dependencies.

1. The `carts/version` file holds the current version of the microservice.

1. The `carts/Dockerfile` specifies the *Container Image* to run the microservice in a container.

1. The `carts/Jenkinsfile` specifies the *Jenkins Pipeline* to build, test, deploy the microservice on a Kubernetes Cluster.

## Step 2. Familiarize with the Deployment and Service Specification

1. Open the file `carts/manifest/carts.yml`.

1. Consider the **Deployment** section.
    * Identify the **Container Image** definition.
    * Identify the **Resource** definition.
    * Identify the **Liveness and Readiness Probe** definition.

1. Consider the **Service** section.
    * Identify the **Port** definition.

## Step 3. Deploy Carts on Kubernetes Cluster

1. Login to the bastion.

1. On the bastion, go to the carts directory and copy the `manifest` folder and name it `lab-manifest`.

    ```bash
    (bastion)$ cd ~/repositories/carts/
    (bastion)$ cp -R manifest/ lab-manifest/
    (bastion)$ cd lab-manifest
    ```

1. Open `carts.yml` inside the `lab-manifest` directory  and change namespace from `dev` to `lab-dev` (1x in deployment and 1x in service specification).

    * Update the namespace on the deployment specification to lab-dev on top of `carts.yml`.

        ```bash
        ---
        apiVersion: extensions/v1beta1
        kind: Deployment
        metadata:
            name: carts
            namespace: lab-dev
        ```

    * Update the namespace to lab-dev on the service specification (on the bottom) and save file.

        ```bash
        ---
        apiVersion: v1
        kind: Service
        metadata:
            name: carts
            labels:
                app: carts
            namespace: lab-dev
        ```

1. Verify the container image at spec > containers > image.

    ```bash
    image: dynatracesockshop/carts:0.6.0
    ```

1. Create the `lab-dev` namespace.

    ```bash
    (bastion)$ kubectl create ns lab-dev
    ```

1. Run kubectl apply command

    ```bash
    (bastion)$ cd
    (bastion)$ kubectl apply -f ~/repositories/carts/lab-manifest
    ```

1. Check that all ressources that have been created.

    ```bash
    (bastion)$ kubectl get deployments,pods,services -n lab-dev
    ```

1. Retrieve the external IP of your carts service and open it in a browser by adding the `/health` endpoint.

1. Delete all resources that have been created.

    ```bash
    (bastion)$ kubectl delete namespace lab-dev
    ```

1. Delete `lab-manifest` folder.

    ```bash
    (bastion)$ rm -rf ~/repositories/carts/lab-manifest
    ```

---

:arrow_forward: [Next Step: Deploy Microservice to Dev](../02_Deploy_Microservice_to_Dev)

:arrow_up_small: [Back to overview](../)