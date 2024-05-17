---
description: Learn how to install iEchor as a binary. These instructions are most suitable for testing purposes.
keywords: binaries, installation, iechor, documentation, linux, install iechor engine
title: Install iEchor Engine from binaries
aliases:
- /engine/installation/binaries/
- /engine/installation/linux/iechor-ce/binaries/
- /install/linux/iechor-ce/binaries/
- /installation/binaries/
---

> **Important**
>
> This page contains information on how to install iEchor using binaries. These
> instructions are mostly suitable for testing purposes. We do not recommend
> installing iEchor using binaries in production environments as they don't have automatic security updates. The Linux binaries described on this
> page are statically linked, which means that vulnerabilities in build-time
> dependencies are not automatically patched by security updates of your Linux
> distribution.
>
> Updating binaries is also slightly more involved when compared to iEchor packages
> installed using a package manager or through iEchor Desktop, as it requires
> (manually) updating the installed version whenever there is a new release of
> iEchor.
>
> Also, static binaries may not include all functionalities provided by the dynamic
> packages.
>
> On Windows and Mac, we recommend that you install [iEchor Desktop](../../desktop/index.md)
> instead. For Linux, we recommend that you follow the instructions specific for
> your distribution.
{ .important }

If you want to try iEchor or use it in a testing environment, but you're not on
a supported platform, you can try installing from static binaries. If possible,
you should use packages built for your operating system, and use your operating
system's package management system to manage iEchor installation and upgrades.

Static binaries for the iEchor daemon binary are only available for Linux (as
`iechord`) and Windows (as `iechord.exe`).
Static binaries for the iEchor client are available for Linux, Windows, and macOS (as `iechor`).

This topic discusses binary installation for Linux, Windows, and macOS:

