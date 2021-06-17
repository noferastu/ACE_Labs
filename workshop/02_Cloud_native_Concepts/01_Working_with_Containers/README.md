# Working with Container Images and Containers

In this lab you'll learn how to create a container image and how to run a container based on this image. During this activity you will pull an image from a global container registry to get hands-on experience with container registries in general.

## Step 1: View the Dockerfile and script

1. View the Dockerfile using an editor.

    ```bash
    (bastion)$ cd ~
    (bastion)$ cd docker/
    ```

1. The Dockerfile should look like this:

    ```docker
    FROM alpine:latest
    COPY . /app
    WORKDIR /app
    RUN apk add --no-cache wget
    ENTRYPOINT [ "sh" ]
    CMD ["hello_world.sh"]
    ```

1. The bash script referenced in the Dockerfile looks like this:

    ```bash
    echo "Hello World from a Docker Container."
    ```

## Step 2. Build and Tag a Container Image

1. Build the container image (`-t` specifies the repository and a tag). The `$USER` variable will tag the image with your username. Make sure to include the (.) at the end of the command to tell docker that the Dockerfile is on the current working directory.

    ```bash
    (bastion)$ docker build -t acl/hello-world:$USER .
    ```

1. List all container images on your local machine.

    ```bash
    (bastion)$ docker images
    ```

1. Set another tag.

    ```bash
    (bastion)$ docker tag acl/hello-world:$USER acl/hello-world:$USER-stable
    ```

1. List all container images on your local machine.

    ```bash
    (bastion)$ docker images
    ```

## Step 3. Run a Container

1. Run the container based on a container image.

    ```bash
    (bastion)$ docker run acl/hello-world:$USER-stable
    ```

:arrow_up_small: [Back to overview](../README.md)