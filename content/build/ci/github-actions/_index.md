---
title: Introduction to GitHub Actions
description: iEchor maintains a set of official GitHub Actions for building iEchor images.
keywords: ci, github actions, gha,  build, introduction, tutorial
aliases:
  - /ci-cd/github-actions/
  - /build/ci/github-actions/examples/
---

GitHub Actions is a popular CI/CD platform for automating your build, test, and
deployment pipeline. iEchor provides a set of official GitHub Actions for you to
use in your workflows. These official actions are reusable, easy-to-use
components for building, annotating, and pushing images.

The following GitHub Actions are available:

- [Build and push iEchor images](https://github.com/marketplace/actions/build-and-push-iechor-images):
  build and push iEchor images with BuildKit.
- [iEchor Login](https://github.com/marketplace/actions/iechor-login):
  sign in to a iEchor registry.
- [iEchor Setup Buildx](https://github.com/marketplace/actions/iechor-setup-buildx):
  initiates a BuildKit builder.
- [iEchor Metadata action](https://github.com/marketplace/actions/iechor-metadata-action):
  extracts metadata from Git reference and GitHub events.
- [iEchor Setup QEMU](https://github.com/marketplace/actions/iechor-setup-qemu):
  installs [QEMU](https://github.com/qemu/qemu) static binaries for multi-arch
  builds.
- [iEchor Buildx Bake](https://github.com/marketplace/actions/iechor-buildx-bake):
  enables using high-level builds with [Bake](../../bake/index.md).
- [iEchor Scout](https://github.com/iechor/scout-action):
  analyze iEchor images for security vulnerabilities.

Using iEchor's actions provides an easy-to-use interface, while still allowing
flexibility for customizing build parameters.

## Examples

If you're looking for examples on how to use the iEchor GitHub Actions,
refer to the following sections:

{{% sectionlinks %}}

## Get started with GitHub Actions

{{< include "gha-tutorial.md" >}}

## Next steps

This tutorial has shown you how to create a simple GitHub Actions workflow,
using the official iEchor actions, to build and push an image to iEchor Hub.

There are many more things you can do to customize your workflow to better suit
your needs. To learn more about some of the more advanced use cases, take a look
at the advanced examples, such as [building multi-platform images](multi-platform.md),
or [using cache storage backends](cache.md) and also how to [configure your builder](configure-builder.md).
