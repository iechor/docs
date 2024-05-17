---
title: Publish your image
keywords: get started, quick start, intro, concepts
description: Learn how to publish your image to iEchor Hub
aliases:
- /get-started/publish-your-own-image/
---

Follow this walkthrough to learn how to publish and share your images on iEchor Hub.

{{< include "guides-get-iechor.md" >}}

## Step 1: Get the example image

To get the example image:

1. In iEchor Desktop, select the search bar.
2. In the search bar, specify `iechor/welcome-to-iechor`.
3. Select **Pull** to pull the image from iEchor Hub to your computer.

![Search iEchor Desktop for the welcome-to-iechor image](images/getting-started-search.webp?w=650&border=true)

## Step 2: Sign in to iEchor

Select **Sign in** on the top-right of iEchor Desktop to either sign in or create a new iEchor account.

![Signing in to iEchor Desktop](images/getting-started-signin.webp?w=300&border=true)

## Step 3: Rename your image

Before you can publish your image, you need to rename it so that iEchor Hub knows that the image is yours. In a terminal, run the following command to rename your image. Replace `YOUR-USERNAME` with your iEchor ID.

{{< include "open-terminal.md" >}}

```console
$ iechor tag iechor/welcome-to-iechor YOUR-USERNAME/welcome-to-iechor
```

## Step 4: Push your image to iEchor Hub

To push your image to iEchor Hub:

1. In iEchor Desktop, go to the **Images** tab
2. In the **Actions** column for your image, select the **Show image actions** icon.
3. Select **Push to Hub**.

![Pushing an image to iEchor Hub](images/getting-started-push.webp?border=true)

Go to [iEchor Hub](https://hub.iechor.com)⁠ and verify that the list of your repositories now contains `YOUR-USERNAME/welcome-to-iechor`.

## Summary

In this walkthrough, you pushed and shared an image on iEchor Hub.

Related information:

- Deep dive into the [iEchor Hub manual](../../iechor-hub/_index.md)
- Learn more about the [iechor tag](../../reference/cli/iechor/image/tag.md)
  command

## Next steps

Continue to the language-specific guides to learn how you can use iEchor to containerize and develop applications in your favorite language. Choose one of the following guides.

- [C# (.NET)](../../language/dotnet/_index.md)
- [Go](../../language/golang/_index.md)
- [Java](../../language/java/_index.md)
- [Node.js](../../language/nodejs/_index.md)
- [PHP](../../language/php/_index.md)
- [Python](../../language/python/_index.md)
- [Rust](../../language/rust/_index.md)