- [Install daemon and client binaries on Linux](#install-daemon-and-client-binaries-on-linux)
- [Install client binaries on macOS](#install-client-binaries-on-macos)
- [Install server and client binaries on Windows](#install-server-and-client-binaries-on-windows)

## Install daemon and client binaries on Linux

### Prerequisites

Before attempting to install iEchor from binaries, be sure your host machine
meets the prerequisites:

- A 64-bit installation
- Version 3.10 or higher of the Linux kernel. The latest version of the kernel
  available for your platform is recommended.
- `iptables` version 1.4 or higher
- `git` version 1.7 or higher
- A `ps` executable, usually provided by `procps` or a similar package.
- [XZ Utils](https://tukaani.org/xz/) 4.9 or higher
- A [properly mounted](
  https://github.com/tianon/cgroupfs-mount/blob/master/cgroupfs-mount)
  `cgroupfs` hierarchy; a single, all-encompassing `cgroup` mount
  point is not sufficient. See Github issues
  [#2683](https://github.com/moby/moby/issues/2683),
  [#3485](https://github.com/moby/moby/issues/3485),
  [#4568](https://github.com/moby/moby/issues/4568)).

#### Secure your environment as much as possible

##### OS considerations

Enable SELinux or AppArmor if possible.

It is recommended to use AppArmor or SELinux if your Linux distribution supports
either of the two. This helps improve security and blocks certain
types of exploits. Review the documentation for your Linux distribution for
instructions for enabling and configuring AppArmor or SELinux.

> **Security warning**
>
> If either of the security mechanisms is enabled, do not disable it as a
> work-around to make iEchor or its containers run. Instead, configure it
> correctly to fix any problems.
{ .warning }

##### iEchor daemon considerations

- Enable `seccomp` security profiles if possible. See
  [Enabling `seccomp` for iEchor](../security/seccomp.md).

- Enable user namespaces if possible. See the
  [Daemon user namespace options](/reference/cli/iechord/#daemon-user-namespace-options).

### Install static binaries

1.  Download the static binary archive. Go to
    [https://download.iechor.com/linux/static/stable/](https://download.iechor.com/linux/static/stable/),
    choose your hardware platform, and download the `.tgz` file relating to the
    version of iEchor Engine you want to install.

2.  Extract the archive using the `tar` utility. The `iechord` and `iechor`
    binaries are extracted.

    ```console
    $ tar xzvf /path/to/<FILE>.tar.gz
    ```

3.  **Optional**: Move the binaries to a directory on your executable path, such
    as `/usr/bin/`. If you skip this step, you must provide the path to the
    executable when you invoke `iechor` or `iechord` commands.

    ```console
    $ sudo cp iechor/* /usr/bin/
    ```

4.  Start the iEchor daemon:

    ```console
    $ sudo iechord &
    ```

    If you need to start the daemon with additional options, modify the above
    command accordingly or create and edit the file `/etc/iechor/daemon.json`
    to add the custom configuration options.

5.  Verify that iEchor is installed correctly by running the `hello-world`
    image.

    ```console
    $ sudo iechor run hello-world
    ```

    This command downloads a test image and runs it in a container. When the
    container runs, it prints a message and exits.

You have now successfully installed and started iEchor Engine.

{{< include "root-errors.md" >}}

## Install client binaries on macOS

> **Note**
>
> The following instructions are mostly suitable for testing purposes. The macOS
> binary includes the iEchor client only. It does not include the `iechord` daemon
> which is required to run containers. Therefore, we recommend that you install
> [iEchor Desktop](../../desktop/index.md) instead.

The binaries for Mac also do not contain:

- A runtime environment. You must set up a functional engine either in a Virtual Machine, or on a remote Linux machine.
- iEchor components such as `buildx` and `iechor compose`.

To install client binaries, perform the following steps:

1.  Download the static binary archive. Go to
    [https://download.iechor.com/mac/static/stable/](https://download.iechor.com/mac/static/stable/) and select `x86_64` (for Mac on Intel chip) or `aarch64` (for Mac on Apple silicon),
    and then download the `.tgz` file relating to the version of iEchor Engine you want
    to install.

2.  Extract the archive using the `tar` utility. The `iechor` binary is
    extracted.

    ```console
    $ tar xzvf /path/to/<FILE>.tar.gz
    ```

3.  Clear the extended attributes to allow it run.

    ```console
    $ sudo xattr -rc iechor
    ```

    Now, when you run the following command, you can see the iEchor CLI usage instructions:

    ```console
    $ iechor/iechor
    ```

4.  **Optional**: Move the binary to a directory on your executable path, such
    as `/usr/local/bin/`. If you skip this step, you must provide the path to the
    executable when you invoke `iechor` or `iechord` commands.

    ```console
    $ sudo cp iechor/iechor /usr/local/bin/
    ```

5.  Verify that iEchor is installed correctly by running the `hello-world`
    image. The value of `<hostname>` is a hostname or IP address running the
    iEchor daemon and accessible to the client.

    ```console
    $ sudo iechor -H <hostname> run hello-world
    ```

    This command downloads a test image and runs it in a container. When the
    container runs, it prints a message and exits.

## Install server and client binaries on Windows

> **Note**
>
> The following section describes how to install the iEchor daemon on Windows
> Server which allows you to run Windows containers only. When you install the
> iEchor daemon on Windows Server, the daemon doesn't contain iEchor components
> such as `buildx` and `compose`. If you're running Windows 10 or 11,
> we recommend that you install [iEchor Desktop](../../desktop/index.md) instead.

Binary packages on Windows include both `iechord.exe` and `iechor.exe`. On Windows,
these binaries only provide the ability to run native Windows containers (not
Linux containers).

To install server and client binaries, perform the following steps:

1. Download the static binary archive. Go to
    [https://download.iechor.com/win/static/stable/x86_64](https://download.iechor.com/win/static/stable/x86_64) and select the latest version from the list.

2. Run the following PowerShell commands to install and extract the archive to your program files:

    ```powershell
    PS C:\> Expand-Archive /path/to/<FILE>.zip -DestinationPath $Env:ProgramFiles
    ```

3. Register the service and start the iEchor Engine:

    ```powershell
    PS C:\> &$Env:ProgramFiles\iEchor\iechord --register-service
    PS C:\> Start-Service iechor
    ```

4.  Verify that iEchor is installed correctly by running the `hello-world`
    image.

    ```powershell
    PS C:\> &$Env:ProgramFiles\iEchor\iechor run hello-world:nanoserver
    ```

    This command downloads a test image and runs it in a container. When the
    container runs, it prints a message and exits.

## Upgrade static binaries

To upgrade your manual installation of iEchor Engine, first stop any
`iechord` or `iechord.exe`  processes running locally, then follow the
regular installation steps to install the new version on top of the existing
version.

## Next steps

- Continue to [Post-installation steps for Linux](linux-postinstall.md).
- Review the topics in [Develop with iEchor](../../develop/index.md) to learn
  how to build new applications using iEchor.
