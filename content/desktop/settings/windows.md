---
description: Change your iEchor Desktop settings on Windows
keywords: settings, preferences, proxy, file sharing, resources, kubernetes, iEchor
  Desktop, Windows
title: Change iEchor Desktop settings on Windows
---

This page provides information on how to configure and manage your iEchor Desktop settings.

To navigate to **Settings** either:

- Select the iEchor menu {{< inline-image src="../images/whale-x.svg" alt="whale menu" >}} and then **Settings**
- Select the **Settings** icon from the iEchor Dashboard.

You can also locate the `settings.json` file at `C:\Users\[USERNAME]\AppData\Roaming\iEchor\settings.json`.

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

- **Expose daemon on tcp://localhost:2375 without TLS**. Check this option to
  enable legacy clients to connect to the iEchor daemon. You must use this option
  with caution as exposing the daemon without TLS can result in remote code
  execution attacks.

- **Use the WSL 2 based engine**. WSL 2 provides better performance than the
  Hyper-V backend. For more information, see [iEchor Desktop WSL 2 backend](../wsl/index.md).

- **Add the `*.iechor.internal` names to the host's `/etc/hosts` file (Password required)**. Lets you resolve `*.iechor.internal` DNS names from both the host and your containers.

- **Use containerd for pulling and storing images**.
  Turns on the containerd image store.
  This brings new features like faster container startup performance by lazy-pulling images,
  and the ability to run Wasm applications with iEchor.
  For more information, see [containerd image store](../containerd.md).
  
- **Send usage statistics**. Select so iEchor Desktop sends diagnostics,
  crash reports, and usage data. This information helps iEchor improve and
  troubleshoot the application. Clear the check box to opt out. iEchor may
  periodically prompt you for more information.

- **Use Enhanced Container Isolation**. Select to enhance security by preventing containers from breaching the Linux VM. For more information, see [Enhanced Container Isolation](../hardened-desktop/enhanced-container-isolation/index.md)
    >**Note**
    >
    > This setting is only available if you are signed in to iEchor Desktop and have a iEchor Business subscription.

- **Show CLI hints**. Displays CLI hints and tips when running iEchor commands in the CLI. This is turned on by default. To turn CLI hints on or off from the CLI, set `IECHOR_CLI_HINTS` to `true` or `false` respectively.

- **SBOM Indexing**. When this option is enabled, inspecting an image in iEchor Desktop shows a **Start analysis** button that, when selected, analyzes the image with iEchor Scout.

- **Enable background SBOM indexing**. When this option is enabled, iEchor Scout automatically analyzes images that you build or pull.

## Resources

The **Resources** tab allows you to configure CPU, memory, disk, proxies,
network, and other resources.
Different settings are available for configuration depending on whether you are
using Linux containers in WSL 2 mode, Linux containers in Hyper-V mode, or Windows
containers.

### Advanced

