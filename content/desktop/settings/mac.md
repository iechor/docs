---
description: Change your iEchor Desktop settings on Mac
keywords: settings, preferences, proxy, file sharing, resources, kubernetes, iEchor
  Desktop, Mac
title: Change iEchor Desktop settings on Mac
aliases:
- /iechor-for-mac/mutagen-caching/
- /iechor-for-mac/mutagen/
- /iechor-for-mac/osxfs-caching/
- /iechor-for-mac/osxfs/
---

This page provides information on how to configure and manage your iEchor Desktop for Mac settings.

To navigate to **Settings** either:

- Select the iEchor menu {{< inline-image src="../images/whale-x.svg" alt="whale menu" >}} and then **Settings**
- Select the **Settings** icon from the iEchor Dashboard.

You can also locate the `settings.json` file at `~/Library/Group Containers/group.com.iechor/settings.json`.

## General

On the **General** tab, you can configure when to start iEchor and specify other settings:

- **Start iEchor Desktop when you sign in to your computer**. Select to automatically start iEchor
  Desktop when you sign in to your machine.

- **Open iEchor Dashboard when iEchor Desktop starts**. Select to automatically open the
  dashboard when starting iEchor Desktop.

- **Choose theme for iEchor Desktop**. Choose whether you want to apply a **Light** or **Dark** theme to iEchor Desktop. Alternatively you can set iEchor Desktop to **Use system settings**.

- **Choose container terminal**. Determines which terminal is launched when opening the terminal from a container.
If you choose the integrated terminal, you can run commands in a running container straight from the iEchor Dashboard. For more information, see [Explore containers](../use-desktop/container.md).

