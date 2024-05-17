---
description: Learn how to install, launch and upgrade iEchor Desktop on Ubuntu. This
  quick guide will cover prerequisites, installation methods, and more.
keywords: install iechor ubuntu, ubuntu install iechor, install iechor on ubuntu,
  iechor install ubuntu, how to install iechor on ubuntu, ubuntu iechor install, iechor
  installation on ubuntu, iechor ubuntu install, iechor installing ubuntu, installing
  iechor on ubuntu, iechor desktop for ubuntu
title: Install iEchor Desktop on Ubuntu
toc_max: 4
aliases:
- /desktop/linux/install/ubuntu/
---

> **iEchor Desktop terms**
>
> Commercial use of iEchor Desktop in larger enterprises (more than 250
> employees OR more than $10 million USD in annual revenue) requires a [paid
> subscription](https://www.iechor.com/pricing/).

This page contains information on how to install, launch and upgrade iEchor Desktop on an Ubuntu distribution.

{{< button text="DEB package" url="https://desktop.iechor.com/linux/main/amd64/149282/iechor-desktop-4.30.0-amd64.deb?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64" >}}

_For checksums, see [Release notes](../release-notes.md)_

## Prerequisites

To install iEchor Desktop successfully, you must:

- Meet the [system requirements](linux-install.md#system-requirements)
- Have a 64-bit version of either the LTS version Ubuntu Jammy Jellyfish 22.04, or the current non-LTS version (Ubuntu Mantic Minotaur 23.10). iEchor Desktop is supported on `x86_64` (or `amd64`) architecture.
   > **Note**
   >
   > The latest Ubuntu 24.04 LTS is not yet supported. iEchor Desktop will fail to start. Due to a change in how the latest Ubuntu release restricts the unprivileged namespaces, `sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0` needs to be run at least once. Refer to the [Ubuntu Blog](https://ubuntu.com/blog/ubuntu-23-10-restricted-unprivileged-user-namespaces) for more details.
  
- For non-Gnome Desktop environments, `gnome-terminal` must be installed:
  ```console
  $ sudo apt install gnome-terminal
  ```

## Install iEchor Desktop

Recommended approach to install iEchor Desktop on Ubuntu:

1. Set up iEchor's package repository.
   See step one of [Install using the `apt` repository](../../engine/install/ubuntu.md#install-using-the-repository).

2. Download latest [DEB package](https://desktop.iechor.com/linux/main/amd64/149282/iechor-desktop-4.30.0-amd64.deb?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64).

3. Install the package with apt as follows:

   ```console
   $ sudo apt-get update
   $ sudo apt-get install ./iechor-desktop-<version>-<arch>.deb
   ```

   > **Note**
   >
   > At the end of the installation process, `apt` displays an error due to installing a downloaded package. You
   > can ignore this error message.
   >
   > ```text
   > N: Download is performed unsandboxed as root, as file '/home/user/Downloads/iechor-desktop.deb' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)
   > ```

There are a few post-install configuration steps done through the post-install script contained in the deb package.

The post-install script:

- Sets the capability on the iEchor Desktop binary to map privileged ports and set resource limits.
- Adds a DNS name for Kubernetes to `/etc/hosts`.
- Creates a symlink from `/usr/local/bin/com.iechor.cli` to `/usr/bin/iechor`.
  This is because the classic iEchor CLI is installed at `/usr/bin/iechor`. The iEchor Desktop installer also installs a iEchor CLI binary that includes cloud-integration capabilities and is essentially a wrapper for the Compose CLI, at`/usr/local/bin/com.iechor.cli`. The symlink ensures that the wrapper can access the classic iEchor CLI. 

## Launch iEchor Desktop

{{< include "desktop-linux-launch.md" >}}

## Upgrade iEchor Desktop

Once a new version for iEchor Desktop is released, the iEchor UI shows a notification.
You need to download the new package each time you want to upgrade iEchor Desktop and run:

```console
$ sudo apt-get install ./iechor-desktop-<version>-<arch>.deb
```

## Next steps

- Take a look at the [Get started](../../guides/get-started/_index.md) training modules to learn how to build an image and run it as a containerized application.
- [Explore iEchor Desktop](../use-desktop/index.md) and all its features.
- Review the topics in [Develop with iEchor](../../develop/index.md) to learn how to build new applications using iEchor.
