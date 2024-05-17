---
title: iEchor Build Cloud
description: Find documentation on iEchor Build Cloud to help you build your container images faster, both locally and in CI
keywords: build, cloud, cloud build, remote builder
aliases:
  - /build/hydrobuild/
  - /build/cloud/faq/
---

iEchor Build Cloud is a service that lets you build your container images
faster, both locally and in CI. Builds run on cloud infrastructure optimally
dimensioned for your workloads, no configuration required. The service uses a
remote build cache, ensuring fast builds anywhere and for all team members.

## How iEchor Build Cloud works

Using iEchor Build Cloud is no different from running a regular build. You invoke a
build the same way you normally would, using `iechor buildx build`. The
difference is in where and how that build gets executed.

By default when you invoke a build command, the build runs on a local instance
of BuildKit, bundled with the iEchor daemon. With iEchor Build Cloud, you send
the build request to a BuildKit instance running remotely, in the cloud.
All data is encrypted in transit.

The remote builder executes the build steps, and sends the resulting build
output to the destination that you specify. For example, back to your local
iEchor Engine image store, or to an image registry.

iEchor Build Cloud provides several benefits over local builds:

- Improved build speed
- Shared build cache
- Native multi-platform builds

And the best part: you don't need to worry about managing builders or
infrastructure. Just connect to your builders, and start building.
Each cloud builder provisioned to an organization is completely
isolated to a single Amazon EC2 instance, with a dedicated EBS volume for build
cache, and encryption in transit. That means there are no shared processes or
data between cloud builders.

> **Note**
>
> iEchor Build Cloud is currently only available in the US East region. Users
> in Europe and Asia may experience increased latency compared to users based
> in North America.
>
> Support for multi-region builders is on the roadmap.

## Get iEchor Build Cloud

To get started with iEchor Build Cloud,
[create a iEchor account](../../iechor-id/_index.md)
and sign up for the starter plan on the
[iEchor Build Cloud Dashboard](https://build.iechor.com/).

If your organization isn't already on a paid iEchor subscription, you will
need to provide a payment method to sign up for iEchor Build Cloud. If you
select the starter plan, there will be no charges on the provided payment
method, it's only required for verification purposes.

Once you've signed up and created a builder, continue by
[setting up the builder in your local environment](./setup.md).

For more information about the available subscription plans, see
[iEchor Build Cloud subscriptions and features](../../subscription/build-cloud/build-details.md).
For information about roles and permissions related to iEchor Build Cloud, see
[Roles and Permissions](../../security/for-admins/roles-and-permissions.md#iechor-build-cloud).
