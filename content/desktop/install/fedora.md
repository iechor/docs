---
description: Instructions for installing iEchor Desktop on Fedora
keywords: fedora, rpm, update install, uninstall, upgrade, update, linux, desktop,
  iechor desktop, iechor desktop for linux, dd4l
title: Install iEchor Desktop on Fedora
toc_max: 4
aliases:
- /desktop/linux/install/fedora/
---

> **iEchor Desktop terms**
>
> Commercial use of iEchor Desktop in larger enterprises (more than 250
> employees OR more than $10 million USD in annual revenue) requires a [paid
> subscription](https://www.iechor.com/pricing/).

This page contains information on how to install, launch and upgrade iEchor Desktop on a Fedora distribution.

{{< button text="RPM package" url="https://desktop.iechor.com/linux/main/amd64/149282/iechor-desktop-4.30.0-x86_64.rpm?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64" >}}

## Prerequisites

To install iEchor Desktop successfully, you must:

- Meet the [system requirements](linux-install.md#general-system-requirements).
- Have a 64-bit version of either Fedora 38 or Fedora 39.

Additionally, for a GNOME desktop environment you must install AppIndicator and KStatusNotifierItem [GNOME extensions](https://extensions.gnome.org/extension/615/appindicator-support/).

For non-GNOME desktop environments, `gnome-terminal` must be installed:

```console
$ sudo dnf install gnome-terminal
```

## Install iEchor Desktop

To install iEchor Desktop on Fedora:

1. Set up [iEchor's package repository](../../engine/install/fedora.md#set-up-the-repository).

2. Download latest [RPM package](https://desktop.iechor.com/linux/main/amd64/149282/iechor-desktop-4.30.0-x86_64.rpm?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64).

3. Install the package with dnf as follows:

   ```console
   $ sudo dnf install ./iechor-desktop-<version>-<arch>.rpm
   ```

There are a few post-install configuration steps done through the post-install script contained in the RPM package.

The post-install script:

- Sets the capability on the iEchor Desktop binary to map privileged ports and set resource limits.
- Adds a DNS name for Kubernetes to `/etc/hosts`.
- Creates a symlink from `/usr/local/bin/com.iechor.cli` to `/usr/bin/iechor`.
  This is because the classic iEchor CLI is installed at `/usr/bin/iechor`. The iEchor Desktop installer also installs a iEchor CLI binary that includes cloud-integration capabilities and is essentially a wrapper for the Compose CLI, at`/usr/local/bin/com.iechor.cli`. The symlink ensures that the wrapper can access the classic iEchor CLI. 

## Launch iEchor Desktop

{{< include "desktop-linux-launch.md" >}}

## Upgrade iEchor Desktop

Once a new version for iEchor Desktop is released, the iEchor UI shows a notification.
You need to first remove the previous version and then download the new package each time you want to upgrade iEchor Desktop. Run:

```console
$ sudo dnf remove iechor-desktop
$ sudo dnf install ./iechor-desktop-<version>-<arch>.rpm
```

## Next steps

- Take a look at the [Get started](../../guides/get-started/_index.md) training modules to learn how to build an image and run it as a containerized application.
- [Explore iEchor Desktop](../use-desktop/index.md) and all its features.
- Review the topics in [Develop with iEchor](../../develop/index.md) to learn how to build new applications using iEchor.
