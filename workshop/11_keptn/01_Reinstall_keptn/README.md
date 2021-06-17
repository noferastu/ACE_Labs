# Reinstall Keptn

In this lab you'll configure keptn to expand the quality gates capabilities and use it for continuous delivery.

## Step 1: Configure Keptn for continuous delivery

1. Reinstall keptn with the continuous delivery capabilities enabled and to change how we expose keptn:

   ```bash
    (bastion)$ keptn install --endpoint-service-type=ClusterIP --use-case=continuous-delivery
    ```

1. After running the install command, press `y` on your keyboard to confirm the cluster details and to override the current keptn installation. Expected output:

```bash
Helm Chart used for Keptn installation: https://storage.googleapis.com/keptn-installer/keptn-0.x.x.tgz

Please confirm that the provided cluster information is correct:
Cluster: <your_cluster_name>
Is this all correct? (y/n)
y
Using a file-based storage for the key because the password-store seems to be not set up.
Installing Keptn ...
Existing Keptn installation found in namespace keptn

Do you want to overwrite this installation? (y/n)
y
Start upgrading Helm Chart keptn in namespace keptn
Finished upgrading Helm Chart keptn in namespace keptn
Keptn has been successfully set up on your cluster.
---------------------------------------------------
* To quickly access Keptn, you can use a port-forward and then authenticate your Keptn CLI (in a Linux shell):
 - kubectl -n keptn port-forward service/api-gateway-nginx 8080:80
 - keptn auth --endpoint=http://localhost:8080/api --api-token=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)

* To expose Keptn on a public endpoint, please continue with the installation guidelines provided at:
 - https://keptn.sh/docs/0.x.x/operate/install#install-keptn
```

---

[Previous Step: Preparation](../00_Preparation):arrow_backward: :arrow_forward: [Next Step: Configure Istio](../02_Configure_Istio)

:arrow_up_small: [Back to overview](../)
