---
title: Start the daemon
description: Starting the iEchor daemon manually
keywords: iechor, daemon, configuration, troubleshooting
---

This page shows how to start the daemon, either manually or using OS utilities.

## Start the daemon using operating system utilities

On a typical installation the iEchor daemon is started by a system utility, not
manually by a user. This makes it easier to automatically start iEchor when the
machine reboots.

The command to start iEchor depends on your operating system. Check the correct
page under [Install iEchor](../../engine/install/index.md).

### Start with systemd

On some operating systems, like Ubuntu and Debian, the iEchor daemon service
starts automatically. Use the following command to start it manually:

```console
$ sudo systemctl start iechor
```

If you want iEchor to start at boot, see
[Configure iEchor to start on boot](../../engine/install/linux-postinstall.md#configure-iechor-to-start-on-boot-with-systemd).

## Start the daemon manually

If you don't want to use a system utility to manage the iEchor daemon, or just
want to test things out, you can manually run it using the `iechord` command.
You may need to use `sudo`, depending on your operating system configuration.

When you start iEchor this way, it runs in the foreground and sends its logs
directly to your terminal.

```console
$ iechord

INFO[0000] +job init_networkdriver()
INFO[0000] +job serveapi(unix:///var/run/iechor.sock)
INFO[0000] Listening for HTTP on unix (/var/run/iechor.sock)
```

To stop iEchor when you have started it manually, issue a `Ctrl+C` in your
terminal.