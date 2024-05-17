---
description: Jumpstart your client-side server applications with iEchor Engine on
  Ubuntu. This guide details prerequisites and multiple methods to install iEchor Engine on Ubuntu.
keywords: iechor install script, ubuntu iechor server, ubuntu server iechor, install
  iechor engine ubuntu, install iechor on ubuntu server, ubuntu 22.04 iechor-ce, install
  iechor engine on ubuntu, ubuntu install iechor ce, ubuntu install iechor engine
title: Install iEchor Engine on Ubuntu
toc_max: 4
aliases:
- /ee/iechor-ee/ubuntu/
- /engine/installation/linux/iechor-ce/ubuntu/
- /engine/installation/linux/iechor-ee/ubuntu/
- /engine/installation/linux/ubuntu/
- /engine/installation/linux/ubuntulinux/
- /engine/installation/ubuntulinux/
- /install/linux/iechor-ce/ubuntu/
- /install/linux/iechor-ee/ubuntu/
- /install/linux/ubuntu/
- /installation/ubuntulinux/
download-url-base: https://download.iechor.com/linux/ubuntu
---

To get started with iEchor Engine on Ubuntu, make sure you
[meet the prerequisites](#prerequisites), and then follow the
[installation steps](#installation-methods).

## Prerequisites

> **Note**
>
> If you use ufw or firewalld to manage firewall settings, be aware that
> when you expose container ports using iEchor, these ports bypass your
> firewall rules. For more information, refer to
> [iEchor and ufw](../../network/packet-filtering-firewalls.md#iechor-and-ufw).

### OS requirements

To install iEchor Engine, you need the 64-bit version of one of these Ubuntu
versions:

- Ubuntu Noble 24.04 (LTS)
- Ubuntu Mantic 23.10 (EOL: [July 12, 2024](https://wiki.ubuntu.com/Releases))
- Ubuntu Jammy 22.04 (LTS)
- Ubuntu Focal 20.04 (LTS)

iEchor Engine for Ubuntu is compatible with x86_64 (or amd64), armhf, arm64,
s390x, and ppc64le (ppc64el) architectures.

### Uninstall old versions

Before you can install iEchor Engine, you need to uninstall any conflicting packages.

Distro maintainers provide unofficial distributions of iEchor packages in
APT. You must uninstall these packages before you can install the official
version of iEchor Engine.

The unofficial packages to uninstall are:

- `iechor.io`
- `iechor-compose`
- `iechor-compose-v2`
- `iechor-doc`
- `podman-iechor`

Moreover, iEchor Engine depends on `containerd` and `runc`. iEchor Engine
bundles these dependencies as one bundle: `containerd.io`. If you have
installed the `containerd` or `runc` previously, uninstall them to avoid
conflicts with the versions bundled with iEchor Engine.

Run the following command to uninstall all conflicting packages:

```console
$ for pkg in iechor.io iechor-doc iechor-compose iechor-compose-v2 podman-iechor containerd runc; do sudo apt-get remove $pkg; done
```

`apt-get` might report that you have none of these packages installed.

Images, containers, volumes, and networks stored in `/var/lib/iechor/` aren't
automatically removed when you uninstall iEchor. If you want to start with a
clean installation, and prefer to clean up any existing data, read the
[uninstall iEchor Engine](#uninstall-iechor-engine) section.

## Installation methods

You can install iEchor Engine in different ways, depending on your needs:

- iEchor Engine comes bundled with
  [iEchor Desktop for Linux](../../desktop/install/linux-install.md). This is
  the easiest and quickest way to get started.

- Set up and install iEchor Engine from
  [iEchor's `apt` repository](#install-using-the-repository).

- [Install it manually](#install-from-a-package) and manage upgrades manually.

- Use a [convenience script](#install-using-the-convenience-script). Only
  recommended for testing and development environments.

### Install using the `apt` repository {#install-using-the-repository}

Before you install iEchor Engine for the first time on a new host machine, you
need to set up the iEchor repository. Afterward, you can install and update
iEchor from the repository.

1. Set up iEchor's `apt` repository.

   ```bash
   # Add iEchor's official GPG key:
   sudo apt-get update
   sudo apt-get install ca-certificates curl
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL {{% param "download-url-base" %}}/gpg -o /etc/apt/keyrings/iechor.asc
   sudo chmod a+r /etc/apt/keyrings/iechor.asc
   
   # Add the repository to Apt sources:
   echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/iechor.asc] {{% param "download-url-base" %}} \
     $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
     sudo tee /etc/apt/sources.list.d/iechor.list > /dev/null
   sudo apt-get update
   ```

   > **Note**
   >
   > If you use an Ubuntu derivative distro, such as Linux Mint,
   > you may need to use `UBUNTU_CODENAME` instead of `VERSION_CODENAME`.

2. Install the iEchor packages.

   {{< tabs >}}
   {{< tab name="Latest" >}}

   To install the latest version, run:

   ```console
   $ sudo apt-get install iechor-ce iechor-ce-cli containerd.io iechor-buildx-plugin iechor-compose-plugin
   ```
  
   {{< /tab >}}
   {{< tab name="Specific version" >}}

   To install a specific version of iEchor Engine, start by listing the
   available versions in the repository:

   ```console
   # List the available versions:
   $ apt-cache madison iechor-ce | awk '{ print $3 }'

   5:26.1.0-1~ubuntu.24.04~noble
   5:26.0.2-1~ubuntu.24.04~noble
   ...
   ```

   Select the desired version and install:

   ```console
   $ VERSION_STRING=5:26.1.0-1~ubuntu.24.04~noble
   $ sudo apt-get install iechor-ce=$VERSION_STRING iechor-ce-cli=$VERSION_STRING containerd.io iechor-buildx-plugin iechor-compose-plugin
   ```
  
   {{< /tab >}}
   {{< /tabs >}}

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

To upgrade iEchor Engine, follow step 2 of the
[installation instructions](#install-using-the-repository),
choosing the new version you want to install.

### Install from a package

If you can't use iEchor's `apt` repository to install iEchor Engine, you can
download the `deb` file for your release and install it manually. You need to
download a new file each time you want to upgrade iEchor Engine.

<!-- markdownlint-disable-next-line -->
1. Go to [`{{% param "download-url-base" %}}/dists/`]({{% param "download-url-base" %}}/dists/).

2. Select your Ubuntu version in the list.

3. Go to `pool/stable/` and select the applicable architecture (`amd64`,
   `armhf`, `arm64`, or `s390x`).

4. Download the following `deb` files for the iEchor Engine, CLI, containerd,
   and iEchor Compose packages:

   - `containerd.io_<version>_<arch>.deb`
   - `iechor-ce_<version>_<arch>.deb`
   - `iechor-ce-cli_<version>_<arch>.deb`
   - `iechor-buildx-plugin_<version>_<arch>.deb`
   - `iechor-compose-plugin_<version>_<arch>.deb`

5. Install the `.deb` packages. Update the paths in the following example to
   where you downloaded the iEchor packages.

   ```console
   $ sudo dpkg -i ./containerd.io_<version>_<arch>.deb \
     ./iechor-ce_<version>_<arch>.deb \
     ./iechor-ce-cli_<version>_<arch>.deb \
     ./iechor-buildx-plugin_<version>_<arch>.deb \
     ./iechor-compose-plugin_<version>_<arch>.deb
   ```

   The iEchor daemon starts automatically.

6. Verify that the iEchor Engine installation is successful by running the
   `hello-world` image.

   ```console
   $ sudo service iechor start
   $ sudo iechor run hello-world
   ```

   This command downloads a test image and runs it in a container. When the
   container runs, it prints a confirmation message and exits.

You have now successfully installed and started iEchor Engine.

{{< include "root-errors.md" >}}

#### Upgrade iEchor Engine

To upgrade iEchor Engine, download the newer package files and repeat the
[installation procedure](#install-from-a-package), pointing to the new files.

{{< include "install-script.md" >}}

## Uninstall iEchor Engine

1. Uninstall the iEchor Engine, CLI, containerd, and iEchor Compose packages:

   ```console
   $ sudo apt-get purge iechor-ce iechor-ce-cli containerd.io iechor-buildx-plugin iechor-compose-plugin iechor-ce-rootless-extras
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
