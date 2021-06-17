# Runbook Automation / Self Healing

This session gives an overview of how to leverage the power of runbook automation to build self-healing applications. Therefore, we will build on material we have already developed in the course of this workshop but we will also introduce new software that is needed for executing and automating runbooks.
In this session, we will use [Ansible AWX] as the tool for executing and managing the runbooks.

## Use Case

In this module we want to run a promotional campaign in our production environment. The purpose of the campaign is to add a promotional gift (e.g., Halloween/Christmas/Easter themed socks) to a given percentage of user interactions whenever they add an item to their shopping cart. We want to be able to control the amount of users during runtime in our production environment without the need to rollout a new version of the service.

In case we experience problems with our campaign, we want to mechanisms in place, that automatically stop the campaign. 

![gift socks](./assets/gift-socks.png)

## Technical Implementation

The described use case can already be served by the carts service, since this feature is already implemented, but was not used until now.
The `carts` service includes the endpoint `carts/1/items/promotional/` that can take as an input a number between 0 and 100 which corresponds to the percentages of user interactions that will receive the promotional gift. E.g., `carts/1/items/promotional/5` will enable it for 5 %, while `carts/1/items/promotional/100` will enable it for 100 % of user interactions. Therefore, we can easily change the behaviour of our `carts` service at runtime.
However, changing the value without using a configuration management system would not allow us to track when changes happened and which configuration values have changed. Therefore, we are using [Ansible AWX] to execute changes in our configuration.

## Playbooks

There are two playbooks included in this module

1. **campaign.yaml**: This file holds two tasks and is responsible for adjusting the percentage of promotional gifts that will be included in the shopping carts of our users. The first task actually changes the value of the promotional function, while the second task sends a `CUSTOM_CONFIGURATION` change to the Dynatrace tenant to have a comprehensive overview of all configuration changes also in your Dynatrace tenant.

1. **remediation.yaml**: This file holds a couple of tasks that are taken care of remediating an problem ticket of Dynatrace. 

    1. Push a comment to Dynatrace that the remediation script is executing.
    1. Get `entityId` of `ImpactedEntities` of the Dynatrace problem ticket.
    1. Fetch `CUSTOM_CONFIGURATION` events from the impacted entity
    1. Get most recent configuration event
    1. Call the `remediation action` that is defined in the configuration event
    1. Push a success/error comment to Dynatrace

[ansible AWX]: https://github.com/ansible/awx