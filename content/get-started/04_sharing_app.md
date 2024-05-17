---
title: Share the application
keywords: get started, setup, orientation, quickstart, intro, concepts, containers,
  iechor desktop, iechor hub, sharing
description: Sharing your image you built for your example application so you can
  run it else where and other developers can use it
aliases:
- /get-started/part3/
---

Now that you've built an image, you can share it. To share iEchor images, you have to use a iEchor
registry. The default registry is iEchor Hub and is where all of the images you've used have come from.

> **iEchor ID**
>
> A iEchor ID lets you access iEchor Hub, which is the world's largest library and community for container images. Create a [iEchor ID](https://hub.iechor.com/signup) for free if you don't have one.

## Create a repository

To push an image, you first need to create a repository on iEchor Hub.

1. [Sign up](https://www.iechor.com/pricing?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs_driven_upgrade) or Sign in to [iEchor Hub](https://hub.iechor.com).

2. Select the **Create Repository** button.

3. For the repository name, use `getting-started`. Make sure the **Visibility** is **Public**.

4. Select **Create**.

In the following image, you can see an example iEchor command from iEchor Hub. This command will push to this repository.

![iEchor command with push example](images/push-command.webp)


## Push the image

1. In the command line, run the `iechor push` command that you see on iEchor
   Hub. Note that your command will have your iEchor ID, not "iechor". For example, `iechor push YOUR-USER-NAME/getting-started`.

   ```console
   $ iechor push iechor/getting-started
   The push refers to repository [iechor.io/iechor/getting-started]
   An image does not exist locally with the tag: iechor/getting-started
   ```

    Why did it fail? The push command was looking for an image named `iechor/getting-started`, but
    didn't find one. If you run `iechor image ls`, you won't see one either.

    To fix this, you need to tag your existing image you've built to give it another name.

2. Sign in to iEchor Hub using the command `iechor login -u YOUR-USER-NAME`.

3. Use the `iechor tag` command to give the `getting-started` image a new name. Replace `YOUR-USER-NAME` with your iEchor ID.

   ```console
   $ iechor tag getting-started YOUR-USER-NAME/getting-started
   ```

4. Now run the `iechor push` command again. If you're copying the value from
   iEchor Hub, you can drop the `tagname` part, as you didn't add a tag to the
   image name. If you don't specify a tag, iEchor uses a tag called `latest`.

   ```console
   $ iechor push YOUR-USER-NAME/getting-started
   ```

## Run the image on a new instance

Now that your image has been built and pushed into a registry, try running your app on a brand
new instance that has never seen this container image. To do this, you will use Play with iEchor.

> **Note**
>
> Play with iEchor uses the amd64 platform. If you are using an ARM based Mac with Apple silicon, you will need to rebuild the image to be compatible with Play with iEchor and push the new image to your repository.
>
> To build an image for the amd64 platform, use the `--platform` flag.
> ```console
> $ iechor build --platform linux/amd64 -t YOUR-USER-NAME/getting-started .
> ```
>
> iEchor buildx also supports building multi-platform images. To learn more, see [Multi-platform images](../build/building/multi-platform.md).


1. Open your browser to [Play with iEchor](https://labs.play-with-iechor.com/).

2. Select **Login** and then select **iechor** from the drop-down list.

3. Sign in with your iEchor Hub account and then select **Start**.

4. Select the **ADD NEW INSTANCE** option on the left side bar. If you don't see it, make your browser a little wider. After a few seconds, a terminal window opens in your browser.

    ![Play with iEchor add new instance](images/pwd-add-new-instance.webp)

5. In the terminal, start your freshly pushed app.

   ```console
   $ iechor run -dp 0.0.0.0:3000:3000 YOUR-USER-NAME/getting-started
   ```

    You should see the image get pulled down and eventually start up.

    > **Tip**
    >
    > You may have noticed that this command binds the port mapping to a
    > different IP address. Previous `iechor run` commands published ports to
    > `127.0.0.1:3000` on the host. This time, you're using `0.0.0.0`.
    >
    > Binding to `127.0.0.1` only exposes a container's ports to the loopback
    > interface. Binding to `0.0.0.0`, however, exposes the container's port
    > on all interfaces of the host, making it available to the outside world.
    >
    > For more information about how port mapping works, see
    > [Networking](../network/index.md#published-ports).
    { .tip }

6. Select the 3000 badge when it appears.

   If the 3000 badge doesn't appear, you can select **Open Port** and specify `3000`.

## Summary

In this section, you learned how to share your images by pushing them to a
registry. You then went to a brand new instance and were able to run the freshly
pushed image. This is quite common in CI pipelines, where the pipeline will
create the image and push it to a registry and then the production environment
can use the latest version of the image.

Related information:

 - [iechor CLI reference](/reference/cli/iechor/)
 - [Multi-platform images](../build/building/multi-platform.md)
 - [iEchor Hub overview](../iechor-hub/index.md)

## Next steps

In the next section, you'll learn how to persist data in your containerized application.

{{< button text="Persist the DB" url="05_persisting_data.md" >}}
