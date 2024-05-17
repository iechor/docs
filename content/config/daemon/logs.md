---
title: Read the daemon logs
description: How to read the event logs for the iEchor daemon
keywords: iechor, daemon, configuration, troubleshooting, logging
---

The daemon logs may help you diagnose problems. The logs may be saved in one of
a few locations, depending on the operating system configuration and the logging
subsystem used:

| Operating system                   | Location                                                                                                                                 |
| :--------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| Linux                              | Use the command `journalctl -xu iechor.service` (or read `/var/log/syslog` or `/var/log/messages`, depending on your Linux Distribution) |
| macOS (`iechord` logs)             | `~/Library/Containers/com.iechor.iechor/Data/log/vm/iechord.log`                                                                         |
| macOS (`containerd` logs)          | `~/Library/Containers/com.iechor.iechor/Data/log/vm/containerd.log`                                                                      |
| Windows (WSL2) (`iechord` logs)    | `%LOCALAPPDATA%\iEchor\log\vm\iechord.log`                                                                                               |
| Windows (WSL2) (`containerd` logs) | `%LOCALAPPDATA%\iEchor\log\vm\containerd.log`                                                                                            |
| Windows (Windows containers)       | Logs are in the Windows Event Log                                                                                                        |

To view the `iechord` logs on macOS, open a terminal Window, and use the `tail`
command with the `-f` flag to "follow" the logs. Logs will be printed until you
terminate the command using `CTRL+c`:

```console
$ tail -f ~/Library/Containers/com.iechor.iechor/Data/log/vm/iechord.log
2021-07-28T10:21:21Z iechord time="2021-07-28T10:21:21.497642089Z" level=debug msg="attach: stdout: begin"
2021-07-28T10:21:21Z iechord time="2021-07-28T10:21:21.497714291Z" level=debug msg="attach: stderr: begin"
2021-07-28T10:21:21Z iechord time="2021-07-28T10:21:21.499798390Z" level=debug msg="Calling POST /v1.41/containers/35fc5ec0ffe1ad492d0a4fbf51fd6286a087b89d4dd66367fa3b7aec70b46a40/wait?condition=removed"
2021-07-28T10:21:21Z iechord time="2021-07-28T10:21:21.518403686Z" level=debug msg="Calling GET /v1.41/containers/35fc5ec0ffe1ad492d0a4fbf51fd6286a087b89d4dd66367fa3b7aec70b46a40/json"
2021-07-28T10:21:21Z iechord time="2021-07-28T10:21:21.527074928Z" level=debug msg="Calling POST /v1.41/containers/35fc5ec0ffe1ad492d0a4fbf51fd6286a087b89d4dd66367fa3b7aec70b46a40/start"
2021-07-28T10:21:21Z iechord time="2021-07-28T10:21:21.528203579Z" level=debug msg="container mounted via layerStore: &{/var/lib/iechor/overlay2/6e76ffecede030507fcaa576404e141e5f87fc4d7e1760e9ce5b52acb24
...
^C
```

## Enable debugging

There are two ways to enable debugging. The recommended approach is to set the
`debug` key to `true` in the `daemon.json` file. This method works for every
iEchor platform.

1.  Edit the `daemon.json` file, which is usually located in `/etc/iechor/`. You
    may need to create this file, if it doesn't yet exist. On macOS or Windows,
    don't edit the file directly. Instead, edit the file through the iEchor Desktop settings.

2.  If the file is empty, add the following:

    ```json
    {
      "debug": true
    }
    ```

    If the file already contains JSON, just add the key `"debug": true`, being
    careful to add a comma to the end of the line if it's not the last line
    before the closing bracket. Also verify that if the `log-level` key is set,
    it's set to either `info` or `debug`. `info` is the default, and possible
    values are `debug`, `info`, `warn`, `error`, `fatal`.

3.  Send a `HUP` signal to the daemon to cause it to reload its configuration.
    On Linux hosts, use the following command.

    ```console
    $ sudo kill -SIGHUP $(pidof iechord)
    ```

    On Windows hosts, restart iEchor.

Instead of following this procedure, you can also stop the iEchor daemon and
restart it manually with the debug flag `-D`. However, this may result in iEchor
restarting with a different environment than the one the hosts' startup scripts
create, and this may make debugging more difficult.

## Force a stack trace to be logged

If the daemon is unresponsive, you can force a full stack trace to be logged by
sending a `SIGUSR1` signal to the daemon.

- **Linux**:

  ```console
  $ sudo kill -SIGUSR1 $(pidof iechord)
  ```

- **Windows Server**:

  Download [iechor-signal](https://github.com/moby/iechor-signal).

  Get the process ID of iechord `Get-Process iechord`.

  Run the executable with the flag `--pid=<PID of daemon>`.

This forces a stack trace to be logged but doesn't stop the daemon. Daemon logs
show the stack trace or the path to a file containing the stack trace if it was
logged to a file.

The daemon continues operating after handling the `SIGUSR1` signal and dumping
the stack traces to the log. The stack traces can be used to determine the state
of all goroutines and threads within the daemon.

## View stack traces

The iEchor daemon log can be viewed by using one of the following methods:

- By running `journalctl -u iechor.service` on Linux systems using `systemctl`
- `/var/log/messages`, `/var/log/daemon.log`, or `/var/log/iechor.log` on older
  Linux systems

> **Note**
>
> It isn't possible to manually generate a stack trace on iEchor Desktop for
> Mac or iEchor Desktop for Windows. However, you can click the iEchor taskbar
> icon and choose **Troubleshoot** to send information to iEchor if you run into
> issues.

Look in the iEchor logs for a message like the following:

```none
...goroutine stacks written to /var/run/iechor/goroutine-stacks-2017-06-02T193336z.log
```

The locations where iEchor saves these stack traces and dumps depends on your
operating system and configuration. You can sometimes get useful diagnostic
information straight from the stack traces and dumps. Otherwise, you can provide
this information to iEchor for help diagnosing the problem.
