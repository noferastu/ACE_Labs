# Define Management Zones in Dynatrace to create Access Control

[Management Zones](https://www.dynatrace.com/news/blog/grant-fine-grained-access-rights-using-management-zones-beta/) allow you to define who is going to see and who has access to what type of Full-stack data. There are many ways to slice your environment and it will depend on your organizational structure and processes.
This lab assumes that there are following teams:

* Frontend Team responsible for FRONTEND services
* Dev Team responsible for the whole Development Environment
* Architecture Team responsible for Development & Staging
* Operations Team responsible for all Infrastructure (=all Hosts)
* Business Team responsible for all applications

Based on this assumption, you will learn how to create Management Zones that will give each team access to the data they are supposed to see. 

## Step 1: Create Management Zone for Frontend Team

1. Go to **Settings**, **Preferences**, **Management zones**, and click on **Add new management zone**.
1. Set the name of the management zone: `Frontend Services`.
1. Click on **Add new rule**:
    * Rule applies to: `Services` 
    * Condition on `SERVICE_TYPE` equals `FRONTEND`
1. Select **Apply to underlying process groups of matching services**.
1. **Save** and test the Management Zone in the Smartscape View.

## Step 2: Create Management Zone for Dev Team

1. Go to **Settings**, **Preferences**, **Management zones**, and click on **Add new management zone**.
1. Set the name of the management zone: `Dev Team`.
1. Click on **Add new rule**:
    * Rule applies to: `Services` 
    * Condition on `Kubernetes namespace` equals `dev`
1. Select **Apply to underlying process groups of matching services**.
1. Click on **Preview**
1. Click on **Create Rule** and **Save changes**
1. Test the Management Zone in the Smartscape View.

## Step 3: Create Management Zone for Architect Team

1. Go to **Settings**, **Preferences**, **Management zones**, and click on **Add new management zone**.
1. Set the name of the management zone: `Architect Team`.
1. Click on **Add new rule**:
    * Rule applies to: `Services` 
    * Condition on `Kubernetes namespace` equals `dev`
1. Select **Apply to underlying process groups of matching services**.
1. Click on **Preview**
1. Click on **Create Rule**
1. Click on **Add new rule**:
    * Rule applies to: `Services`
    * Condition on `Kubernete namespaces` equals `staging`
1. Select **Apply to underlying process groups of matching services**.
1. Click on **Preview**
1. Click on **Create Rule** and **Save changes**
1. Test the Management Zone in the Smartscape View.

## Step 4: (Optional) Create Management Zone for Operations Team

Create a Management Zone for all HOSTS & Processes.

## Step 5: (optional) Create Management Zone for Business Team

Create a Management Zone that covers all Web Applications.

---

[Previous Step: Push Events to Dynatrace](../04_Push_Events_to_Dynatrace) :arrow_backward: :arrow_forward: [Next Step: Deploy Sockshop to Staging](../06_Deploy_Sockshop_to_Staging)

:arrow_up_small: [Back to overview](../)
