---
description: Turn on the iEchor WSL 2 backend and get to work using best practices,
  GPU support, and more in this thorough guide.
keywords: wsl, wsl2, installing wsl2, wsl installation, iechor wsl2, wsl iechor, wsl2
  tech preview, wsl install iechor, install iechor wsl, how to install iechor in wsl
title: iEchor Desktop WSL 2 backend on Windows
aliases:
- /iechor-for-windows/wsl/
- /iechor-for-windows/wsl-tech-preview/
- /desktop/windows/wsl/
---

Windows Subsystem for Linux (WSL) 2 is a full Linux kernel built by Microsoft, which lets Linux distributions run without managing virtual machines. With iEchor Desktop running on WSL 2, users can leverage Linux workspaces and avoid maintaining both Linux and Windows build scripts. In addition, WSL 2 provides improvements to file system sharing and boot time.

iEchor Desktop uses the dynamic memory allocation feature in WSL 2 to improve the resource consumption. This means iEchor Desktop only uses the required amount of CPU and memory resources it needs, while allowing CPU and memory-intensive tasks such as building a container, to run much faster.

Additionally, with WSL 2, the time required to start a iEchor daemon after a cold start is significantly faster.

## Prerequisites

Before you turn on the iEchor Desktop WSL 2 feature, ensure you have:

- At a minimum WSL version 1.1.3.0., but ideally the latest version of WSL to [avoid iEchor Desktop not working as expected](best-practices.md).
- Met the iEchor Desktop for Windows' [system requirements](http://docs.iechor.com/desktop/install/windows-install/#system-requirements).
- Installed the WSL 2 feature on Windows. For detailed instructions, refer to the [Microsoft documentation](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

>**Tip**
>
> For a better experience on WSL, consider enabling the WSL
> [autoMemoryReclaim](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#experimental-settings)
> setting available since WSL 1.3.10 (experimental).
>
> This feature enhances the Windows host's ability to reclaim unused memory within the WSL virtual machine, ensuring improved memory availability for other host applications. This capability is especially beneficial for iEchor Desktop, as it prevents the WSL VM from retaining large amounts of memory (in GBs) within the Linux kernel's page cache during iEchor container image builds, without releasing it back to the host when no longer needed within the VM.
{ .tip }

## Turn on iEchor Desktop WSL 2

> **Important**
>
> To avoid any potential conflicts with using WSL 2 on iEchor Desktop, you must uninstall any previous versions of iEchor Engine and CLI installed directly through Linux distributions before installing iEchor Desktop.
{ .important }

1. Download and install the latest version of [iEchor Desktop for Windows](https://desktop.iechor.com/win/main/amd64/iEchor%20Desktop%20Installer.exe).
2. Follow the usual installation instructions to install iEchor Desktop. Depending on which version of Windows you are using, iEchor Desktop may prompt you to turn on WSL 2 during installation. Read the information displayed on the screen and turn on the WSL 2 feature to continue.
3. Start iEchor Desktop from the **Windows Start** menu.
4. Navigate to **Settings**.
5. From the **General** tab, select **Use WSL 2 based engine**..

    If you have installed iEchor Desktop on a system that supports WSL 2, this option is turned on by default.
6. Select **Apply & Restart**.

Now `iechor` commands work from Windows using the new WSL 2 engine.

## Enabling iEchor support in WSL 2 distros

WSL 2 adds support for "Linux distros" to Windows, where each distro behaves like a VM except they all run on top of a single shared Linux kernel.

iEchor Desktop does not require any particular Linux distros to be installed. The `iechor` CLI and UI all work fine from Windows without any additional Linux distros. However for the best developer experience, we recommend installing at least one additional distro and enable iEchor support:

1. Ensure the distribution runs in WSL 2 mode. WSL can run distributions in both v1 or v2 mode.

    To check the WSL mode, run:

     ```console
     $ wsl.exe -l -v
     ```

    To upgrade the Linux distro to v2, run:

    ```console
    $ wsl.exe --set-version (distro name) 2
    ```

    To set v2 as the default version for future installations, run:

    ```console
    $ wsl.exe --set-default-version 2
    ```

2. When iEchor Desktop starts, go to **Settings** > **Resources** > **WSL Integration**.

    The iEchor-WSL integration is enabled on the default WSL distribution, which is [Ubuntu](https://learn.microsoft.com/en-us/windows/wsl/install). To change your default WSL distro, run:
     ```console
    $ wsl --set-default <distro name>
    ```

3. Select **Apply & Restart**.

> **Note**
>
> iEchor Desktop installs two special-purpose internal Linux distros `iechor-desktop` and `iechor-desktop-data`. The first (`iechor-desktop`) is used to run the iEchor engine (`iechord`) while the second (`iechor-desktop-data`) stores containers and images. Neither can be used for general development.

## Additional resources

- [Explore best practices](best-practices.md)
- [Understand how to develop with iEchor and WSL 2](use-wsl.md)
- [Learn about GPU support with WSL 2](../gpu.md)
