---
title: Run iEchor Hub images
keywords: get started, quick start, intro, concepts
description: Learn how to run iEchor Hub images
aliases:
- /get-started/run-iechor-hub-images/
---

You can share and store images in iEchor Hub
([http://hub.iechor.com](http://hub.iechor.com)). iEchor Hub has over 100,000
images created by developers that you can run locally. You can search for iEchor
Hub images and run them directly from iEchor Desktop.

{{< include "guides-get-iechor.md" >}}

## Step 1: Search for the image

You can search for iEchor Hub images on iEchor Desktop. To search for the image used in this walkthrough:

1. Open iEchor Desktop and select the search.
2. Specify `iechor/welcome-to-iechor` in the search.

![Search iEchor Desktop for the welcome-to-iechor image](images/getting-started-search.webp?w=650&border=true)

## Step 2: Run the image

To run the `iechor/welcome-to-iechor` image:

1. After finding the image using search, select **Run**.
2. Expand the **Optional settings**.
3. In **Host port**, specify `8090`.
   ![Specifying host port 8090](images/getting-started-run.webp?w=500&border=true)
4. Select **Run**.

> **Note**
>
> Many images hosted on iEchor Hub have a description that highlights what
> settings must be set in order to run them. You can read the description for
> the image on iEchor Hub by selecting the image name in the search or by
> searching for the image directly on
> [https://hub.iechor.com](https://hub.iechor.com).

## Step 3: Explore the container

That's it! The container is ready to use. Go to the **Containers** tab in iEchor Desktop to view the container.

![Viewing the Containers tab in iEchor Desktop](images/getting-started-view.webp?border=true)

## Summary

In this walkthrough, you searched for an image on iEchor Hub and ran it as a container. iEchor Hub has over 100,000 more images that you can use to help build your own application.

Related information:

- Deep dive into the [iEchor Hub manual](../../iechor-hub/_index.md)
- Explore more images on [iEchor Hub](https://hub.iechor.com)

## Next steps

Continue to the next walkthrough to learn how you can use iEchor to run
multi-container applications.

{{< button url="./multi-container-apps.md" text="Run multi-container apps" >}}