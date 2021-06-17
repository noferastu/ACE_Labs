# Setup Self-Healing Action for Production Deployment

In this lab you'll leverage the Ansible Tower jobs created on previous labs that trigger a deployment in a canary release manner. Additionally, you will create a second job that switches back to the old version in case the *canary* (i.e., the new version of front-end) behaves wrong.

Prerequisites coming from module [Runbook Automation and Self-Healing](/workshop/09_Runbook_Automation_and_Self_Healing):
* *git-token* Credentials in Ansible Tower
* *self-healing* Project in Ansible Tower
* *inventory* in Ansible Tower

# Troubleshooting
Some useful kubectl commands:
- `kubectl -n istio-system get pods`: get all pods in the Istio namespace
- `Kubectl -n istio-system delete pod **`: delete pod in the Istio namespace

---
[Previous Step: Simulate Early Pipeline Break](../02_Simulate_Early_Pipeline_Break) :arrow_backward: :arrow_forward: [Next Step: Simulate a Bad Production Deployment](../04_Introduce_a_Failure_into_Front-End)

:arrow_up_small: [Back to overview](../)
