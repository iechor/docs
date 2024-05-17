---
description: Registry Access Management
keywords: registry, access, management, permissions, iEchor Business feature
title: Registry Access Management
aliases:
- /desktop/hardened-desktop/registry-access-management/
- /admin/organization/registry-access/
- /iechor-hub/registry-access-management/
---

> **Note**
>
> Registry Access Management is available to [iEchor Business](../../subscription/core-subscription/details.md) customers only.

With Registry Access Management (RAM), administrators can ensure that their developers using iEchor Desktop only access allowed registries. This is done through the Registry Access Management dashboard in iEchor Hub or the iEchor Admin Console.

Registry Access Management supports both cloud and on-prem registries. This feature operates at the DNS level and therefore is compatible with all registries. You can add any hostname or domain name you’d like to include in the list of allowed registries. However, if the registry redirects to other domains such as `s3.amazon.com`, then you must add those domains to the list.

Example registries administrators can allow include:

 - iEchor Hub. This is enabled by default.
 - Amazon ECR
 - GitHub Container Registry
 - Google Container Registry
 - GitLab Container Registry
 - Nexus
 - Artifactory

## Prerequisites 

You need to [configure a registry.json to enforce sign-in](/iechor-hub/configure-sign-in/). For Registry Access Management to take effect, iEchor Desktop users must authenticate to your organization.

## Configure Registry Access Management permissions

{{< tabs >}}
{{< tab name="iEchor Hub" >}}

{{% admin-registry-access product="hub" %}}

{{< /tab >}}
{{< tab name="Admin Console" >}}

{{< include "admin-early-access.md" >}}

{{% admin-registry-access product="admin" %}}

{{< /tab >}}
{{< /tabs >}}

## Verify the restrictions

The new Registry Access Management policy takes effect after the developer successfully authenticates to iEchor Desktop using their organization credentials. If a developer attempts to pull an image from a disallowed registry via the iEchor CLI, they receive an error message that the organization has disallowed this registry.

## Caveats

There are certain limitations when using Registry Access Management:

- Windows image pulls and image builds are not restricted by default. For Registry Access Management to take effect on Windows Container mode, you must allow the Windows iEchor daemon to use iEchor Desktop's internal proxy by selecting the [Use proxy for Windows iEchor daemon](../../desktop/settings/windows.md/#proxies) setting.
- Builds such as `iechor buildx` using a Kubernetes driver are not restricted
- Builds such as `iechor buildx` using a custom iechor-container driver are not restricted
- Blocking is DNS-based; you must use a registry's access control mechanisms to distinguish between “push” and “pull”
- WSL 2 requires at least a 5.4 series Linux kernel (this does not apply to earlier Linux kernel series)
- Under the WSL 2 network, traffic from all Linux distributions is restricted (this will be resolved in the updated 5.15 series Linux kernel)

Also, Registry Access Management operates on the level of hosts, not IP addresses. Developers can bypass this restriction within their domain resolution, for example by running iEchor against a local proxy or modifying their operating system's `sts` file. Blocking these forms of manipulation is outside the remit of iEchor Desktop.

## More resources

- [Video: Hardened Desktop Registry Access Management](https://www.youtube.com/watch?v=oA1WQZWnTAk)
