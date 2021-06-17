# Building Environment Zero

In this module you'll learn how to setup your environment in your own GKE cluster for the rest of the week for all labs. We'll setup [Jenkins](https://jenkins.io/) and a [Docker registry](https://docs.docker.com/registry/), fork several GitHub repositories from an existing GitHub organization ([acl-sockshop](https://github.com/acl-sockshop)) to yours, and configure build pipelines for all microservices in of the Sockshop application, that are hosted in said GitHub repositories. At the end of this session, your continuous CI/CD environment is ready to be explored, configured, and run.

1. [Prepare Environment](0_Prepare_Environment)
2. [Deploy Docker Registry](1_Deploy_Docker_Registry)
3. [Deploy Gitea](2_Deploy_Gitea)
4. [Deploy Jenkins](3_Deploy_Jenkins)
5. [Trigger Build Pipelines](4_Trigger_Build_Pipelines)
6. [Clone Gitea Repositories](5_Clone_Gitea_Repositories)

## Troubleshooting and useful links
- [`kubectl` Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
