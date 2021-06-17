# Install Istio

In this lab we install all Istio components and verify that they're running in the k8s cluster.

## Data needed
* Credentials for `bastion host`

## Auto Installation
Istio's Pilot service is responsible for allow outgoing connections to for example the Dynatrace Tenant (for OneAgent traffic in Production) and also external data services for Sockshop.

## Step 1 - Auto Install Istio via script

1. To install Istio execute the following on the bastion host
    ```bash
    (bastion)$ cd
    (bastion)$ istioctl install --set profile=demo
    ```
1. This will perform the following steps:
    - Request the Cluster CIDR and Services CIDR blocks
    - Add those blocks into the outbound IP ranges
    - Install Istio's Custom Resource Definitions (CRDs)
    - Deploy Istio components

## Step 2 -  Configure Istio Components

In this step, we'll enable Istio's automatic sidecar injection for one k8s namespace, we create and configure mandatory Istio components, and allow mesh external traffic to leave the service mesh.

## Data needed
* Dynatrace environment URL
* PaaS Token

1. Enable Istio-Sidecar-injection, that will automatically inject Envoy container into application pods that are running in a namespace that is labeled with `istio-injection=enabled`

    ```bash
    (bastion)$ kubectl label namespace production istio-injection=enabled
    ```

    Ensure that the label `istio-injection` has only been applied to the production namespace.

    ```bash
    (bastion)$ kubectl get namespace -L istio-injection
    NAME           STATUS    AGE       ISTIO-INJECTION
    cicd           Active    10d
    default        Active    16d
    dev            Active    10d
    dynatrace      Active    3d
    istio-system   Active    9d        disabled
    kube-public    Active    16d
    kube-system    Active    16d
    production     Active    9d        enabled
    staging        Active    10d
    ```

1. Istio requires a `Gateway`, that is a load balancer at the edge of the mesh receiving incoming HTTP and TCP connections.

    ```bash
    (bastion)$ kubectl apply -f repositories/k8s-deploy-production/istio/gateway.yml
    ```

    `gateway.yml`:
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: Gateway
    metadata:
    name: sockshop-gateway
    spec:
    selector:
        istio: ingressgateway
    servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
        hosts:
        - "*"
    ```

1. You can see the external IP address of your `Gateway` executing this command.

    ```
    (bastion)$ kubectl get svc istio-ingressgateway -n istio-system
    NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                      AGE
    istio-ingressgateway   LoadBalancer   172.21.109.129   1xx.2xx.10.12x  80:31380/TCP,443:31390/TCP,31400:31400/TCP   17h
    ```

1. A `VirtualService` can be bound to a `Gateway` to control the forwarding of traffic.

    ```bash
    (bastion)$ kubectl apply -f repositories/k8s-deploy-production/istio/virtual_service.yml
    ```

    `virtual_service.yml`:
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: VirtualService
    metadata:
    name: sockshop
    spec:
    hosts:
    - "*"
    gateways:
    - sockshop-gateway
    http:
    - route:
        - destination:
            host: front-end.production.svc.cluster.local
            subset: v1
    ```

1. At a later point in time, we'll have two different versions of the `front-end` service deployed. To prepare for this situation, we'll define `DestinationRule`s for both versions. A `DestinationRule` defines policies that apply to traffic intended for a service after a routing has occured.

    ```bash
    (bastion)$ kubectl apply -f repositories/k8s-deploy-production/istio/destination_rule.yml
    ```

    `destination_rule.yml`:
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: DestinationRule
    metadata:
    name: front-end-destination
    spec:
    host: front-end.production.svc.cluster.local
    subsets:
    - name: v1
        labels:
        version: v1
    - name: v2
        labels:
        version: v2
    ```

---
[Next Step: Deploy to Production](../2_Deploy_to_production):arrow_forward:

:arrow_up_small: [Back to overview](../)