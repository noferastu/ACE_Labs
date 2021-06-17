# Istio traffic routing

In this lab, we'll configure traffic routing in Istio to redirect traffic based on different criteria to the version 2 of the `front-end`. We'll cover how to redirect traffic using weight rules, redirecting only logged in users to the version 2, and redirecting only Chrome users to version 2.

## Steps
1. Right now, traffic to `front-end` is only routed to the version 1, because we've configured the `VirtualService` to do exactly that. The `subset: v1` entry in the configuration takes care of that.

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

1. To see if the new version works properly we only want 50% of the traffic to be redirected to that version initially. To that end, we will apply the `virtual_service_canary.yml` in the `k8s-deploy-production` repository.

    ```bash
    (bastion)$ cd
    (bastion)$ cd ~/repositories/k8s-deploy-production/istio
    (bastion)$ vi virtual_service_canary.yml
    ```

    The file should look like this:

    **!!! YOU MUST NOT DELETE THE COMMENTS #v1 AND #v2 - WE NEED THOSE LATER ON !!!**
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
        - match:
            - uri:
                prefix: "/carts"
            route:
            - destination:
                host: carts.production.svc.cluster.local
        - route:
            - destination:
                host: front-end.production.svc.cluster.local
                subset: v1
            weight: 50 #v1
            - destination:
                host: front-end.production.svc.cluster.local
                subset: v2
            weight: 50 #v2
    ```

    This configuration redirects 50% of all traffic hitting the sockshop `VirtualService` to version 2. Let's take a look how that looks in Dynatrace.

1. To apply the configuration change, execute the following command:
    ```bash
    (bastion)$ kubectl apply -f virtual_service_canary.yml
    ```
    
1. Run the `kubectl get svc istio-ingressgateway -n istio-system` command to get the *EXTERNAL-IP* of your *Gateway*.

    ```bash
    (bastion)$ kubectl get svc istio-ingressgateway -n istio-system
    NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                                      AGE
    istio-ingressgateway   LoadBalancer   172.21.109.129   1**.2**.1**.1**  80:31380/TCP,443:31390/TCP,31400:31400/TCP   17h
    ```
    
1. Now use a browser to acess this gateway to genereate some traffic and to verify the configuration change.

1. Open Dynatrace and navigate to Transactions&Services and open the `front-end` service screen.

    ![open-frontend-service](../assets/dynatrace-service-2-pgis.png)

    You see, that there are two service instances to the `front-end` service, i.e. the two different deployments we've done earlier, as you can see in the brackets of the processes (front-end-v1-... and front-end-v2-...). Dynatrace is aware of the two versions.

1. Let's create a chart in Dynatrace that shows the traffic distribution between two service versions. To that end, click on the "Create chart" button in the "Multidimensional analysis views" section on the service screen. In the next screen select the metric `Request count`. In the `Split by dimension` field, remove the current dimension and select `{Service:Instance}`. Under `View chart as:`, select `Bar` and which will result in a graph similar to below:

    ![chart-select-metric](../assets/chart-select-metric.png)

1. An additional step we can take is filtering out the health check requests to give us a more accurate view of incoming user requests. In the `Filter requests:` field, select `Requests` and then enter `/` (index).

    ![chart-add-filter](../assets/chart-add-filter.png)

1. Finally, click the "Save to Service" button :one: in the upper right corner, so you can easily access this chart form the service overview from now on.

1. You can now change the weight distribution of version 1 and 2 to arbitrary values and see it reflect in the chart you've just created.

1. (Optional) You can decide traffic routing also based on information that is included in the HTTP header. For example, you can present version 2 only to users that are logged in. See the following configuration that enables that.

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
    - match:
        - headers:
            cookie:
            regex: ".*logged_in.*"
        route:
        - destination:
            host: front-end.production.svc.cluster.local
            subset: v2
    - route:
        - destination:
            host: front-end.production.svc.cluster.local
            subset: v1
    ```

    Istio checks if the cookie field of the HTTP header contains the string `logged_in` using regular expressions. This, of course, depends on the implementation of your web application and is not univesally appllicable. To set this in action apply the configuration.

    ```
    (bastion)$ kubectl apply -f virtual_service_v2_for_users.yml
    ```

    If you login using either a new registrated user, or a user that you've created before, you should see version 2. After logging out, you should see verison 1 again.

1. (Optional) Another option is to redirect traffic based on the user browser. See the following configuration that enables that.

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
    - match:
        - headers:
            user-agent:
            regex: ".*Chrome.*"
        route:
        - destination:
            host: front-end.production.svc.cluster.local
            subset: v2
    - route:
        - destination:
            host: front-end.production.svc.cluster.local
            subset: v1
    ```

    You can apply the configuration to see its effect.

    ```bash
    (bastion)$ kubectl apply -f virtual_service_v2_for_chrome.yml
    ```

    If you open sockshop using Chrome you should see version 2, with any other version 1 should be displayed.

1. Eventually, trigger the parameterized build pipeline `k8s-deploy-production.canary` in your Jenkins instance and provide 100 for the VERSION1 parameter and 0 for the VERSION2 parameter. This build calls a build pipeline that applies the supplied distribution to the `front-end` service and also sends a change event to Dynatrace.

    ![trigger-k8s-deploy-production-canary](../assets/trigger-k8s-deploy-production-canary.png)

    This, of course, is the preferred way to change the attributes of production deployments. If you change something directly from your command line and don't send a change event, you'll have a hard time figuring out why and what happened when.

---
[Previous Step: Deploy front-end v2](../4_Deploy_front-end_v2) :arrow_backward:

:arrow_up_small: [Back to overview](../)
