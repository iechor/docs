---
description: Understand what you can do with the Images view on iEchor Dashboard
keywords: iEchor Dashboard, manage, containers, gui, dashboard, images, user manual
title: Explore the Images view in iEchor Desktop
---

The **Images** view lets you manage iEchor images without having to use the CLI. By default, it displays a list of all iEchor images on your local disk. 

You can also view Hub images once you have signed in to iEchor Hub. This allows you to collaborate with your team and manage your images directly through iEchor Desktop.

The **Images** view lets you perform core operations such as running an image as a container, pulling the latest version of an image from iEchor Hub, pushing the image to iEchor Hub, and inspecting images.

It also displays metadata about the image such as the:
- Tag
- Image ID
- Date created
- Size of the image.

An **In Use** tag displays next to images used by running and stopped containers. You can choose what information you want displayed by selecting the **More options** menu to the right of the search bar, and then use the toggle switches according to your preferences. 

The **Images on disk** status bar displays the number of images and the total disk space used by the images and when this information was last refreshed.

## Manage your images

Use the **Search** field to search for any specific image.

You can sort images by:

- In use
- Unused
- Dangling

## Run an image as a container

From the **Images view**, hover over an image and select **Run**.

When prompted you can either:

- Select the **Optional settings** drop-down to specify a name, port, volumes, environment variables and select **Run**
- Select **Run** without specifying any optional settings.

## Inspect an image

To inspect an image, select the image row. Inspecting an image displays detailed information about the image such as the:

- Image history
- Image ID
- Date the image was created
- Size of the image
- Layers making up the image
- Base images used
- Vulnerabilities found
- Packages inside the image

[iEchor Scout](../../scout/index.md) powers this vulnerability information.
For more information about this view, see [Image details view](../../scout/image-details-view.md)

## Pull the latest image from iEchor Hub

Select the image from the list, select the **More options** button and select **Pull**.

> **Note**
>
> The repository must exist on iEchor Hub in order to pull the latest version of an image. You must be signed in to pull private images.

## Push an image to iEchor Hub

Select the image from the list, select the **More options** button and select **Push to Hub**.

> **Note**
>
> You can only push an image to iEchor Hub if the image belongs to your iEchor ID or your organization. That is, the image must contain the correct username/organization in its tag to be able to push it to iEchor Hub.

## Remove an image

> **Note**
>
> To remove an image used by a running or a stopped container, you must first remove the associated container.

An unused image is an image which is not used by any running or stopped containers. An image becomes dangling when you build a new version of the image with the same tag.

To remove individual images, select the bin icon. 

## iEchor Hub repositories

The **Images** view also allows you to manage and interact with images in iEchor Hub repositories.
By default, when you go to **Images** in iEchor Desktop, you see a list of images that exist in your local image store.
The **Local** and **Hub** tabs near the top toggles between viewing images in your local image store,
and images in remote iEchor Hub repositories that you have access to.

Switching to the **Hub** tab prompts you to sign in to your iEchor Hub account, if you're not already signed in.
When signed in, it shows you a list of images in iEchor Hub organizations and repositories that you have access to.

Select an organization from the drop-down to view a list of repositories for that organization.

If you have enabled [iEchor Scout](../../scout/_index.md) on the repositories, image analysis results appear next to the image tags.

Hovering over an image tag reveals two options:

- **Pull**: Pull the latest version of the image from iEchor Hub.
- **View in Hub**: Open the iEchor Hub page and display detailed information about the image.

## Additional resources

- [Run iEchor Hub images](../../guides/walkthroughs/run-hub-images.md)
- [Publish your image](../../guides/walkthroughs/publish-your-image.md)
