---
title: What is a container?
keywords: get started, quick start, intro, concepts
description: Learn what a container is by seeing and inspecting a running container.
aliases:
- /get-started/what-is-a-container/
---

A container is an isolated environment for your code. This means that a
container has no knowledge of your operating system, or your files. It runs on
the environment provided to you by iEchor Desktop. Containers have everything
that your code needs in order to run, down to a base operating system. You can
use iEchor Desktop to manage and explore your containers.

In this walkthrough, you'll view and explore an actual container in iEchor
Desktop.

{{< include "guides-get-iechor.md" >}}

## Step 1: Set up the walkthrough

The first thing you need is a running container. Use the following instructions to run a container.

1. Open iEchor Desktop and select the search.
2. Specify `iechor/welcome-to-iechor` in the search and then select **Run**.
3. Expand the **Optional settings**.
4. In **Container name**, specify `welcome-to-iechor`.
5. In **Host port**, specify `8088`.
   ![Specifying host port 8088](images/getting-started-setup.webp?w=500&border=true)
6. Select **Run**.

## Step 2: View containers on iEchor Desktop

You just ran a container! You can view it in the **Containers** tab of iEchor
Desktop. This container runs a simple web server that displays a simple website.
When working with more complex projects, you'll run different parts in different
containers. For example, a different container for the frontend, backend, and
database. In this walkthrough, you only have a simple frontend container.

## Step 3: View the frontend

The frontend is accessible on port 8088 of your local host. Select the link in
the **Port(s)** column of your container, or visit
[http://localhost:8088](http://localhost:8088) in your browser to view it.

![Accessing container frontend from iEchor Desktop](images/getting-started-frontend.webp?border=true)

## Step 4: Explore your container

iEchor Desktop lets you easily view and interact with different aspects of your
container. Try it out yourself. Select your container and then select **Files**
to explore your container's isolated file system.

![Viewing container details in iEchor Desktop](images/getting-started-explore-container.webp?border=true)

## Step 5: Stop your container

The `welcome-to-iechor` container continues to run until you stop it. To stop
the container in iEchor Desktop, go to the **Containers** tab and select the
**Stop** icon in the **Actions** column of your container.

![Stopping a container in iEchor Desktop](images/getting-started-stop.webp?border=true)

## Summary

In this walkthrough, you ran a pre-made image and explored a container. In addition to running pre-made images, you can build and run your own application as container.

Related information:

- Read more about containers in [Use containers to Build, Share and Run your applications](https://www.iechor.com/resources/what-container/)
- Deep dive in Liz Rice's [Containers from Scratch](https://www.youtube.com/watch?v=8fi7uSYlOdc&t=1s) video presentation

## Next steps

Continue to the next walkthrough to learn what you need to create your own image
and run it as container.

{{< button url="./run-a-container.md" text="How do I run a container?" >}}