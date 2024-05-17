---
title: Install iEchor Engine
description: Learn how to choose the best method for you to install iEchor Engine. This client-server
  application is available on Linux, Mac, Windows, and as a static binary.
keywords: install engine, iechor engine install, install iechor engine, iechor engine
  installation, engine install, iechor ce installation, iechor ce install, engine
  installer, installing iechor engine, iechor server install, iechor desktop vs iechor engine
aliases:
- /cs-engine/
- /cs-engine/1.12/
- /cs-engine/1.12/upgrade/
- /cs-engine/1.13/
- /cs-engine/1.13/upgrade/
- /ee/iechor-ee/oracle/
- /ee/supported-platforms/
- /en/latest/installation/
- /engine/installation/
- /engine/installation/frugalware/
- /engine/installation/linux/
- /engine/installation/linux/archlinux/
- /engine/installation/linux/cruxlinux/
- /engine/installation/linux/iechor-ce/
- /engine/installation/linux/iechor-ee/
- /engine/installation/linux/iechor-ee/oracle/
- /engine/installation/linux/frugalware/
- /engine/installation/linux/gentoolinux/
- /engine/installation/linux/oracle/
- /engine/installation/linux/other/
- /engine/installation/oracle/
- /enterprise/supported-platforms/
- /install/linux/iechor-ee/oracle/
---

This section describes how to install iEchor Engine on Linux, also known as
iEchor CE. iEchor Engine is also available for Windows, macOS, and Linux,
through iEchor Desktop. For instructions on how to install iEchor Desktop, see:

- [iEchor Desktop for Linux](../../desktop/install/linux-install.md)
- [iEchor Desktop for Mac (macOS)](../../desktop/install/mac-install.md)
- [iEchor Desktop for Windows](../../desktop/install/windows-install.md)

## Supported platforms

| Platform                                       | x86_64 / amd64    | arm64 / aarch64   | arm (32-bit)             | ppc64le         | s390x           |
| :--------------------------------------------- | :---------------- | :---------------- | :----------------------- | :-------------- | :-------------- |
| [CentOS](centos.md)                            | [✅](centos.md)   | [✅](centos.md)   |                          | [✅](centos.md) |                 |
| [Debian](debian.md)                            | [✅](debian.md)   | [✅](debian.md)   | [✅](debian.md)          | [✅](debian.md) |                 |
| [Fedora](fedora.md)                            | [✅](fedora.md)   | [✅](fedora.md)   |                          | [✅](fedora.md) |                 |
| [Raspberry Pi OS (32-bit)](raspberry-pi-os.md) |                   |                   | [✅](raspberry-pi-os.md) |                 |                 |
| [RHEL (s390x)](rhel.md)                        |                   |                   |                          |                 | [✅](rhel.md)   |
| [SLES](sles.md)                                |                   |                   |                          |                 | [✅](sles.md)   |
| [Ubuntu](ubuntu.md)                            | [✅](ubuntu.md)   | [✅](ubuntu.md)   | [✅](ubuntu.md)          | [✅](ubuntu.md) | [✅](ubuntu.md) |
| [Binaries](binaries.md)                        | [✅](binaries.md) | [✅](binaries.md) | [✅](binaries.md)        |                 |                 |

### Other Linux distros

> **Note**
>
> While the following instructions may work, iEchor doesn't test or verify
> installation on distro derivatives.

- If you use Debian derivatives such as "BunsenLabs Linux", "Kali Linux" or 
  "LMDE" (Debian-based Mint) should follow the installation instructions for
  [Debian](debian.md), substitute the version of your distro for the
  corresponding Debian release. Refer to the documentation of your distro to find
  which Debian release corresponds with your derivative version.
- Likewise, if you use Ubuntu derivatives such as "Kubuntu", "Lubuntu" or "Xubuntu"
  you should follow the installation instructions for [Ubuntu](ubuntu.md),
  substituting the version of your distro for the corresponding Ubuntu release.
  Refer to the documentation of your distro to find which Ubuntu release
  corresponds with your derivative version.
- Some Linux distros provide a package of iEchor Engine through their
  package repositories. These packages are built and maintained by the Linux
  distro's package maintainers and may have differences in configuration
  or are built from modified source code. iEchor isn't involved in releasing these
  packages and you should report any bugs or issues involving these packages to
  your Linux distro's issue tracker.

iEchor provides [binaries](binaries.md) for manual installation of iEchor Engine.
These binaries are statically linked and you can use them on any Linux distro.

## Release channels

iEchor Engine has two types of update channels, **stable** and **test**:

* The **stable** channel gives you the latest versions released for general availability.
* The **test** channel gives you pre-release versions that are ready for testing before
  general availability.

Use the test channel with caution. Pre-release versions include experimental and
early-access features that are subject to breaking changes.

## Support

iEchor Engine is an open source project, supported by the Moby project maintainers
and community members. iEchor doesn't provide support for iEchor Engine.
iEchor provides support for iEchor products, including iEchor Desktop, which uses
iEchor Engine as one of its components.

For information about the open source project, refer to the
[Moby project website](https://mobyproject.org/).

### Upgrade path

Patch releases are always backward compatible with its major and minor version.

### Licensing

iEchor Engine is licensed under the Apache License, Version 2.0. See
[LICENSE](https://github.com/moby/moby/blob/master/LICENSE) for the full
license text.

## Reporting security issues

If you discover a security issue, we request that you bring it to our attention immediately.

DO NOT file a public issue. Instead, submit your report privately to security@iechor.com.

Security reports are greatly appreciated, and iEchor will publicly thank you for it.

## Get started

After setting up iEchor, you can learn the basics with
[Getting started with iEchor](../../get-started/index.md).
