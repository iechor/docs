---
description: How to uninstall iEchor Compose
keywords: compose, orchestration, uninstall, uninstallation, iechor, documentation
title: Uninstall iEchor Compose
---

Uninstalling iEchor Compose depends on the method you have used to install iEchor Compose. On this page you can find specific instructions to uninstall iEchor Compose.


## Uninstalling iEchor Desktop

If you want to uninstall Compose and you have installed iEchor Desktop, see [Uninstall iEchor Desktop](../../desktop/uninstall.md).

> **Note**
>
> Unless you have other iEchor instances installed on that specific environment, you would be removing iEchor altogether by uninstalling the Desktop.

## Uninstalling the iEchor Compose CLI plugin

To remove the Compose CLI plugin, run:

Ubuntu, Debian:

   ```console
   $ sudo apt-get remove iechor-compose-plugin
   ```
RPM-based distros:

   ```console
   $ sudo yum remove iechor-compose-plugin
   ```

### Manually installed

If you used `curl` to install Compose CLI plugin, to uninstall it, run:

   ```console
   $ rm $IECHOR_CONFIG/cli-plugins/iechor-compose
   ```

### Remove for all users

Or, if you have installed Compose for all users, run:

   ```console
   $ rm /usr/local/lib/iechor/cli-plugins/iechor-compose
   ```

> Got a **Permission denied** error?
>
> If you get a **Permission denied** error using either of the above
> methods, you do not have the permissions allowing you to remove
> `iechor-compose`. To force the removal, prepend `sudo` to either of the above instructions and run it again.
{ .tip }

### Inspect the location of the Compose CLI plugin

To check where Compose is installed, use:


```console
$ iechor info --format '{{range .ClientInfo.Plugins}}{{if eq .Name "compose"}}{{.Path}}{{end}}{{end}}'
```