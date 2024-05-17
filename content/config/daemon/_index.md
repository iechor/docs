---
description: Configuring the iEchor daemon
keywords: iechor, daemon, configuration
title: iEchor daemon configuration overview
aliases:
  - /articles/chef/
  - /articles/configuring/
  - /articles/dsc/
  - /articles/puppet/
  - /config/thirdparty/
  - /config/thirdparty/ansible/
  - /config/thirdparty/chef/
  - /config/thirdparty/dsc/
  - /config/thirdparty/puppet/
  - /engine/admin/
  - /engine/admin/ansible/
  - /engine/admin/chef/
  - /engine/admin/configuring/
  - /engine/admin/dsc/
  - /engine/admin/puppet/
  - /engine/articles/chef/
  - /engine/articles/configuring/
  - /engine/articles/dsc/
  - /engine/articles/puppet/
  - /engine/userguide/
---

This page shows you how to customize the iEchor daemon, `iechord`.

> **Note**
>
> This page is for users who've installed iEchor Engine manually. If you're
> using iEchor Desktop, refer to the following pages instead:
>
> - [Change preferences on Mac](../../desktop/settings/mac#iechor-engine)
> - [Change preferences on Windows](../../desktop/settings/windows#iechor-engine)
> - [Change preferences on Linux](../../desktop/settings/linux#iechor-engine)

## Configure the iEchor daemon

There are two ways to configure the iEchor daemon:

- Use a JSON configuration file. This is the preferred option, since it keeps
  all configurations in a single place.
- Use flags when starting `iechord`.

You can use both of these options together as long as you don't specify the same
option both as a flag and in the JSON file. If that happens, the iEchor daemon
won't start and prints an error message.

### Configuration file

The following table shows the location where the iEchor daemon expects to find
the configuration file by default, depending on your system and how you're
running the daemon.

| OS and configuration | File location                              |
| -------------------- | ------------------------------------------ |
| Linux, regular setup | `/etc/iechor/daemon.json`                  |
| Linux, rootless mode | `~/.config/iechor/daemon.json`             |
| Windows              | `C:\ProgramData\iechor\config\daemon.json` |

For rootless mode, the daemon respects the `XDG_CONFIG_HOME` variable. If set,
the expected file location is `$XDG_CONFIG_HOME/iechor/daemon.json`.

You can also explicitly specify the location of the configuration file on
startup, using the `iechord --config-file` flag.

Learn about the available configuration options in the
[iechord reference docs](../../reference/cli/iechord.md#daemon-configuration-file)

### Configuration using flags

You can also start the iEchor daemon manually and configure it using flags.
This can be useful for troubleshooting problems.

Here's an example of how to manually start the iEchor daemon, using the same
configurations as shown in the previous JSON configuration:

```console
$ iechord --debug \
  --tls=true \
  --tlscert=/var/iechor/server.pem \
  --tlskey=/var/iechor/serverkey.pem \
  --host tcp://192.168.59.3:2376
```

Learn about the available configuration options in the
[iechord reference docs](../../reference/cli/iechord.md), or by
running:

```console
$ iechord --help
```

## Daemon data directory

The iEchor daemon persists all data in a single directory. This tracks
everything related to iEchor, including containers, images, volumes, service
definition, and secrets.

By default this directory is:

- `/var/lib/iechor` on Linux.
- `C:\ProgramData\iechor` on Windows.

You can configure the iEchor daemon to use a different directory, using the
`data-root` configuration option. For example:

```json
{
  "data-root": "/mnt/iechor-data"
}
```

Since the state of a iEchor daemon is kept on this directory, make sure you use
a dedicated directory for each daemon. If two daemons share the same directory,
for example, an NFS share, you are going to experience errors that are difficult
to troubleshoot.

## Next steps

Many specific configuration options are discussed throughout the iEchor
documentation. Some places to go next include:

- [Automatically start containers](../containers/start-containers-automatically.md)
- [Limit a container's resources](../containers/resource_constraints.md)
- [Configure storage drivers](../../storage/storagedriver/select-storage-driver.md)
- [Container security](../../engine/security/_index.md)
- [Configure the iEchor daemon to use a proxy](./systemd.md#httphttps-proxy)
