# Unbreakable Delivery Pipeline

The overall goal of the *Unbreakable Delivery Pipeline* is to implement a pipeline that prevents bad code changes from impacting your real end users. Therefore, it relies on three concepts known as Shift-Left, Shift-Right, and Self-Healing:

* **Shift-Left**: Ability to pull data for specific entities (processes, services, applications) through an Automation API and feed it into the tools that are used to decide on whether to stop the pipeline or keep it running.

* **Shift-Right**: Ability to push deployment information and meta data to your monitoring environment, e.g: differentiate BLUE vs GREEN deployments, push build or revision number of deployment, notify about configuration changes.

* **Self-Healing**: Ability for smart auto-remediation that addresses the root cause of a problem and not the symptom 

In this module you will learn how to implement such an *Unbreakable Delivery Pipeline* with Dynatrace and Ansible Tower by following these four labs:
* Harden Staging Pipeline with Quality Gate: [Lab](./01_Harden_Staging_Pipeline_with_Quality_Gate)
* Simulate Early Pipeline Break: [Lab](./02_Simulate_Early_Pipeline_Break)
* Setup Self-Healing for Production: [Lab](./03_Setup_Self_Healing_for_Production)
* Simulate a Bad Production Deployment: [Lab](./04_Simulate_a_Bad_Production_Deployment)

# Prerequisites

* Before starting with this module, please complete the following modules:
    * Building Environment zero
    * Developing Microservices
    * Monitoring as a Service
    * Performance as a Self-Service
    * Blue-green and Canary Deployment
    * Runbook Automation and Self-Healing

* Access to *Bastion host*


