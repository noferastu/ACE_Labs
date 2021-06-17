# Clone Gitea Repositories (Optional)

In this lab, you will clone the Gitea repositories we've forked in lab 2 to your local environment. Then, you can edit those files in [Visual Studio Code] or any other editor of your choice. If you prefer to make changes directly on the Gitea web interface, you can skip the steps below.

## Prerequisites

* Gitea organization
* Gitea user and password
* git installed on your local environment

## Steps - Linux/macOS

1. Download the `cloneall.sh` script that is in this folder to your local machine
1. Clone all projects from the Gitea organization you've created earlier to your local machine:

    ```bash
    ./cloneall.sh http://gitea.<IP-ADDRESS>.nip.io
    ```

**Note:** Please ensure that you are not using a cloud backup (e.g. Dropbox, OneDrive) directory for cloning the sockshop repos as this will cause errors when trying to commit and push changes to the Git repository.

## Steps - Windows

1. Download the `cloneall.ps1` script that is in this folder to your local machine
1. Launch PowerShell or Command Prompt

1. Execute commant to clone all repos from the Gitea organization you've created earlier to your local machine:

    ```powershell
    PowerShell.exe -ExecutionPolicy Bypass -File .\cloneall.ps1 http://gitea.<IP-ADDRESS>.nip.io
    ```

**Note:** Please ensure that you are not using a cloud backup (e.g. Dropbox, OneDrive) directory for cloning the sockshop repos as this will cause errors when trying to commit and push changes to the Git repository.

## Steps - Cloned repos

The following repos will be cloned from the Gitea Organization:

```bash
carts
catalogue
front-end
jenkins-release-branch
k8s-deploy-staging
k8s-deploy-production
orders
payment
queue-master
shipping
sockshop-infrastructure 
user
```

This concludes the lab

---

[Previous Step: Trigger Build Pipelines](../4_Trigger_Build_Pipelines) :arrow_backward:

:arrow_up_small: [Back to overview](../)

[Visual Studio Code]: https://code.visualstudio.com/