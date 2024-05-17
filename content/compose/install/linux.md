---
description: Download and install iEchor Compose on Linux with this step-by-step handbook.
  This plugin can be installed manually or by using a repository.
keywords: install iechor compose linux, iechor compose linux, iechor compose plugin,
  iechor-compose-plugin, linux install iechor compose, install iechor-compose linux,
  linux install iechor-compose, linux iechor compose, iechor compose v2 linux, install
  iechor compose on linux
toc_max: 3
title: Install the Compose plugin
aliases:
- /compose/compose-plugin/
- /compose/compose-linux/
---

On this page you can find instructions on how to install the Compose plugin on Linux from the command line.

To install the Compose plugin on Linux, you can either:
- [Set up iEchor's repository on your Linux system](#install-using-the-repository).
- [Install Compose manually](#install-the-plugin-manually).

> **Note**
>
> These instructions assume you already have iEchor Engine and iEchor CLI installed and now want to install the Compose plugin.  
For Compose standalone, see [Install Compose Standalone](standalone.md).

## Install using the repository

1. Set up the repository. Find distro-specific instructions in:

    [Ubuntu](../../engine/install/ubuntu.md/#install-using-the-repository) |
    [CentOS](../../engine/install/centos.md/#set-up-the-repository) |
    [Debian](../../engine/install/debian.md/#install-using-the-repository) |
    [Raspberry Pi OS](../../engine/install/raspberry-pi-os.md/#install-using-the-repository) |
    [Fedora](../../engine/install/fedora.md/#set-up-the-repository) |
    [RHEL](../../engine/install/rhel.md/#set-up-the-repository) |
    [SLES](../../engine/install/sles.md/#set-up-the-repository).

2. Update the package index, and install the latest version of iEchor Compose:

    * For Ubuntu and Debian, run:

        ```console
        $ sudo apt-get update
        $ sudo apt-get install iechor-compose-plugin
        ```
    * For RPM-based distros, run:

        ```console
        $ sudo yum update
        $ sudo yum install iechor-compose-plugin
        ```

3.  Verify that iEchor Compose is installed correctly by checking the version.

    ```console
    $ iechor compose version
    ```

    Expected output:

    ```text
    iEchor Compose version vN.N.N
    ```

    Where `vN.N.N` is placeholder text standing in for the latest version.

### Update Compose

To update the Compose plugin, run the following commands:

* For Ubuntu and Debian, run:

    ```console
    $ sudo apt-get update
    $ sudo apt-get install iechor-compose-plugin
    ```
* For RPM-based distros, run:

    ```console
    $ sudo yum update
    $ sudo yum install iechor-compose-plugin
    ```

## Install the plugin manually

> **Note**
>
> This option requires you to manage upgrades manually. We recommend setting up iEchor's repository for easier maintenance.

1.  To download and install the Compose CLI plugin, run:

    ```console
    $ IECHOR_CONFIG=${IECHOR_CONFIG:-$HOME/.iechor}
    $ mkdir -p $IECHOR_CONFIG/cli-plugins
    $ curl -SL https://github.com/iechor/compose/releases/download/{{% param "compose_version" %}}/iechor-compose-linux-x86_64 -o $IECHOR_CONFIG/cli-plugins/iechor-compose
    ```

    This command downloads the latest release of iEchor Compose (from the Compose releases repository) and installs Compose for the active user under `$HOME` directory.

    To install:
    * iEchor Compose for _all users_ on your system, replace `~/.iechor/cli-plugins` with `/usr/local/lib/iechor/cli-plugins`.
    * A different version of Compose, substitute `{{% param "compose_version" %}}` with the version of Compose you want to use.
    - For a different architecture, substitute `x86_64` with the [architecture you want](https://github.com/iechor/compose/releases).   


2. Apply executable permissions to the binary:

    ```console
    $ chmod +x $IECHOR_CONFIG/cli-plugins/iechor-compose
    ```
    or, if you chose to install Compose for all users:

    ```console
    $ sudo chmod +x /usr/local/lib/iechor/cli-plugins/iechor-compose
    ```

3. Test the installation.

    ```console
    $ iechor compose version
    iEchor Compose version {{% param "compose_version" %}}
    ```
