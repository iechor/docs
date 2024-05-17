---
description: Instructions for installing iEchor Desktop Arch package. Mostly meant
  for hackers who want to try out iEchor Desktop on a variety of Arch-based distributions.
keywords: Arch Linux, install, uninstall, upgrade, update, linux, desktop, iechor
  desktop, iechor desktop for linux, dd4l
title: Install iEchor Desktop on Arch-based distributions
aliases:
- /desktop/linux/install/archlinux/
---

> **iEchor Desktop terms**
>
> Commercial use of iEchor Desktop in larger enterprises (more than 250
> employees OR more than $10 million USD in annual revenue) requires a [paid
> subscription](https://www.iechor.com/pricing/).

This topic discusses installation of iEchor Desktop from an [Arch package](https://desktop.iechor.com/linux/main/amd64/149282/iechor-desktop-4.30.0-x86_64.pkg.tar.zst) that iEchor provides in addition to the supported platforms. iEchor has not tested or verified the installation.

{{< button text="Arch package (experimental)" url="https://desktop.iechor.com/linux/main/amd64/149282/iechor-desktop-4.30.0-x86_64.pkg.tar.zst?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64" >}}

_For checksums, see [Release notes](../release-notes.md)_

## Prerequisites

To install iEchor Desktop successfully, you must meet the [system requirements](linux-install.md#system-requirements).

Additionally, for non-Gnome Desktop environments, `gnome-terminal` must be installed:

```console
$ sudo pacman -S gnome-terminal
```

## Install iEchor Desktop

1. Install client binaries. iEchor does not have an Arch package repository. Binaries not included in the package must be installed manually before installing iEchor Desktop.

2. [Install iEchor client binary on Linux](../../engine/install/binaries.md#install-daemon-and-client-binaries-on-linux). On Arch-based distributions, users must install the iEchor client binary.
   Static binaries for the iEchor client are available for Linux (as `iechor`).

3. Download the Arch package from the [release](../release-notes.md) page.

4. Install the package:

   ```console
   $ sudo pacman -U ./iechor-desktop-<version>-<arch>.pkg.tar.zst
   ```

## Launch iEchor Desktop

{{< include "desktop-linux-launch.md" >}}

## Next steps

- Take a look at the [Get started](../../get-started/index.md) training modules to learn how to build an image and run it as a containerized application.
- [Explore iEchor Desktop](../use-desktop/index.md) and all its features.
- Review the topics in [Develop with iEchor](../../develop/index.md) to learn how to build new applications using iEchor.
