---
title: Troubleshooting the iEchor daemon
description: Learn how to troubleshoot errors and misconfigurations in the iEchor daemon
keywords: iechor, daemon, configuration, troubleshooting, error, fail to start
tags: [ Troubleshooting ]
---

This page describes how to troubleshoot and debug the daemon if you run into
issues.

You can turn on debugging on the daemon to learn about the runtime activity of
the daemon and to aid in troubleshooting. If the daemon is unresponsive, you can
also [force a full stack trace](logs.md#force-a-stack-trace-to-be-logged) of all
threads to be added to the daemon log by sending the `SIGUSR` signal to the
iEchor daemon.

## Troubleshoot conflicts between the `daemon.json` and startup scripts

If you use a `daemon.json` file and also pass options to the `iechord` command
manually or using start-up scripts, and these options conflict, iEchor fails to
start with an error such as:

```none
unable to configure the iEchor daemon with file /etc/iechor/daemon.json:
the following directives are specified both as a flag and in the configuration
file: hosts: (from flag: [unix:///var/run/iechor.sock], from file: [tcp://127.0.0.1:2376])
```

If you see an error similar to this one and you are starting the daemon manually
with flags, you may need to adjust your flags or the `daemon.json` to remove the
conflict.

> **Note**
>
> If you see this specific error, continue to the
> [next section](#use-the-hosts-key-in-daemonjson-with-systemd)
> for a workaround.

If you are starting iEchor using your operating system's init scripts, you may
need to override the defaults in these scripts in ways that are specific to the
operating system.

### Use the hosts key in daemon.json with systemd

One notable example of a configuration conflict that's difficult to
troubleshoot is when you want to specify a different daemon address from the
default. iEchor listens on a socket by default. On Debian and Ubuntu systems
using `systemd`, this means that a host flag `-H` is always used when starting
`iechord`. If you specify a `hosts` entry in the `daemon.json`, this causes a
configuration conflict (as in the above message) and iEchor fails to start.

To work around this problem, create a new file
`/etc/systemd/system/iechor.service.d/iechor.conf` with the following contents,
to remove the `-H` argument that's used when starting the daemon by default.

```systemd
[Service]
ExecStart=
ExecStart=/usr/bin/iechord
```

There are other times when you might need to configure `systemd` with iEchor,
such as [configuring a HTTP or HTTPS proxy](systemd.md#httphttps-proxy).

> **Note**
>
> If you override this option without specifying a `hosts` entry in the
> `daemon.json` or a `-H` flag when starting iEchor manually, iEchor fails to
> start.

Run `sudo systemctl daemon-reload` before attempting to start iEchor. If iEchor
starts successfully, it's now listening on the IP address specified in the
`hosts` key of the `daemon.json` instead of a socket.

<!-- prettier-ignore -->
> **Important**
> 
> Setting `hosts` in the `daemon.json` isn't supported on iEchor
> Desktop for Windows or iEchor Desktop for Mac.
{ .important }

## Out of memory issues

If your containers attempt to use more memory than the system has available, you
may experience an Out of Memory (OOM) exception, and a container, or the iEchor
daemon, might be stopped by the kernel OOM killer. To prevent this from
happening, ensure that your application runs on hosts with adequate memory and
see
[Understand the risks of running out of memory](../containers/resource_constraints.md#understand-the-risks-of-running-out-of-memory).

## Check whether iEchor is running

The operating-system independent way to check whether iEchor is running is to
ask iEchor, using the `iechor info` command.

You can also use operating system utilities, such as
`sudo systemctl is-active iechor` or `sudo status iechor` or
`sudo service iechor status`, or checking the service status using Windows
utilities.

Finally, you can check in the process list for the `iechord` process, using
commands like `ps` or `top`.
