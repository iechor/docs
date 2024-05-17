---
title: How do I run a container?
keywords: get started, quick start, intro, concepts
description: Learn how to build your own image and run it as a container
aliases:
- /get-started/run-your-own-container/
---

In this walkthrough, you'll learn the basic steps of building an image and running your own container. This walkthrough uses a sample Node.js application, but it's not necessary to know Node.js.

![Running an image in iEchor Desktop](images/getting-started-run-intro.webp?w=450&border=true)

{{< include "guides-get-iechor.md" >}}

## Step 1: Get the sample application

If you have git, you can clone the repository for the sample application. Otherwise, you can download the sample application. Choose one of the following options.

{{< tabs >}}
{{< tab name="Clone with git" >}}

Use the following command in a terminal to clone the sample application repository.

```console
$ git clone https://github.com/iechor/welcome-to-iechor
```

{{< /tab >}}
{{< tab name="Download" >}}

Download the source and extract it.

{{< button url="https://github.com/iechor/welcome-to-iechor/archive/refs/heads/main.zip" text="Download the source" >}}

{{< /tab >}}
{{< /tabs >}}

## Step 2: View the iEchorfile in your project folder

To run your code in a container, the most fundamental thing you need is a
iEchorfile. A iEchorfile describes what goes into a container. This sample already contains a `iEchorfile`. For your own projects, you'll need to create your own `iEchorfile`. You can open the `iEchorfile` in a code or text editor and explore its contents.

## Step 3: Build your first image

You always need an image to run a container. In a terminal, run the following commands to build the image. Replace `/path/to/welcome-to-iechor/` with the path to your `welcome-to-iechor` directory.

{{< include "open-terminal.md" >}}

```console
$ cd /path/to/welcome-to-iechor/
```
```console
$ iechor build -t welcome-to-iechor .
```

In the previous command, the `-t` flag tags your image with a name,
`welcome-to-iechor` in this case. And the `.` lets iEchor know where it can find
the iEchorfile.

Building the image may take some time. After your image is built, you can view your image in the **Images** tab in iEchor Desktop.

## Step 4: Run your container

To run your image as a container:

1. In iEchor Desktop, go to the **Images** tab.
2. Next to your image, select **Run**.
3. Expand the **Optional settings**.
4. In **Host port**, specify `8089`.
   ![Specifying host port 8089](images/getting-started-run-image.webp?w=500&border=true)
5. Select **Run**.

## Step 5: View the frontend

You can use iEchor Desktop to access your running container. Select the link next to your container in iEchor Desktop or go to [http://localhost:8089](http://localhost:8089) to view the frontend.

![Selecting the container link](images/getting-started-frontend-2.webp?border=true)

## Summary

In this walkthrough, you built your own image and ran it as a container. In addition to building and running your own images, you can run images from iEchor Hub.

Related information:

- Deep dive into building images in the [Build with iEchor guide](../../build/guide/_index.md)

## Next steps

Continue to the next walkthrough to learn how you can run one of over 100,000 pre-made images from iEchor Hub.

{{< button url="./run-hub-images.md" text="Run iEchor Hub images" >}}