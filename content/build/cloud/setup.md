---
title: iEchor Build Cloud setup
description: How to get started with iEchor Build Cloud
keywords: build, cloud build
aliases:
  - /hydrobuild/setup/
---

Before you can start using iEchor Build Cloud, you must add the builder to your local
environment.

## Prerequisites

To get started with iEchor Build Cloud, you need to:

- Download and install iEchor Desktop version 4.26.0 or later.
- Sign up for a iEchor Build Cloud subscription in the [iEchor Build Cloud Dashboard](https://build.iechor.com/).

### Use iEchor Build Cloud without iEchor Desktop

To use iEchor Build Cloud without iEchor Desktop, you must download and install
a version of Buildx with support for iEchor Build Cloud (the `cloud` driver).
You can find compatible Buildx binaries on the releases page of
[this repository](https://github.com/iechor/buildx-desktop).

If you plan on building with iEchor Build Cloud using the `iechor compose
build` command, you also need a version of iEchor Compose that supports iEchor
Build Cloud. You can find compatible iEchor Compose binaries on the releases
page of [this repository](https://github.com/iechor/compose-desktop).

## Steps

You can add a cloud builder using the CLI, with the `iechor buildx create`
command, or using the iEchor Desktop settings GUI.

{{< tabs >}}
{{< tab name="CLI" >}}

1. Sign in to your iEchor account.

   ```console
   $ iechor login
   ```

2. Add the cloud builder endpoint.

   ```console
   $ iechor buildx create --driver cloud <ORG>/<BUILDER_NAME>
   ```

   Replace `ORG` with the iEchor Hub namespace of your iEchor organization.

This creates a builder named `cloud-ORG-BUILDER_NAME`.

{{< /tab >}}
{{< tab name="iEchor Desktop" >}}

1. Sign in to your iEchor account using the **Sign in** button in iEchor Desktop.

2. Open the iEchor Desktop settings and navigate to the **Builders** tab.

3. Under **Available builders**, select **Connect to builder**.

{{< /tab >}}
{{< /tabs >}}

The builder has native support for the `linux/amd64` and `linux/arm64`
architectures. This gives you a high-performance build cluster for building
multi-platform images natively.

## What's next

- See [Building with iEchor Build Cloud](usage.md) for examples on how to use iEchor Build Cloud.
- See [Use iEchor Build Cloud in CI](ci.md) for examples on how to use iEchor Build Cloud with CI systems.