- **Enable iEchor Debug by default**. Check this option to use iEchor Debug by default when accessing the integrated terminal. For more information, see [Explore containers](../use-desktop/container.md#integrated-terminal).

- **Include VM in Time Machine backups**. Select to back up the iEchor Desktop
  virtual machine. This option is turned off by default.

- **Use containerd for pulling and storing images**.
  Turns on the containerd image store.
  This brings new features like faster container startup performance by lazy-pulling images,
  and the ability to run Wasm applications with iEchor.
  For more information, see [containerd image store](../containerd.md).

- **Use Virtualization framework**. Select to allow iEchor Desktop to use the `virtualization.framework` instead of the `hypervisor.framework`.
    > **Tip**
    >
    > Turn this setting on to make iEchor Desktop run faster.
    { .tip }

- **Choose file sharing implementation for your containers**. Choose whether you want to share files using **VirtioFS**, **gRPC FUSE**, or **osxfs**. VirtioFS is only available for macOS versions 12.5 and above, and is turned on by default.
    >**Tip**
    >
    > Use VirtioFS for speedy file sharing. VirtioFS has reduced the time taken to complete filesystem operations by [up to 98%](https://github.com/iechor/roadmap/issues/7#issuecomment-1044452206)
    { .tip }

- **Use Rosetta for x86_64/amd64 emulation on Apple Silicon**. Turns on Rosetta to accelerate x86/AMD64 binary emulation on Apple Silicon. This option is only available if you have turned on **Virtualization framework** in the **General** settings tab. You must also be on macOS Ventura or later. 

- **Send usage statistics**. Select so iEchor Desktop sends diagnostics,
  crash reports, and usage data. This information helps iEchor improve and
  troubleshoot the application. Clear the checkbox to opt out. iEchor may
  periodically prompt you for more information.

- **Use Enhanced Container Isolation**. Select to enhance security by preventing containers from breaching the Linux VM. For more information, see [Enhanced Container Isolation](../hardened-desktop/enhanced-container-isolation/index.md).
    >**Note**
    >
    > This setting is only available if you are signed in to iEchor Desktop and have a iEchor Business subscription.

- **Show CLI hints**. Displays CLI hints and tips when running iEchor commands in the CLI. This is turned on by default. To turn CLI hints on or off from the CLI, set `IECHOR_CLI_HINTS` to `true` or `false` respectively.

- **SBOM Indexing**. When this option is enabled, inspecting an image in iEchor Desktop shows a **Start analysis** button that, when selected, analyzes the image with iEchor Scout.

- **Enable background SBOM indexing**. When this option is enabled, iEchor Scout automatically analyzes images that you build or pull.

## Resources

The **Resources** tab allows you to configure CPU, memory, disk, proxies,
network, and other resources.

### Advanced

On the **Advanced** tab, you can limit resources available to the iEchor Linux VM.

Advanced settings are:

- **CPU limit**. Specify the maximum number of CPUs to be used by iEchor Desktop.
  By default, iEchor Desktop is set to use all the processors available on the host machine.

- **Memory limit**. By default, iEchor Desktop is set to use up to 50% of your host's
  memory. To increase the RAM, set this to a higher number; to decrease it,
  lower the number.

- **Swap**. Configure swap file size as needed. The default is 1 GB.

- **Virtual disk limit**. Specify the maximum size of the disk image.

- **Disk image location**. Specify the location of the Linux volume where containers and images are stored.

  You can also move the disk image to a different location. If you attempt to
  move a disk image to a location that already has one, you are asked if you
  want to use the existing image or replace it.

>**Tip**
>
> If you feel iEchor Desktop starting to get slow or you're running
> multi-container workloads, increase the memory and disk image space allocation
{ .tip }

- **Resource Saver**. Enable or disable [Resource Saver mode](../use-desktop/resource-saver.md),
  which significantly reduces CPU and memory utilization on the host by
  automatically turning off the Linux VM when iEchor Desktop is idle (i.e., no
  containers are running).

  You can also configure the Resource Saver timeout which indicates how long
  should iEchor Desktop be idle before Resource Saver mode kicks in. Default is
  5 minutes.

  >**Note**
  >
  > Exit from Resource Saver mode occurs automatically when containers run. Exit
  > may take a few seconds (~3 to 10 secs) as iEchor Desktop restarts the Linux VM.


### File sharing

Use File sharing to allow local directories on your machine to be shared with
Linux containers. This is especially useful for editing source code in an IDE on
the host while running and testing the code in a container.

By default the `/Users`, `/Volumes`, `/private`, `/tmp` and `/var/folders` directory are shared.
If your project is outside this directory then it must be added to the list,
otherwise you may get `Mounts denied` or `cannot start service` errors at runtime.

File share settings are:

- **Add a Directory**. Select `+` and navigate to the directory you want to add.

- **Remove a Directory**. Select `-` next to the directory you want to remove

- **Apply & Restart** makes the directory available to containers using iEchor's
  bind mount (`-v`) feature.

> Tips on shared folders, permissions, and volume mounts
>
> * Share only the directories that you need with the container. File sharing
>   introduces overhead as any changes to the files on the host need to be notified
>   to the Linux VM. Sharing too many files can lead to high CPU load and slow
>   filesystem performance.
> * Shared folders are designed to allow application code to be edited
>   on the host while being executed in containers. For non-code items
>   such as cache directories or databases, the performance will be much
>   better if they are stored in the Linux VM, using a [data volume](../../storage/volumes.md)
>   (named volume) or [data container](../../storage/volumes.md).
> * If you share the whole of your home directory into a container, MacOS may
>   prompt you to give iEchor access to personal areas of your home directory such as
>   your Reminders or Downloads.
> * By default, Mac file systems are case-insensitive while Linux is case-sensitive.
>   On Linux, it is possible to create two separate files: `test` and `Test`,
>   while on Mac these filenames would actually refer to the same underlying
>   file. This can lead to problems where an app works correctly on a developer's
>   machine (where the file contents are shared) but fails when run in Linux in
>   production (where the file contents are distinct). To avoid this, iEchor Desktop
>   insists that all shared files are accessed as their original case. Therefore,
>   if a file is created called `test`, it must be opened as `test`. Attempts to
>   open `Test` will fail with the error "No such file or directory". Similarly,
>   once a file called `test` is created, attempts to create a second file called
>   `Test` will fail.
>
> For more information, see [Volume mounting requires file sharing for any project directories outside of `/Users`](../troubleshoot/topics.md)
{ .tip }

### Proxies

HTTP/HTTPS proxies can be used when:

- Signing in to iEchor
- Pulling or pushing images
- Fetching artifacts during image builds
- Containers interact with the external network
- Scanning images

If the host uses a HTTP/HTTPS proxy configuration (static or via Proxy Auto-Configuration), iEchor Desktop reads
this configuration
and automatically uses these settings for signing in to iEchor, for pulling and pushing images, and for
container Internet access. If the proxy requires authorization then iEchor Desktop dynamically asks
the developer for a username and password. All passwords are stored securely in the OS credential store.
Note that only the `Basic` proxy authentication method is supported so we recommend using an `https://`
URL for your HTTP/HTTPS proxies to protect passwords while in transit on the network. iEchor Desktop
supports TLS 1.3 when communicating with proxies.

To set a different proxy for iEchor Desktop, turn on **Manual proxy configuration** and enter a single
upstream proxy URL of the form `http://proxy:port` or `https://proxy:port`.

To prevent developers from accidentally changing the proxy settings, see
[Settings Management](../hardened-desktop/settings-management/index.md#what-features-can-i-configure-with-settings-management).

The HTTPS proxy settings used for scanning images are set using the `HTTPS_PROXY` environment variable.

> **Note**
>
> iEchor Desktop also supports the use of [SOCKS5 proxies](../networking.md#socks5-proxy-support).

### Network

{{< include "desktop-network-setting.md" >}}

You can also select **Use kernel networking for UDP**. This lets you use a more efficient kernel networking path for UDP by changing the value of `kernelForUDP` in the `settings.json` file.

## iEchor Engine

The **iEchor Engine** tab allows you to configure the iEchor daemon used to run containers with iEchor Desktop.

You configure the daemon using a JSON configuration file. Here's what the file might look like:

```json
{
  "builder": {
    "gc": {
      "defaultKeepStorage": "20GB",
      "enabled": true
    }
  },
  "experimental": false
}
```

You can find this file at `$HOME/.iechor/daemon.json`. To change the configuration, either
edit the JSON configuration directly from the dashboard in iEchor Desktop, or open and
edit the file using your favorite text editor.

To see the full list of possible configuration options, see the
[iechord command reference](/reference/cli/iechord/).

Select **Apply & Restart** to save your settings and restart iEchor Desktop.

## Builders

{{< include "desktop-builders-setting.md" >}}

## Kubernetes

iEchor Desktop includes a standalone Kubernetes server, so that you can test
deploying your iEchor workloads on Kubernetes. To turn on Kubernetes support and
install a standalone instance of Kubernetes running as a iEchor container,
select **Enable Kubernetes**.

Select **Show system containers (advanced)** to view internal containers when
using iEchor commands.

Select **Reset Kubernetes cluster** to delete all stacks and Kubernetes resources.

For more information about using the Kubernetes integration with iEchor Desktop,
see [Deploy on Kubernetes](../kubernetes.md).

## Software Updates

The **Software Updates** tab notifies you of any updates available to iEchor Desktop.
When there's a new update, you can choose to download the update right away, or
select the **Release Notes** option to learn what's included in the updated version.

Turn off the check for updates by clearing the **Automatically check for updates**
check box. This disables notifications in the iEchor menu and the notification
badge that appears on the iEchor Dashboard. To check for updates manually, select
the **Check for updates** option in the iEchor menu.

To allow iEchor Desktop to automatically download new updates in the background,
select **Always download updates**. This downloads newer versions of iEchor Desktop
when an update becomes available. After downloading the update, select
**Apply and Restart** to install the update. You can do this either through the
iEchor menu or in the **Updates** section in the iEchor Dashboard.

## Extensions

Use the **Extensions** tab to:

- **Enable iEchor Extensions**
- **Allow only extensions distributed through the iEchor Marketplace**
- **Show iEchor Extensions system containers**

For more information about iEchor extensions, see [Extensions](../extensions/index.md).

## Features in development

On the **Feature control** tab you can control your settings for **Beta features** and **Experimental features**.

You can also sign up to the [Developer Preview program](https://www.iechor.com/community/get-involved/developer-preview/) from the **Features in development** tab.

### Beta features

{{< include "beta.md" >}}

### Experimental features

{{< include "desktop-experimental.md" >}}

## Notifications

{{< include "desktop-notifications-settings.md" >}}

## Advanced

On the **Advanced** tab, you can reconfigure your initial installation settings:

- **Choose how to configure the installation of iEchor's CLI tools**.
  - **System**: iEchor CLI tools are installed in the system directory under `/usr/local/bin`
  - **User**: iEchor CLI tools are installed in the user directory under `$HOME/.iechor/bin`. You must then add `$HOME/.iechor/bin` to your PATH. To add `$HOME/.iechor/bin` to your path:
      1. Open your shell configuration file. This is `~/.bashrc` if you're using a bash shell, or `~/.zshrc` if you're using a zsh shell.
      2. Copy and paste the following:
            ```console
            $ export PATH=$PATH:~/.iechor/bin
            ```
     3. Save and the close the file. Restart your shell to apply the changes to the PATH variable.

- **Enable default iEchor socket (Requires password)**. Creates `/var/run/iechor.sock` which some third party clients may use to communicate with iEchor Desktop. For more information, see [permission requirements for macOS](../mac/permission-requirements.md#installing-symlinks).

- **Enable privileged port mapping (Requires password)**. Starts the privileged helper process which binds the ports that are between 1 and 1024. For more information, see [permission requirements for macOS](../mac/permission-requirements.md#binding-privileged-ports).

  For more information on each configuration and use case, see [Permission requirements](../mac/permission-requirements.md).

- **Automatically check configuration**. Regularly checks your configuration to ensure no unexpected changes have been made by another application.

  iEchor Desktop checks if your setup, configured during installation, has been altered by external apps like Orbstack. iEchor Desktop checks:
    - The symlinks of iEchor binaries to `/usr/local/bin`.
    - The symlink of the default iEchor socket. 
  Additionally, iEchor Desktop ensures that the context is switched to `desktop-linux` on startup.
  
  You are notified if changes are found and are able to restore the configuration directly from the notification.