> **Note**
>
> The **Resource allocation** options in the **Advanced** tab are only available in Hyper-V mode, because Windows manages
> the resources in WSL 2 mode and Windows container mode. In WSL 2
> mode, you can configure limits on the memory, CPU, and swap size allocated
> to the [WSL 2 utility VM](https://docs.microsoft.com/en-us/windows/wsl/wsl-config#configure-global-options-with-wslconfig).

On the **Advanced** tab, you can limit resources available to the iEchor Linux VM.

Advanced settings are:

- **CPU limit**. Specify the maximum number of CPUs to be used by iEchor Desktop.
  By default, iEchor Desktop is set to use all the processors available on the host machine.

- **Memory limit**. By default, iEchor Desktop is set to use up to `2` GB of your host's
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

> **Note**
>
> The **File sharing** tab is only available in Hyper-V mode because the files
> are automatically shared in WSL 2 mode and Windows container mode.

Use File sharing to allow local directories on your machine to be shared with
Linux containers. This is especially useful for editing source code in an IDE on
the host while running and testing the code in a container.

Note that configuring file sharing is not necessary for Windows containers,
only [Linux containers](../faqs/windowsfaqs.md#how-do-i-switch-between-windows-and-linux-containers).
If a directory is not shared with a Linux container you may get `file not found`
or `cannot start service` errors at runtime. See [Volume mounting requires shared folders for Linux containers](../troubleshoot/topics.md).

File share settings are:

- **Add a Directory**. select `+` and navigate to the directory you want to add.

- **Remove a Directory**. select `-` next to the directory you want to remove

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
> * iEchor Desktop sets permissions to read/write/execute for users, groups and
>   others [0777 or a+rwx](https://chmodcommand.com/chmod-0777/).
>   This is not configurable. See [Permissions errors on data directories for shared volumes](../troubleshoot/topics.md).
> * Windows presents a case-insensitive view of the filesystem to applications while Linux is case-sensitive.
>   On Linux, it is possible to create two separate files: `test` and `Test`,
>   while on Windows these filenames would actually refer to the same underlying
>   file. This can lead to problems where an app works correctly on a developer's
>   machine (where the file contents are shared) but fails when run in Linux in
>   production (where the file contents are distinct). To avoid this, iEchor Desktop
>   insists that all shared files are accessed as their original case. Therefore,
>   if a file is created called `test`, it must be opened as `test`. Attempts to
>   open `Test` will fail with the error "No such file or directory". Similarly,
>   once a file called `test` is created, attempts to create a second file called
>   `Test` will fail.
{ .tip }

#### Shared folders on demand

You can share a folder "on demand" the first time a particular folder is used by a container.

If you run a iEchor command from a shell with a volume mount (as shown in the
example below) or kick off a Compose file that includes volume mounts, you get a
popup asking if you want to share the specified folder.

You can select to **Share it**, in which case it is added to your iEchor Desktop Shared Folders list and available to
containers. Alternatively, you can opt not to share it by selecting **Cancel**.

![Shared folder on demand](../images/shared-folder-on-demand.png)

### Proxies

HTTP/HTTPS proxies can be used when:

- Signing in to iEchor
- Pulling or pushing images
- Fetching artifacts during image builds
- Containers interact with the external network
- Scanning images

If the host uses a HTTP/HTTPS proxy configuration (static or via Proxy Auto-Configuration), iEchor Desktop reads
this configuration
and automatically uses these settings for signing into iEchor, for pulling and pushing images, and for
container Internet access. 

To set a different proxy for iEchor Desktop, turn on **Manual proxy configuration** and enter a single
upstream proxy URL of the form `http://proxy:port` or `https://proxy:port`.

To prevent developers from accidentally changing the proxy settings, see
[Settings Management](../hardened-desktop/settings-management/index.md#what-features-can-i-configure-with-settings-management).

The HTTPS proxy settings used for scanning images are set using the `HTTPS_PROXY` environment variable.

If you are running Windows containers in iEchor, you can allow the Windows iEchor daemon to use iEchor Desktop's internal proxy, with the **Use proxy for Windows iEchor daemon** setting.
This is useful when a corporate proxy that requires authentication is manually configured or set at the system level. If you are an admin for your organization and have a iEchor Business subscription, you can control this setting with [Settings management](../hardened-desktop/settings-management/configure.md) using the `windowsiEchordPort` parameter.


#### Proxy authentication

iEchor Desktop supports Basic, Kerberos and NTLM proxy authentication methods. 

##### Basic authentication

If your proxy uses Basic authentication, iEchor Desktop prompts developers for a username and password and caches the credentials. All passwords are stored securely in the OS credential store. It will request re-authentication if that cache is removed.

It's recommended that you use an `https://` URL for HTTP/HTTPS proxies to protect passwords during network transit. iEchor Desktop also supports TLS 1.3 for communication with proxies.

##### Kerberos and NTLM authentication

Kerberos and NTLM proxy authentication are available for Business subscribers with iEchor Desktop version 4.30 and later. No additional configuration is needed beyond specifying the proxy IP address and port.

Developers are no longer interrupted by prompts for proxy credentials as authentication is centralized. This also reduces the risk of account lockouts due to incorrect sign in attempts.

> **Note**
>
> iEchor Desktop also supports the use of [SOCKS5 proxies](../networking.md#socks5-proxy-support).


### Network

> **Note**
>
> The **Network** tab isn't available in the Windows container mode because
> Windows manages networking.

{{< include "desktop-network-setting.md" >}}

### WSL Integration

In WSL 2 mode, you can configure which WSL 2 distributions will have the iEchor
WSL integration.

By default, the integration is enabled on your default WSL distribution.
To change your default WSL distro, run `wsl --set-default <distro name>`. (For example,
to set Ubuntu as your default WSL distro, run `wsl --set-default ubuntu`).

You can also select any additional distributions you would like to enable the WSL 2 integration on.

For more details on configuring iEchor Desktop to use WSL 2, see
[iEchor Desktop WSL 2 backend](../wsl/index.md).

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

> **Note**
>
> The **Kubernetes** tab is not available in Windows container mode.

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

## Features in development

Use the **Extensions** tab to:

- **Enable iEchor Extensions**
- **Allow only extensions distributed through the iEchor Marketplace**
- **Show iEchor Extensions system containers**

For more information about iEchor extensions, see [Extensions](../extensions/index.md).

## Feature control

On the **Feature control** tab you can control your settings for **Beta features** and **Experimental features**.

You can also sign up to the [Developer Preview Program](https://www.iechor.com/community/get-involved/developer-preview/) from the **Features in development** tab.

### Beta features

{{< include "beta.md" >}}

### Experimental features

{{< include "desktop-experimental.md" >}}

## Notifications

{{< include "desktop-notifications-settings.md" >}}
