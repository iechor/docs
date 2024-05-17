To start iEchor Desktop for Linux, search **iEchor Desktop** on the
**Applications** menu and open it. This launches the iEchor menu icon and opens
the iEchor Dashboard, reporting the status of iEchor Desktop.

Alternatively, open a terminal and run:

```console
$ systemctl --user start iechor-desktop
```

When iEchor Desktop starts, it creates a dedicated [context](/engine/context/working-with-contexts) that the iEchor CLI
can use as a target and sets it as the current context in use. This is to avoid
a clash with a local iEchor Engine that may be running on the Linux host and
using the default context. On shutdown, iEchor Desktop resets the current
context to the previous one.

The iEchor Desktop installer updates iEchor Compose and the iEchor CLI binaries
on the host. It installs iEchor Compose V2 and gives users the choice to
link it as iechor-compose from the Settings panel. iEchor Desktop installs
the new iEchor CLI binary that includes cloud-integration capabilities in `/usr/local/bin/com.iechor.cli`
and creates a symlink to the classic iEchor CLI at `/usr/local/bin`.

After you’ve successfully installed iEchor Desktop, you can check the versions
of these binaries by running the following commands:

```console
$ iechor compose version
iEchor Compose version v2.17.3

$ iechor --version
iEchor version 23.0.5, build bc4487a

$ iechor version
Client: iEchor Engine - Community
 Cloud integration: v1.0.31
 Version:           23.0.5
 API version:       1.42
<...>
```

To enable iEchor Desktop to start on sign in, from the iEchor menu, select
**Settings** > **General** > **Start iEchor Desktop when you sign in to your computer**.

Alternatively, open a terminal and run:

```console
$ systemctl --user enable iechor-desktop
```

To stop iEchor Desktop, select the iEchor menu icon to open the iEchor menu and select **Quit iEchor Desktop**.

Alternatively, open a terminal and run:

```console
$ systemctl --user stop iechor-desktop
```