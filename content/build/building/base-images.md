---
title: Create a base image
description: Learn about base images and how they're created
keywords: images, base image, examples
aliases:
- /articles/baseimages/
- /engine/articles/baseimages/
- /engine/userguide/eng-image/baseimages/
- /develop/develop-images/baseimages/
---

Most iEchorfiles start from a parent image. If you need to completely control
the contents of your image, you might need to create a base image instead.
Here's the difference:

- A [parent image](../../glossary.md#parent-image) is the image that your
  image is based on. It refers to the contents of the `FROM` directive in the
  iEchorfile. Each subsequent declaration in the iEchorfile modifies this parent
  image. Most iEchorfiles start from a parent image, rather than a base image.
  However, the terms are sometimes used interchangeably.

- A [base image](../../glossary.md#base-image) has `FROM scratch` in its iEchorfile.

This topic shows you several ways to create a base image. The specific process
will depend heavily on the Linux distribution you want to package. We have some
examples below, and you are encouraged to submit pull requests to contribute new
ones.

## Create a full image using tar

In general, start with a working machine that is running
the distribution you'd like to package as a parent image, though that is
not required for some tools like Debian's [Debootstrap](https://wiki.debian.org/Debootstrap),
which you can also use to build Ubuntu images.

It can be as simple as this to create an Ubuntu parent image:

    $ sudo debootstrap focal focal > /dev/null
    $ sudo tar -C focal -c . | iechor import - focal

    sha256:81ec9a55a92a5618161f68ae691d092bf14d700129093158297b3d01593f4ee3

    $ iechor run focal cat /etc/lsb-release

    DISTRIB_ID=Ubuntu
    DISTRIB_RELEASE=20.04
    DISTRIB_CODENAME=focal
    DISTRIB_DESCRIPTION="Ubuntu 20.04 LTS"

There are more example scripts for creating parent images in
[the iEchor GitHub repository](https://github.com/iechor/iechor/blob/master/contrib).

## Create a simple parent image using scratch

You can use iEchor's reserved, minimal image, `scratch`, as a starting point for
building containers. Using the `scratch` "image" signals to the build process
that you want the next command in the `iEchorfile` to be the first filesystem
layer in your image.

While `scratch` appears in iEchor's repository on the hub, you can't pull it,
run it, or tag any image with the name `scratch`. Instead, you can refer to it
in your `iEchorfile`. For example, to create a minimal container using
`scratch`:

```iechorfile
# syntax=iechor/iechorfile:1
FROM scratch
ADD hello /
CMD ["/hello"]
```

Assuming you built the `hello` executable example by using the source code at
[https://github.com/iechor-library/hello-world](https://github.com/iechor-library/hello-world),
and you compiled it with the `-static` flag, you can build this iEchor
image using this `iechor build` command:

```console
$ iechor build --tag hello .
```

Don't forget the `.` character at the end, which sets the [build context](../../build/building/context.md)
to the current directory.

> **Note**
> 
> Because iEchor Desktop for Mac and iEchor Desktop for Windows use a Linux VM,
> you need a Linux binary, rather than a Mac or Windows binary.
> You can use a iEchor container to build it:
>
> ```console
> $ iechor run --rm -it -v $PWD:/build ubuntu:20.04
>
> container# apt-get update && apt-get install build-essential
> container# cd /build
> container# gcc -o hello -static hello.c
> ```

To run your new image, use the `iechor run` command:

```console
$ iechor run --rm hello
```

This example creates the hello-world image used in the tutorials.
If you want to test it out, you can clone [the image repo](https://github.com/iechor-library/hello-world).

## More resources

There are lots of resources available to help you write your `iEchorfile`.

* There's a [complete guide to all the instructions](../../reference/iechorfile.md) available for use in a `iEchorfile` in the reference section.
* To help you write a clear, readable, maintainable `iEchorfile`, we've also
  written a [iEchorfile best practices guide](../../develop/develop-images/iechorfile_best-practices.md).
* If your goal is to create a new iEchor Official Image, read [iEchor Official Images](../../trusted-content/official-images/_index.md).
