# Monitoring as a Service

In this module you will learn how to rollout Dynatrace Full-stack monitoring across your infrastructure. Full-stack monitoring means that every host, app, and service that gets deployed will automatically - without any additional configuration - deliver key metrics and meta-data for the individual stakeholders: dev, architects, operations, and business.

To achieve that goal, you will learn how to:
* Rollout Dynatrace OneAgent on a Kubernetes Cluster: [Lab](./01_Instrument_Cluster_with_Dynatrace_OneAgent)
* Pass additional meta-data to your hosts and processes: [Lab](./02_Pass_Extract_Meta-Data_for_Process_or_Container)
* Ensure proper PG (process group), PGI (process group instance) and service detection via detection rules: [Lab](./03_Tagging_and_Naming_of_Services)
* Push additional deployment & configuration change event details to Dynatrace to enrich the AI's data set: [Lab](./04_Push_Events_to_Dynatrace)
* Create Management Zones to make data easily available for the different groups: dev, test, operations, business: [Lab](./05_Define_Management_Zones)
* Set up notification integrations: [Lab](./07_Setup_Notification_Integration)

For further information on how to organize monitored entities, it is recommended to read: [Best practices on organize monitored entities](https://www.dynatrace.com/support/help/organize-monitored-entities/).

# Prerequisites

* Before starting with this module, please complete the following modules:
    * Building Environment zero
    * Developing Microservices
    * Access to the *Bastion host*


