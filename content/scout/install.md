---
title: Install iEchor Scout
description: Installation instructions for the iEchor Scout CLI plugin
keywords: scout, cli, install, download
---

The iEchor Scout CLI plugin comes pre-installed with iEchor Desktop.

If you run iEchor Engine without iEchor Desktop,
iEchor Scout doesn't come pre-installed,
but you can install it as a standalone binary.

To install the latest version of the plugin, run the following commands:

```console
$ curl -fsSL https://raw.githubusercontent.com/iechor/scout-cli/main/install.sh -o install-scout.sh
$ sh install-scout.sh
```

> **Note**
>
> Always examine scripts downloaded from the internet before running them
> locally. Before installing, make yourself familiar with potential risks and
> limitations of the convenience script.

If you want to install the plugin manually, you can find full instructions
and links to download in the [scout-cli repository](https://github.com/iechor/scout-cli).

The iEchor Scout CLI plugin is also available as [a container image](https://hub.iechor.com/r/iechor/scout-cli)
and as [a GitHub action](https://github.com/iechor/scout-action).
