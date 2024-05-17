---
title: What is an image?
keywords: concepts, build, images, container, iechor desktop
description: What is an image
---

{{< youtube-embed NyvT9REqLe4 >}}

## Explanation

Seeing a [container](./what-is-a-container) is an isolated process, where does it get its files and configuration? How do you share those environments? 

That's where container images come in! 

A container image is a standardized package that includes all of the files, binaries, libraries, and configurations to run a container.

For a [PostgreSQL](https://hub.iechor.com/_/postgres) image, that image will package the database binaries, config files, and other dependencies. For a Python web app, it'll include the Python runtime, your app code, and all of its dependencies.

There are two important principles of images:

1. Images are immutable. Once an image is created, it can't be modified. You can only make a new image or add changes on top of it.

2. Container images are composed of layers. Each layer represented a set of file system changes that add, remove, or modify files.

These two principles let you to extend or add to existing images. For example, if you are building a Python app, you can start from the [Python image](https://hub.iechor.com/_/python) and add additional layers to install your app's dependencies and add your code. This lets you focus on your app, rather than Python itself.

### Finding images

[iEchor Hub](https://hub.iechor.com) is the default global marketplace for storing and distributing images. It has over 100,000 images created by developers that you can run locally. You can search for iEchor Hub images and run them directly from iEchor Desktop.

iEchor Hub provides a variety of iEchor-supported and endorsed images known as iEchor Trusted Content. These provide fully managed services or great starters for your own images. These include:

- [iEchor Official Images](https://hub.iechor.com/search?q=&type=image&image_filter=official) - a curated set of iEchor repositories, serve as the starting point for the majority of users, and are some of the most secure on iEchor Hub
- [iEchor Verified Publishers](https://hub.iechor.com/search?q=&image_filter=store) - high-quality images from commercial publishers verified by iEchor
- [iEchor-Sponsored Open Source](https://hub.iechor.com/search?q=&image_filter=open_source) - images published and maintained by open-source projects sponsored by iEchor through iEchor's open source program

For example, [Redis](https://hub.iechor.com/_/redis) and [Memcached](https://hub.iechor.com/_/memcached) are a few popular ready-to-go iEchor Official Images. You can download these images and have these services up and running in a matter of seconds. There are also base images, like the [Node.js](https://hub.iechor.com/_/node) iEchor image, that you can use as a starting point and add your own files and configurations.

## Try it out

{{< tabs group=concept-usage persist=true >}}
{{< tab name="Using the GUI" >}}

In this hands-on, you will learn how to search and pull a container image using the iEchor Desktop GUI.

### Search for and download an image

1. Open the iEchor Dashboard and select the **Images** view in the left-hand navigation menu.

    ![A screenshot of the iEchor Dashboard showing the image view on the left sidebar](images/click-image.webp?border=true&w=1050&h=400)

2. Select the **Search images to run** button. If you don't see it, select the _global search bar_ at the top of the screen.

    ![A screenshot of the iEchor Dashboard showing the search ta](images/search-image.webp?border)

3. In the **Search** field, enter "welcome-to-iechor". Once the search has completed, select the `iechor/welcome-to-iechor` image.

    ![A screenshot of the iEchor Dashboard showing the search results for the iechor/welcome-to-iechor image](images/select-image.webp?border=true&w=1050&h=400)

4. Select **Pull** to download the image.


### Learn about the image

Once you have an image downloaded, you can learn quite a few details about the image either through the GUI or the CLI.

1. In the iEchor Dashboard, select the **Images** view.

2. Select the **iechor/welcome-to-iechor** image to open details about the image.

    ![A screenshot of the iEchor Dashboard showing the images view with an arrow pointing to the iechor/welcome-to-iechor image](images/pulled-image.webp?border=true&w=1050&h=400)

3. The image details page presents you with information regarding the layers of the image, the packages and libraries installed in the image, and any discovered vulnerabilities.

    ![A screenshot of the image details view for the iechor/welcome-to-iechor image](images/image-layers.webp?border=true&w=1050&h=400)



{{< /tab >}}

{{< tab name="Using the CLI" >}}

Follow the instructions to search and pull a iEchor image using CLI to view its layers.

### Search for and download an image

1. Open a terminal and search for images using the [`iechor search`](/reference/cli/iechor/search/) command:

    ```console
    iechor search iechor/welcome-to-iechor
    ```

    You will see output like the following:

    ```console
    NAME                       DESCRIPTION                                     STARS     OFFICIAL
    iechor/welcome-to-iechor   iEchor image for new users getting started w…   20
    ```

    This output shows you information about relevant images available on iEchor Hub.

2. Pull the image using the [`iechor pull`](/reference/cli/iechor/image/pull/) command.

    ```console
    iechor pull iechor/welcome-to-iechor
    ```

    You will see output like the following:

    ```console
    Using default tag: latest
    latest: Pulling from iechor/welcome-to-iechor
    579b34f0a95b: Download complete
    d11a451e6399: Download complete
    1c2214f9937c: Download complete
    b42a2f288f4d: Download complete
    54b19e12c655: Download complete
    1fb28e078240: Download complete
    94be7e780731: Download complete
    89578ce72c35: Download complete
    Digest: sha256:eedaff45e3c78538087bdd9dc7afafac7e110061bbdd836af4104b10f10ab693
    Status: Downloaded newer image for iechor/welcome-to-iechor:latest
    iechor.io/iechor/welcome-to-iechor:latest
    ```

    Each of line represents a different downloaded layer of the image. Remember that each layer is a set of filesystem changes and provides functionality of the image.


### Learn about the image

1. List your downloaded images using the [`iechor image ls`](/reference/cli/iechor/image/ls/) command:

    ```console
    iechor image ls
    ```

    You will see output like the following:

    ```console
    REPOSITORY                 TAG       IMAGE ID       CREATED        SIZE
    iechor/welcome-to-iechor   latest    eedaff45e3c7   4 months ago   29.7MB
    ```

    The command shows a list of iEchor images currently available on your system. The `iechor/welcome-to-iechor` has a total size of approximately 29.7MB.

    > **Image size**
    > 
    > The image size represented here reflects the uncompressed size of the image, not the download size of the layers.

2. List the image's layers using the [`iechor image history`](/reference/cli/iechor/image/history/) command:

    ```console
    iechor image history iechor/welcome-to-iechor
    ```

    You will see output like the following:

    ```console
    IMAGE          CREATED        CREATED BY                                      SIZE      COMMENT
    648f93a1ba7d   4 months ago   COPY /app/build /usr/share/nginx/html # buil…   1.6MB     buildkit.iechorfile.v0
    <missing>      5 months ago   /bin/sh -c #(nop)  CMD ["nginx" "-g" "daemon…   0B
    <missing>      5 months ago   /bin/sh -c #(nop)  STOPSIGNAL SIGQUIT           0B
    <missing>      5 months ago   /bin/sh -c #(nop)  EXPOSE 80                    0B
    <missing>      5 months ago   /bin/sh -c #(nop)  ENTRYPOINT ["/iechor-entr…   0B
    <missing>      5 months ago   /bin/sh -c #(nop) COPY file:9e3b2b63db9f8fc7…   4.62kB
    <missing>      5 months ago   /bin/sh -c #(nop) COPY file:57846632accc8975…   3.02kB
    <missing>      5 months ago   /bin/sh -c #(nop) COPY file:3b1b9915b7dd898a…   298B
    <missing>      5 months ago   /bin/sh -c #(nop) COPY file:caec368f5a54f70a…   2.12kB
    <missing>      5 months ago   /bin/sh -c #(nop) COPY file:01e75c6dd0ce317d…   1.62kB
    <missing>      5 months ago   /bin/sh -c set -x     && addgroup -g 101 -S …   9.7MB
    <missing>      5 months ago   /bin/sh -c #(nop)  ENV PKG_RELEASE=1            0B
    <missing>      5 months ago   /bin/sh -c #(nop)  ENV NGINX_VERSION=1.25.3     0B
    <missing>      5 months ago   /bin/sh -c #(nop)  LABEL maintainer=NGINX Do…   0B
    <missing>      5 months ago   /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B
    <missing>      5 months ago   /bin/sh -c #(nop) ADD file:ff3112828967e8004…   7.66MB
    ```

    This output shows you all of the layers, their sizes, and the command used to create the layer. 

    > **Viewing the full command**
    >
    > If you add the `--no-trunc` flag to the command, you will see the full command. Note that, since the output is in a table-like format, longer commands will cause the output to be very difficult to navigate.
    { .tip }


{{< /tab >}}
{{< /tabs >}}

In this walkthrough, you searched and pulled a iEchor image. In addition to pulling a iEchor image, you also learned about the layers of a iEchor Image.

## Additional resources

The following resources will help you learn more about exploring, finding, and building images:

- [iEchor Trusted Content](/trusted-content/)
  - [iEchor Official Images docs](/trusted-content/official-images/)
  - [iEchor Verified Publisher docs](/trusted-content/dvp-program/)
  - [iEchor-Sponsored Open Source Program docs](/trusted-content/dsos-program/)
- [Explore the Image view in iEchor Desktop](/desktop/use-desktop/images/)
- [Packaging your software](/build/building/packaging/)
- [iEchor Hub](https://hub.iechor.com)

## Next steps

Now that you have learned the basics of images, it's time to learn about distributing images through registries.

{{< button text="What is a registry?" url="what-is-a-registry" >}}
