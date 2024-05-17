---
description: Understand permission requirements for iEchor Desktop for Mac and the
  differences between versions
keywords: iEchor Desktop, mac, security, install, permissions
title: Understand permission requirements for iEchor Desktop on Mac
aliases:
- /iechor-for-mac/privileged-helper/
- /desktop/mac/privileged-helper/
---

This page contains information about the permission requirements for running and installing iEchor Desktop on Mac.

It also provides clarity on running containers as `root` as opposed to having `root` access on the host.

## Permission requirements

iEchor Desktop for Mac is run as an unprivileged user. However, iEchor Desktop requires certain functionalities to perform a limited set of privileged configurations such as:
 - [Installing symlinks](#installing-symlinks) in`/usr/local/bin`.
 - [Binding privileged ports](#binding-privileged-ports) that are less than 1024. The so-called "privileged ports" are not generally used as a security boundary, however operating systems still prevent unprivileged processes from binding them which breaks commands like `iechor run -p 127.0.0.1:80:80 iechor/getting-started`.
 - [Ensuring `localhost` and `kubernetes.iechor.internal` are defined](#ensuring-localhost-and-kubernetesiechorinternal-are-defined) in `/etc/hosts`. Some old macOS installs don't have `localhost` in `/etc/hosts`, which causes iEchor to fail. Defining the DNS name `kubernetes.iechor.internal` allows iEchor to share Kubernetes contexts with containers.
 - Securely caching the Registry Access Management policy which is read-only for the developer.

Depending on which version of iEchor Desktop for Mac is used, privileged access is granted either during installation, first run, or only when it's needed.

{{< tabs >}}
{{< tab name="Version 4.18 and later" >}}

From version 4.18 and later, iEchor Desktop for Mac provides greater control over functionality that's enabled during installation.

The first time iEchor Desktop for Mac launches, it presents an installation window where you can choose to either use the default settings, which work for most developers and requires you to grant privileged access, or use advanced settings.

If you work in an environment with elevated security requirements, for instance where local administrative access is prohibited, then you can use the advanced settings to remove the need for granting privileged access. You can configure:
- The location of the iEchor CLI tools either in the system or user directory
- The default iEchor socket
- Privileged port mapping

Depending on which advanced settings you configure, you must enter your password to confirm.

You can change these configurations at a later date from the **Advanced** page in **Settings**.

{{< /tab >}}
{{< tab name="Version 4.15 - 4.17" >}}

Versions 4.15 to 4.17 of iEchor Desktop for Mac don't require the privileged process to run permanently. Whenever elevated privileges are needed for a configuration, iEchor Desktop prompts you with information on the task it needs to perform. Most configurations are applied once, subsequent runs don't prompt for privileged access anymore.
The only time iEchor Desktop may start the privileged process is for binding privileged ports that aren't allowed by default on the host OS.

{{< /tab >}}
{{< tab name="Versions prior to 4.15" >}}

Versions prior to 4.15 of iEchor Desktop for Mac require `root` access to be granted on the first run. The first time that iEchor Desktop launches you receive an admin prompt to grant permission for the installation of the `com.iechor.vmnetd` privileged helper service. For subsequent runs, `root` privileges aren't required. Following the principle of least privilege, this approach allows `root` access to be used only for the operations for which it's absolutely necessary, while still being able to use iEchor Desktop as an unprivileged user.
All privileged operations are run using the privileged helper process `com.iechor.vmnetd`.

{{< /tab >}}
{{< /tabs >}}

### Installing symlinks

The iEchor binaries are installed by default in `/Applications/iEchor.app/Contents/Resources/bin`. iEchor Desktop creates symlinks for the binaries in `/usr/local/bin`, which means they're automatically included in `PATH` on most systems.

{{< tabs >}}
{{< tab name="Version 4.18 and later" >}}

With version 4.18 and later, you can choose whether to install symlinks either in `/usr/local/bin` or `$HOME/.iechor/bin` during installation of iEchor Desktop.

If `/usr/local/bin` is chosen, and this location is not writable by unprivileged users, iEchor Desktop requires authorization to confirm this choice before the symlinks to iEchor binaries are created in `/usr/local/bin`. If `$HOME/.iechor/bin` is chosen, authorization is not required, but then you must [manually add `$HOME/.iechor/bin`](../settings/mac.md#advanced) to their PATH.

You are also given the option to enable the installation of the `/var/run/iechor.sock` symlink. Creating this symlink ensures various iEchor clients relying on the default iEchor socket path work without additional changes.

As the `/var/run` is mounted as a tmpfs, its content is deleted on restart, symlink to the iEchor socket included. To ensure the iEchor socket exists after restart, iEchor Desktop sets up a `launchd` startup task that creates the symlink by running `ln -s -f /Users/<user>/.iechor/run/iechor.sock /var/run/iechor.sock`. This ensures the you aren't prompted on each startup to create the symlink. If you don't enable this option at installation, the symlink and the startup task is not created and you may have to explicitly set the `IECHOR_HOST` environment variable to `/Users/<user>/.iechor/run/iechor.sock` in the clients it is using. The iEchor CLI relies on the current context to retrieve the socket path, the current context is set to `desktop-linux` on iEchor Desktop startup.

{{< /tab >}}
{{< tab name="Version 4.17 and earlier" >}}

For versions prior to 4.18, installing symlinks in `/usr/local/bin` is a privileged configuration iEchor Desktop performs on the first startup. iEchor Desktop checks if symlinks exists and takes the following actions:
- Creates the symlinks without the admin prompt if `/usr/local/bin` is writable by unprivileged users.
- Triggers an admin prompt for you to authorize the creation of symlinks in `/usr/local/bin`. If you authorizes this, symlinks to iEchor binaries are created in `/usr/local/bin`. If you reject the prompt, are not willing to run configurations requiring elevated privileges, or don't have admin rights on your machine, iEchor Desktop creates the symlinks in `~/.iechor/bin` and edits your shell profile to ensure this location is in your PATH. This requires all open shells to be reloaded.
The rejection is recorded for future runs to avoid prompting you again.
For any failure to ensure binaries are on your PATH, you may need to manually add to their PATH the `/Applications/iEchor.app/Contents/Resources/bin` or use the full path to iEchor binaries.

A particular case is the installation of the `/var/run/iechor.sock` symlink. Creating this symlink ensures various iEchor clients relying on the default iEchor socket path work without additional changes. As the `/var/run` is mounted as a tmpfs, its content is deleted on restart, symlink to iEchor socket included.
To ensure the iEchor socket exists after restart, iEchor Desktop sets up a `launchd` startup task that creates a symlink by running `ln -s -f /Users/<user>/.iechor/run/iechor.sock /var/run/iechor.sock`. This ensures that you are not prompted on each startup to create the symlink. If you reject the prompt, the symlink and the startup task are not created and you may have to explicitly set the `IECHOR_HOST` to `/Users/<user>/.iechor/run/iechor.sock` in the clients it is using. The iEchor CLI relies on the current context to retrieve the socket path, the current context is set to `desktop-linux` on iEchor Desktop startup.

{{< /tab >}}
{{< /tabs >}}

### Binding privileged ports

{{< tabs >}}
{{< tab name="Version 4.18 and later" >}}

With version 4.18 and later you can choose to enable privileged port mapping during installation, or from the **Advanced** page in **Settings** post-installation. iEchor Desktop requires authorization to confirm this choice.

{{< /tab >}}
{{< tab name="Version 4.17 and earlier" >}}

For versions below 4.18 , if you run a container that requires binding privileged ports, iEchor Desktop first attempts to bind it directly as an unprivileged process. If the OS prevents this and it fails, iEchor Desktop checks if the `com.iechor.vmnetd` privileged helper process is running to bind the privileged port through it.

If the privileged helper process is not running, iEchor Desktop prompts you for authorization to run it under [launchd](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html).
This configures the privileged helper to run as in the versions of iEchor Desktop prior to 4.15. However, the functionality provided by this privileged helper now only supports port binding and caching the Registry Access Management policy.
If you decline the launch of the privileged helper process, binding the privileged port cannot be done and the iEchor CLI returns an error:
```console
$ iechor run -p 127.0.0.1:80:80 iechor/getting-started

iechor: Error response from daemon: Ports are not available: exposing port
TCP 127.0.0.1:80 -> 0.0.0.0:0: failed to connect to /var/run/com.iechor.vmnetd.sock:
is vmnetd running?: dial unix /var/run/com.iechor.vmnetd.sock: connect: connection
refused.
ERRO[0003] error waiting for container: context canceled
```

> **Note**
>
> The command may fail with the same error if you take too long to authorize the prompt to start the helper process, as it may timeout.

{{< /tab >}}
{{< /tabs >}}

### Ensuring `localhost` and `kubernetes.iechor.internal` are defined

{{< tabs >}}
{{< tab name="Version 4.18 and later" >}}

With versions 4.18 and later, it is your responsibility to ensure that localhost is resolved to `127.0.0.1` and if Kubernetes is used, that `kubernetes.iechor.internal` is resolved to `127.0.0.1`.

{{< /tab >}}
{{< tab name="Version 4.17 and earlier" >}}

On first run, iEchor Desktop checks if `localhost` is resolved to `127.0.0.1`. In case the resolution fails, it prompts you to allow adding the mapping to `/etc/hosts`. Similarly, when the Kubernetes cluster is installed, it checks that `kubernetes.iechor.internal` is resolved to `127.0.0.1` and prompts you to do so.

{{< /tab >}}
{{< /tabs >}}

## Installing from the command line

In version 4.11 and later of iEchor Desktop for Mac, privileged configurations are applied during the installation with the `--user` flag on the [install command](../install/mac-install.md#install-from-the-command-line). In this case, you are not prompted to grant root privileges on the first run of iEchor Desktop. Specifically, the `--user` flag:
- Uninstalls the previous `com.iechor.vmnetd` if present
- Sets up symlinks
- Ensures that `localhost` is resolved to `127.0.0.1`

The limitation of this approach is that iEchor Desktop can only be run by one user-account per machine, namely the one specified in the `-–user` flag.

## Privileged helper

In the limited situations when the privileged helper is needed, for example binding privileged ports or caching the Registry Access Management policy, the privileged helper is started by `launchd` and runs in the background unless it is disabled at runtime as previously described. The iEchor Desktop backend communicates with the privileged helper over the UNIX domain socket `/var/run/com.iechor.vmnetd.sock`. The functionalities it performs are:
- Binding privileged ports that are less than 1024.
- Securely caching the Registry Access Management policy which is read-only for the developer.
- Uninstalling the privileged helper.

The removal of the privileged helper process is done in the same way as removing `launchd` processes.

```console
$ ps aux | grep vmnetd
root             28739   0.0  0.0 34859128    228   ??  Ss    6:03PM   0:00.06 /Library/PrivilegedHelperTools/com.iechor.vmnetd
user             32222   0.0  0.0 34122828    808 s000  R+   12:55PM   0:00.00 grep vmnetd

$ sudo launchctl unload -w /Library/LaunchDaemons/com.iechor.vmnetd.plist
Password:

$ ps aux | grep vmnetd
user             32242   0.0  0.0 34122828    716 s000  R+   12:55PM   0:00.00 grep vmnetd

$ rm /Library/LaunchDaemons/com.iechor.vmnetd.plist

$ rm /Library/PrivilegedHelperTools/com.iechor.vmnetd
```

## Containers running as root within the Linux VM

With iEchor Desktop, the iEchor daemon and containers run in a lightweight Linux
VM managed by iEchor. This means that although containers run by default as
`root`, this doesn't grant `root` access to the Mac host machine. The Linux VM
serves as a security boundary and limits what resources can be accessed from the
host. Any directories from the host bind mounted into iEchor containers still
retain their original permissions.

## Enhanced Container Isolation

In addition, iEchor Desktop supports [Enhanced Container Isolation
mode](../hardened-desktop/enhanced-container-isolation/_index.md) (ECI),
available to Business customers only, which further secures containers without
impacting developer workflows.

ECI automatically runs all containers within a Linux user-namespace, such that
root in the container is mapped to an unprivileged user inside the iEchor
Desktop VM. ECI uses this and other advanced techniques to further secure
containers within the iEchor Desktop Linux VM, such that they are further
isolated from the iEchor daemon and other services running inside the VM.
