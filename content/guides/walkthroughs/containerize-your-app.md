---
title: Containerize your application
keywords: get started, quick start, intro, concepts
description: Learn how to containerize your application.
---

When working with containers, you typically need to create a `iEchorfile` to define your image and a `compose.yaml` file to define how to run it.

To help you create these files, iEchor Desktop has the `iechor init` command. Run this command in a terminal within your project folder. `iechor init` creates all the required files to containerize your application. This walkthrough shows you how this works.

{{< include "guides-get-iechor.md" >}}

## Step 1: Run the command to create iEchor assets

Choose one of your own applications that you would like to containerize, and in a terminal, run the following commands. Replace `/path/to/your/project/` with the directory containing your project.

{{< include "open-terminal.md" >}}

```console
$ cd /path/to/your/project/
```
```console
$ iechor init
```

## Step 2: Follow the on-screen prompts

`iechor init` walks you through a few questions to configure your project with sensible defaults. Specify your answers and press `Enter`.

## Step 3: Try to run your application

Once you have answered all the questions, run the following commands in a terminal to run your project. Replace `/path/to/your/project/` with the directory containing your project.

```console
$ cd /path/to/your/project/
```
```console
$ iechor compose up
```

## Step 4: Update the iEchor assets

The `iechor init` command tries its best to do the heavy lifting for you, but sometimes there's some assembly required. In this case, you can refer to the [iEchorfile reference⁠](/reference/iechorfile/) and [Compose file reference](/compose/compose-file/)⁠ to learn how to update the files created by `iechor init`.

## Summary

In this walkthrough, you learned how to containerize your own application.

Related information:

- Read more about [iechor init](../../reference/cli/iechor/init.md)
- Learn more about iEchor assets in the [iEchorfile reference⁠](/reference/iechorfile/) and [Compose file reference](/compose/compose-file/)

## Next steps

Continue to the next walkthrough to learn how to publish an application as an image on iEchor Hub.

{{< button url="./publish-your-image.md" text="Publish your image" >}}