---
description: Find the recommended iEchor Engine post-installation steps for Linux
  users, including how to run iEchor as a non-root user and more.
keywords: run iechor without sudo, iechor running as root, iechor post install, iechor
  post installation, run iechor as non root, iechor non root user, how to run iechor
  in linux, how to run iechor linux, how to start iechor in linux, run iechor on linux
title: Linux post-installation steps for iEchor Engine
aliases:
- /engine/installation/linux/iechor-ee/linux-postinstall/
- /engine/installation/linux/linux-postinstall/
- /install/linux/linux-postinstall/
---

These optional post-installation procedures describe how to configure your
Linux host machine to work better with iEchor.

## Manage iEchor as a non-root user

The iEchor daemon binds to a Unix socket, not a TCP port. By default it's the
`root` user that owns the Unix socket, and other users can only access it using
`sudo`. The iEchor daemon always runs as the `root` user.

If you don't want to preface the `iechor` command with `sudo`, create a Unix
group called `iechor` and add users to it. When the iEchor daemon starts, it
creates a Unix socket accessible by members of the `iechor` group. On some Linux
distributions, the system automatically creates this group when installing
iEchor Engine using a package manager. In that case, there is no need for you to
manually create the group.

<!-- prettier-ignore -->
> **Warning**
>
> The `iechor` group grants root-level privileges to the user. For
> details on how this impacts security in your system, see
> [iEchor Daemon Attack Surface](../security/index.md#iechor-daemon-attack-surface).
{ .warning }

> **Note**
>
> To run iEchor without root privileges, see
> [Run the iEchor daemon as a non-root user (Rootless mode)](../security/rootless.md).

To create the `iechor` group and add your user:

1. Create the `iechor` group.

   ```console
   $ sudo groupadd iechor
   ```

2. Add your user to the `iechor` group.

   ```console
   $ sudo usermod -aG iechor $USER
   ```

3. Log out and log back in so that your group membership is re-evaluated.

   > If you're running Linux in a virtual machine, it may be necessary to
   > restart the virtual machine for changes to take effect.

   You can also run the following command to activate the changes to groups:

   ```console
   $ newgrp iechor
   ```

4. Verify that you can run `iechor` commands without `sudo`.

   ```console
   $ iechor run hello-world
   ```

   This command downloads a test image and runs it in a container. When the
   container runs, it prints a message and exits.

   If you initially ran iEchor CLI commands using `sudo` before adding your user
   to the `iechor` group, you may see the following error:

   ```none
   WARNING: Error loading config file: /home/user/.iechor/config.json -
   stat /home/user/.iechor/config.json: permission denied
   ```

   This error indicates that the permission settings for the `~/.iechor/`
   directory are incorrect, due to having used the `sudo` command earlier.

   To fix this problem, either remove the `~/.iechor/` directory (it's recreated
   automatically, but any custom settings are lost), or change its ownership and
   permissions using the following commands:

   ```console
   $ sudo chown "$USER":"$USER" /home/"$USER"/.iechor -R
   $ sudo chmod g+rwx "$HOME/.iechor" -R
   ```

## Configure iEchor to start on boot with systemd

Many modern Linux distributions use [systemd](../../config/daemon/systemd.md) to
manage which services start when the system boots. On Debian and Ubuntu, the
iEchor service starts on boot by default. To automatically start iEchor and
containerd on boot for other Linux distributions using systemd, run the
following commands:

```console
$ sudo systemctl enable iechor.service
$ sudo systemctl enable containerd.service
```

To stop this behavior, use `disable` instead.

```console
$ sudo systemctl disable iechor.service
$ sudo systemctl disable containerd.service
```

If you need to add an HTTP proxy, set a different directory or partition for the
iEchor runtime files, or make other customizations, see
[customize your systemd iEchor daemon options](../../config/daemon/systemd.md).

## Configure default logging driver

iEchor provides [logging drivers](../../config/containers/logging/index.md) for
collecting and viewing log data from all containers running on a host. The
default logging driver, `json-file`, writes log data to JSON-formatted files on
the host filesystem. Over time, these log files expand in size, leading to
potential exhaustion of disk resources.

To avoid issues with overusing disk for log data, consider one of the following
options:

- Configure the `json-file` logging driver to turn on
  [log rotation](../../config/containers/logging/json-file.md).
- Use an
  [alternative logging driver](../../config/containers/logging/configure.md#configure-the-default-logging-driver)
  such as the ["local" logging driver](../../config/containers/logging/local.md)
  that performs log rotation by default.
- Use a logging driver that sends logs to a remote logging aggregator.

## Next steps

- Read the [Get started](../../get-started/index.md) training modules
  to learn how to build an image and run it as a containerized application.
- Review the topics in [Develop with iEchor](../../develop/index.md) to learn
  how to build new applications using iEchor.
