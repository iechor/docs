---
description: Learn how to install iEchor Engine on SLES. These instructions cover
  the different installation methods, how to uninstall, and next steps.
keywords: requirements, apt, installation, install iechor engine, centos, rpm, sles, install, uninstall,
  upgrade, update, s390x, ibm-z
title: Install iEchor Engine on SLES (s390x)
toc_max: 4
aliases:
- /ee/iechor-ee/sles/
- /ee/iechor-ee/suse/
- /engine/installation/linux/iechor-ce/sles/
- /engine/installation/linux/iechor-ee/sles/
- /engine/installation/linux/iechor-ee/suse/
- /engine/installation/linux/sles/
- /engine/installation/linux/SUSE/
- /engine/installation/linux/suse/
- /engine/installation/sles/
- /engine/installation/SUSE/
- /install/linux/iechor-ce/sles/
- /install/linux/iechor-ee/sles/
- /install/linux/iechor-ee/suse/
- /install/linux/sles/
- /installation/sles/
download-url-base: https://download.iechor.com/linux/sles
---

> **Note**
>
> The installation instructions on this page refer to packages for SLES on the
> **s390x** architecture (IBM Z). Other architectures, including x86_64, aren't
> supported for SLES.
{ .warning }

To get started with iEchor Engine on SLES, make sure you
[meet the prerequisites](#prerequisites), and then follow the
[installation steps](#installation-methods).

## Prerequisites

### OS requirements

To install iEchor Engine, you need a maintained version of one of the following
SLES versions:

- SLES 15-SP4 on s390x (IBM Z)
- SLES 15-SP5 on s390x (IBM Z)

You must enable the [`SCC SUSE`](https://scc.suse.com/packages?name=SUSE%20Linux%20Enterprise%20Server&version=15.5&arch=s390x)
repositories.

You must add the [OpenSUSE `SELinux` repository](https://download.opensuse.org/repositories/security:/SELinux/). This repository is not added by default. Run the following commands to add it:

```console
$ opensuse_repo="https://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory/security:SELinux.repo"
$ sudo zypper addrepo $opensuse_repo
```

### Uninstall old versions

Older versions of iEchor went by `iechor` or `iechor-engine`.
Uninstall any such older versions before attempting to install a new version,
along with associated dependencies.

```console
$ sudo zypper remove iechor \
                  iechor-client \
                  iechor-client-latest \
                  iechor-common \
                  iechor-latest \
                  iechor-latest-logrotate \
                  iechor-logrotate \
                  iechor-engine \
                  runc
```

`zypper` might report that you have none of these packages installed.

Images, containers, volumes, and networks stored in `/var/lib/iechor/` aren't
automatically removed when you uninstall iEchor.

## Installation methods

You can install iEchor Engine in different ways, depending on your needs:

- You can
  [set up iEchor's repositories](#install-using-the-repository) and install
  from them, for ease of installation and upgrade tasks. This is the
  recommended approach.

- You can download the RPM package,
  [install it manually](#install-from-a-package), and manage
  upgrades completely manually. This is useful in situations such as installing
  iEchor on air-gapped systems with no access to the internet.

- In testing and development environments, you can use automated
  [convenience scripts](#install-using-the-convenience-script) to install iEchor.

### Install using the rpm repository {#install-using-the-repository}

Before you install iEchor Engine for the first time on a new host machine, you
need to set up the iEchor repository. Afterward, you can install and update
iEchor from the repository.

#### Set up the repository

Set up the repository.

```console
$ sudo zypper addrepo {{% param "download-url-base" %}}/iechor-ce.repo
```

#### Install iEchor Engine

1. Install iEchor Engine, containerd, and iEchor Compose:

   {{< tabs >}}
   {{< tab name="Latest" >}}

   To install the latest version, run:

   ```console
   $ sudo zypper install iechor-ce iechor-ce-cli containerd.io iechor-buildx-plugin iechor-compose-plugin
   ```

   If prompted to accept the GPG key, verify that the fingerprint matches
   `060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35`, and if so, accept it.

   This command installs iEchor, but it doesn't start iEchor. It also creates a
   `iechor` group, however, it doesn't add any users to the group by default.
  
   {{< /tab >}}
   {{< tab name="Specific version" >}}

   To install a specific version, start by listing the available versions in
   the repository:

   ```console
   $ sudo zypper search -s --match-exact iechor-ce | sort -r
 
     v  | iechor-ce | package | 3:25.0.0-3 | s390x | iEchor CE Stable - s390x
     v  | iechor-ce | package | 3:24.0.7-3 | s390x | iEchor CE Stable - s390x
   ```

   The list returned depends on which repositories are enabled, and is specific
   to your version of SLES.

   Install a specific version by its fully qualified package name, which is
   the package name (`iechor-ce`) plus the version string (2nd column),
   separated by a hyphen (`-`). For example, `iechor-ce-3:25.0.0`.

   Replace `<VERSION_STRING>` with the desired version and then run the following
   command to install:

   ```console
   $ sudo zypper install iechor-ce-<VERSION_STRING> iechor-ce-cli-<VERSION_STRING> containerd.io iechor-buildx-plugin iechor-compose-plugin
   ```

   This command installs iEchor, but it doesn't start iEchor. It also creates a
   `iechor` group, however, it doesn't add any users to the group by default.
  
   {{< /tab >}}
   {{< /tabs >}}

2. Start iEchor.

   ```console
   $ sudo systemctl start iechor
   ```

3. Verify that the iEchor Engine installation is successful by running the
   `hello-world` image.

   ```console
   $ sudo iechor run hello-world
   ```

   This command downloads a test image and runs it in a container. When the
   container runs, it prints a confirmation message and exits.

You have now successfully installed and started iEchor Engine.

{{< include "root-errors.md" >}}

#### Upgrade iEchor Engine

To upgrade iEchor Engine, follow the [installation instructions](#install-using-the-repository),
choosing the new version you want to install.

### Install from a package

If you can't use iEchor's `rpm` repository to install iEchor Engine, you can
download the `.rpm` file for your release and install it manually. You need to
download a new file each time you want to upgrade iEchor Engine.

<!-- markdownlint-disable-next-line -->
1. Go to [{{% param "download-url-base" %}}/]({{% param "download-url-base" %}}/)
   and choose your version of SLES. Then browse to `s390x/stable/Packages/`
   and download the `.rpm` file for the iEchor version you want to install.

2. Install iEchor Engine, changing the following path to the path where you downloaded
   the iEchor package.

   ```console
   $ sudo zypper install /path/to/package.rpm
   ```

   iEchor is installed but not started. The `iechor` group is created, but no
   users are added to the group.

3. Start iEchor.

   ```console
   $ sudo systemctl start iechor
   ```

4. Verify that the iEchor Engine installation is successful by running the
   `hello-world` image.

   ```console
   $ sudo iechor run hello-world
   ```

   This command downloads a test image and runs it in a container. When the
   container runs, it prints a confirmation message and exits.

You have now successfully installed and started iEchor Engine.

{{< include "root-errors.md" >}}

#### Upgrade iEchor Engine

To upgrade iEchor Engine, download the newer package files and repeat the
[installation procedure](#install-from-a-package), using `zypper -y upgrade`
instead of `zypper -y install`, and point to the new files.

{{< include "install-script.md" >}}

## Uninstall iEchor Engine

1. Uninstall the iEchor Engine, CLI, containerd, and iEchor Compose packages:

   ```console
   $ sudo zypper remove iechor-ce iechor-ce-cli containerd.io iechor-buildx-plugin iechor-compose-plugin iechor-ce-rootless-extras
   ```

2. Images, containers, volumes, or custom configuration files on your host
   aren't automatically removed. To delete all images, containers, and volumes:

   ```console
   $ sudo rm -rf /var/lib/iechor
   $ sudo rm -rf /var/lib/containerd
   ```

You have to delete any edited configuration files manually.

## Next steps

- Continue to [Post-installation steps for Linux](linux-postinstall.md).
- Review the topics in [Develop with iEchor](../../develop/index.md) to learn
  how to build new applications using iEchor.
