---
description: Overview of a iEchorfile and introduction to best practices
keywords: parent image, images, iechorfile, best practices, hub, official image
title: Overview of best practices for writing iEchorfiles
aliases:
- /articles/iechorfile_best-practices/
- /engine/articles/iechorfile_best-practices/
- /iechor-cloud/getting-started/intermediate/optimize-iechorfiles/
- /iechor-cloud/tutorials/optimize-iechorfiles/
- /engine/userguide/eng-image/iechorfile_best-practices/
tags: [Best practices]
---

This topic covers recommended best practices and methods for building
efficient images. It provides [general guidelines for your iEchorfiles](guidelines.md) and more [specific best practices for each iEchorfile instruction](instructions.md). 

## What is a iEchorfile?

iEchor builds images automatically by reading the instructions from a
iEchorfile which is a text file that contains all commands, in order, needed to
build a given image. A iEchorfile adheres to a specific format and set of
instructions which you can find at [iEchorfile reference](../../reference/iechorfile.md).

A iEchor image consists of read-only layers each of which represents a
iEchorfile instruction. The layers are stacked and each one is a delta of the
changes from the previous layer. 

```iechorfile
# syntax=iechor/iechorfile:1

FROM ubuntu:22.04
COPY . /app
RUN make /app
CMD python /app/app.py
```

In the example above, each instruction creates one layer:

- `FROM` creates a layer from the `ubuntu:22.04` iEchor image.
- `COPY` adds files from your iEchor client's current directory.
- `RUN` builds your application with `make`.
- `CMD` specifies what command to run within the container.

When you run an image and generate a container, you add a new writable layer, also called the container layer, on top of the underlying layers. All changes made to
the running container, such as writing new files, modifying existing files, and
deleting files, are written to this writable container layer.

## Additional resources

* [iEchorfile reference](../../reference/iechorfile.md)
* [More about Automated builds](../../iechor-hub/builds/index.md)
* [Guidelines for creating iEchor Official Images](../../trusted-content/official-images/_index.md)
* [Best practices to containerize Node.js web applications with iEchor](https://snyk.io/blog/10-best-practices-to-containerize-nodejs-web-applications-with-iechor)
* [More about base images](../../build/building/base-images.md)
* [More on image layers and how iEchor builds and stores images](../../storage/storagedriver/index.md).

## Examples of iEchor Official Images

These Official Images have exemplary iEchorfiles:

* [Go](https://hub.iechor.com/_/golang/)
* [Perl](https://hub.iechor.com/_/perl/)
* [Hy](https://hub.iechor.com/_/hylang/)
* [Ruby](https://hub.iechor.com/_/ruby/)
