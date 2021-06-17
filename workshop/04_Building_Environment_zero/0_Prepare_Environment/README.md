# Prepare Environment

## Pre-requisites
* Access to your bastion host


## Steps

1. Connect to the bastion host ussing ssh and your credentials.

1. Execute the `installCertManager.sh` script in your home directory.

    ```
    (bastion)$ cd ~
    (bastion)$ ./installCertManager.sh
    ```

    This script will install the certificate manager that will supply SSL certificates to all the components that we spin up in the course of this and upcoming labs. 

    ```
    (bastion)$ ./installCertManager.sh
    "jetstack" has been added to your repositories
    customresourcedefinition.apiextensions.k8s.io/certificaterequests.cert-manager.io created
    customresourcedefinition.apiextensions.k8s.io/certificates.cert-manager.io created
    customresourcedefinition.apiextensions.k8s.io/challenges.acme.cert-manager.io created
    customresourcedefinition.apiextensions.k8s.io/clusterissuers.cert-manager.io created
    customresourcedefinition.apiextensions.k8s.io/issuers.cert-manager.io created
    customresourcedefinition.apiextensions.k8s.io/orders.acme.cert-manager.io created
    Deploying cert-manager using Helm... This will take a few minutes
    namespace/cert-manager created
    Waiting for deployment "cert-manager-webhook" rollout to finish: 0 of 1 updated replicas are available...
    deployment "cert-manager-webhook" successfully rolled out
    clusterissuer.cert-manager.io/letsencrypt-staging created
    clusterissuer.cert-manager.io/letsencrypt-prod created
    ```

1. Execute the `installIngress.sh` script in your home directory

    ```
    (bastion)$ cd ~
    (bastion)$ ./installIngress.sh
    ```
    This script deploys the ingress controller, a kubernetes component that will allow external access to the kubernetes resources we will be deploying in this and following labs.

    ```
    (bastion)$ ./installIngress.sh
    clusterrolebinding.rbac.authorization.k8s.io/cluster-admin-binding created
    namespace/ingress-nginx created
    Deploying nginx ingress controller using Helm... This will take a few minutes
    "ingress-nginx" has been added to your repositories

    Waiting for the Ingress service to have a public IP before continuing...
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    waiting for the ingress load balancer service public IP address
    Ingress domain: XXX.XXX.XXX.XXX.nip.io
    ```
---

:arrow_forward: [Next Step: Deploy Docker Registry](../1_Deploy_Docker_Registry)

:arrow_up_small: [Back to overview](../)
