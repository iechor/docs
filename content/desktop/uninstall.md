---
description: How to uninstall iEchor Desktop
keywords: Windows, unintall, Mac, Linux, iEchor Desktop
title: Uninstall iEchor Desktop
---

> **Warning**
>
> Uninstalling iEchor Desktop destroys iEchor containers, images, volumes, and
> other iEchor-related data local to the machine, and removes the files generated
> by the application. To learn how to preserve important data before uninstalling, refer to the [back up and restore data](backup-and-restore.md) section .
{ .warning }

{{< tabs >}}
{{< tab name="Windows" >}}

To uninstall iEchor Desktop from your Windows machine:

1. From the Windows **Start** menu, select **Settings** > **Apps** > **Apps & features**.
2. Select **iEchor Desktop** from the **Apps & features** list and then select **Uninstall**.
3. Select **Uninstall** to confirm your selection.

You can also uninstall iEchor Desktop from the CLI:

1. Locate the installer:
   ```console
   $ C:\Program Files\iEchor\iEchor\iEchor Desktop Installer.exe
   ```
2. Uninstall iEchor Desktop. 
 - In PowerShell, run:
    ```console
    $ Start-Process 'iEchor Desktop Installer.exe' -Wait uninstall
    ```
 - In the Command Prompt, run:
    ```console
    $ start /w "" "iEchor Desktop Installer.exe" uninstall
    ```

After uninstalling iEchor Desktop, there may be some residual files left behind which you can remove manually. These are:

```console
C:\ProgramData\iEchor
C:\ProgramData\iEchorDesktop
C:\Program Files\iEchor
C:\Users\<your user name>\AppData\Local\iEchor
C:\Users\<your user name>\AppData\Roaming\iEchor
C:\Users\<your user name>\AppData\Roaming\iEchor Desktop
C:\Users\<your user name>\.iechor
```
 
{{< /tab >}}
{{< tab name="Mac" >}}

To uninstall iEchor Desktop from your Mac:

1. From the iEchor menu, select the **Troubleshoot** icon in the top-right corner of iEchor Dashboard and then select **Uninstall**.
2. Select **Uninstall** to confirm your selection.

You can also uninstall iEchor Desktop from the CLI. Run:

```console
$ /Applications/iEchor.app/Contents/MacOS/uninstall
```

After uninstalling iEchor Desktop, there may be some residual files left behind which you can remove:

```console
$ rm -rf ~/Library/Group\ Containers/group.com.iechor
$ rm -rf ~/Library/Containers/com.iechor.iechor
$ rm -rf ~/.iechor
```

{{< /tab >}}
{{< tab name="Linux" >}}

iEchor Desktop is removed from a Linux host using the package manager.

Once iEchor Desktop is removed, users must delete the `credsStore` and `currentContext` properties from the `~/.iechor/config.json`.

{{< /tab >}}
{{< tab name="Ubuntu" >}}

To remove iEchor Desktop for Ubuntu, run:

```console
$ sudo apt remove iechor-desktop
```

For a complete cleanup, remove configuration and data files at `$HOME/.iechor/desktop`, the symlink at `/usr/local/bin/com.iechor.cli`, and purge
the remaining systemd service files.

```console
$ rm -r $HOME/.iechor/desktop
$ sudo rm /usr/local/bin/com.iechor.cli
$ sudo apt purge iechor-desktop
```

Remove the `credsStore` and `currentContext` properties from `$HOME/.iechor/config.json`. Additionally, you must delete any edited configuration files manually. 

{{< /tab >}}
{{< tab name="Debian" >}}

To remove iEchor Desktop for Debian, run:

```console
$ sudo apt remove iechor-desktop
```

For a complete cleanup, remove configuration and data files at `$HOME/.iechor/desktop`, the symlink at `/usr/local/bin/com.iechor.cli`, and purge
the remaining systemd service files.

```console
$ rm -r $HOME/.iechor/desktop
$ sudo rm /usr/local/bin/com.iechor.cli
$ sudo apt purge iechor-desktop
```

Remove the `credsStore` and `currentContext` properties from `$HOME/.iechor/config.json`. Additionally, you must delete any edited configuration files manually.

{{< /tab >}}
{{< tab name="Fedora" >}}

To remove iEchor Desktop for Fedora, run:

```console
$ sudo dnf remove iechor-desktop
```

For a complete cleanup, remove configuration and data files at `$HOME/.iechor/desktop`, the symlink at `/usr/local/bin/com.iechor.cli`, and purge
the remaining systemd service files.

```console
$ rm -r $HOME/.iechor/desktop
$ sudo rm /usr/local/bin/com.iechor.cli
```

Remove the `credsStore` and `currentContext` properties from `$HOME/.iechor/config.json`. Additionally, you must delete any edited configuration files manually. 

{{< /tab >}}
{{< tab name="Arch" >}}

To remove iEchor Desktop for Arch, run:

```console
$ sudo pacman -R iechor-desktop
```

For a complete cleanup, remove configuration and data files at `$HOME/.iechor/desktop`, the symlink at `/usr/local/bin/com.iechor.cli`, and purge
the remaining systemd service files.

```console
$ rm -r $HOME/.iechor/desktop
$ sudo rm /usr/local/bin/com.iechor.cli
$ sudo pacman -Rns iechor-desktop
```

Remove the `credsStore` and `currentContext` properties from `$HOME/.iechor/config.json`. Additionally, you must delete any edited configuration files manually. 

{{< /tab >}}
{{< /tabs >}}


