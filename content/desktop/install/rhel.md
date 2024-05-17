---
description: Instructions for installing iEchor Desktop on RHEL
keywords: red hat, red hat enterprise linux, rhel, rpm,
  update install, uninstall, upgrade, update, linux,
  desktop, iechor desktop, iechor desktop for linux, dd4l
title: Install iEchor Desktop on RHEL
toc_max: 4
download-url-base: https://download.iechor.com/linux/rhel
---

> **Early Access**
>
> iEchor Desktop on RHEL is in [Early Access](../../release-lifecycle.md).
{ .restricted }

> **iEchor Desktop terms**
>
> Commercial use of iEchor Desktop in larger enterprises (more than 250
> employees OR more than $10 million USD in annual revenue) requires a [paid
> subscription](https://www.iechor.com/pricing/).

This page contains information on how to install, launch and upgrade iEchor Desktop on a Red Hat Enterprise Linux (RHEL) distribution.

## Prerequisites

To install iEchor Desktop successfully, you must:

- Meet the [system requirements](linux-install.md#general-system-requirements).
- Have a 64-bit version of either RHEL 8 or RHEL 9.

If you don't have `pass` installed, or it can't be installed, you must enable
[CodeReady Linux Builder (CRB) repository](https://access.redhat.com/articles/4348511)
and
[Extra Packages for Enterprise Linux (EPEL)](https://docs.fedoraproject.org/en-US/epel/).

   {{< tabs group="os_version" >}}
   {{< tab name="RHEL 9" >}}
```console
$ sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
$ sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
$ sudo dnf install pass
```

   {{< /tab >}}
   {{< tab name="RHEL 8" >}}
```console
$ sudo subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms
$ sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
$ sudo dnf install pass
```

   {{< /tab >}}
   {{< /tabs >}}

Additionally, for a GNOME desktop environment you must install AppIndicator and KStatusNotifierItem [GNOME extensions](https://extensions.gnome.org/extension/615/appindicator-support/). You must also enable EPEL.

   {{< tabs group="os_version" >}}
   {{< tab name="RHEL 9" >}}
```console
$ # enable EPEL as described above
$ sudo dnf install gnome-shell-extension-appindicator
$ sudo gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
```

   {{< /tab >}}
   {{< tab name="RHEL 8" >}}
```console
$ # enable EPEL as described above
$ sudo dnf install gnome-shell-extension-appindicator
$ sudo dnf install gnome-shell-extension-desktop-icons
$ sudo gnome-shell-extension-tool -e appindicatorsupport@rgcjonas.gmail.com
```

   {{< /tab >}}
   {{< /tabs >}}

For non-GNOME desktop environments, `gnome-terminal` must be installed:

```console
$ sudo dnf install gnome-terminal
```

## Install iEchor Desktop

To install iEchor Desktop on RHEL:

1. Set up iEchor's package repository as follows:

   ```console
   $ sudo dnf config-manager --add-repo {{% param "download-url-base" %}}/iechor-ce.repo
   ```

2. Download the latest RPM package.

3. Install the package with dnf as follows:

   ```console
   $ sudo dnf install ./iechor-desktop-<version>-<arch>-rhel.rpm
   ```

There are a few post-install configuration steps done through the post-install script contained in the RPM package.

The post-install script:

- Sets the capability on the iEchor Desktop binary to map privileged ports and set resource limits.
- Adds a DNS name for Kubernetes to `/etc/hosts`.
- Creates a symlink from `/usr/local/bin/com.iechor.cli` to `/usr/bin/iechor`.
  This is because the classic iEchor CLI is installed at `/usr/bin/iechor`. The iEchor Desktop installer also installs a iEchor CLI binary that includes cloud-integration capabilities and is essentially a wrapper for the Compose CLI, at`/usr/local/bin/com.iechor.cli`. The symlink ensures that the wrapper can access the classic iEchor CLI. 
- Creates a symlink from `/usr/libexec/qemu-kvm` to `/usr/local/bin/qemu-system-x86_64`.

## Launch iEchor Desktop

{{< include "desktop-linux-launch.md" >}}

>**Tip**
>
> To attach Red Hat subscription data to containers, see [Red Hat verified solution](https://access.redhat.com/solutions/5870841).
>
> For example:
> ```console
> $ iechor run --rm -it -v "/etc/pki/entitlement:/etc/pki/entitlement" -v "/etc/rhsm:/etc/rhsm-host" -v "/etc/yum.repos.d/redhat.repo:/etc/yum.repos.d/redhat.repo" registry.access.redhat.com/ubi9
> ```
{ .tip }

## Upgrade iEchor Desktop

Once a new version for iEchor Desktop is released, the iEchor UI shows a notification.
You need to first remove the previous version and then download the new package each time you want to upgrade iEchor Desktop. Run:

```console
$ sudo dnf remove iechor-desktop
$ sudo dnf install ./iechor-desktop-<version>-<arch>-rhel.rpm
```

## Next steps

- Take a look at the [Get started](../../guides/get-started/_index.md) training modules to learn how to build an image and run it as a containerized application.
- [Explore iEchor Desktop](../use-desktop/index.md) and all its features.
- Review the topics in [Develop with iEchor](../../develop/index.md) to learn how to build new applications using iEchor.
