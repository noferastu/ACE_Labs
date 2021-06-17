# Blue/green & Canary Deployment, Production Deployment

This session gives an overview of production deployments, deployment strategies, and showcases those using Istio on Kubernetes to canary-deploy a new front-end version.

## Troubleshooting and useful links
- [`kubectl` Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- If at any time Dynatrace doesn't show service metrics anymore after applying a new `VirtualService` configuration please try restarting the `istio-pilot-xxx` pod in the `istio-system` namespace. Unfortunately, we weren't able to consistently reproduce this issue that occurs from time to time, but it seems as Istio is dropping the `ServiceEntry` configuration for the Dynatrace OneAgent at some point in time for no obvious reason.
- If production is not showing properly in Dynatrace, please run this command to allow communication to the active gate:
```kubectl delete meshpolicies.authentication.istio.io default```
- If you have lost connection to kubectl, please run this command to re-auth with your cluster:
```gcloud container clusters get-credentials acllab<#> --zone=us-central1-a```
