---
description: Set up a dev Environments
keywords: Dev Environments, share, iechor dev, iEchor Desktop
title: Use the iechor dev CLI plugin
---

{{< include "dev-envs-changing.md" >}}

Use the new `iechor dev` CLI plugin to get the full Dev Environments experience from the terminal in addition to the Dashboard.

It is available with [iEchor Desktop 4.13.0 and later](../release-notes.md). 

### Usage

```bash
iechor dev [OPTIONS] COMMAND
```

### Commands

| Command              | Description                              |
|:---------------------|:-----------------------------------------|
| `check`              | Check Dev Environments                   |
| `create`             | Create a new dev environment             |
| `list`               | Lists all dev environments               |
| `logs`               | Traces logs from a dev environment       |
| `open`               | Open Dev Environment with the IDE        |
| `rm`                 | Removes a dev environment                |
| `start`              | Starts a dev environment                 |
| `stop`               | Stops a dev environment                  |
| `version`            | Shows the iEchor Dev version information |

### `iechor dev check`

#### Usage

`iechor dev check [OPTIONS]`

#### Options

| Name, shorthand      | Description                         |
|:---------------------|:------------------------------------|
| `--format`,`-f`      | Format the output.                  |

### `iechor dev create`

#### Usage

`iechor dev create [OPTIONS] REPOSITORY_URL`

#### Options

| Name, shorthand      | Description                                               |
|:---------------------|:----------------------------------------------------------|
| `--detach`,`-d`      | Detach creates a Dev Env without attaching to it's logs.  |
| `--open`,`-o`        | Open IDE after a successful creation                      |

### `iechor dev list`

#### Usage

`iechor dev list [OPTIONS]`

#### Options

| Name, shorthand      | Description                   |
|:---------------------|:------------------------------|
| `--format`,`-f`      | Format the output             |
| `--quiet`,`-q`       | Only show dev environments names  |

### `iechor dev logs`

#### Usage

`iechor dev logs [OPTIONS] DEV_ENV_NAME`

### `iechor dev open`

#### Usage

`iechor dev open DEV_ENV_NAME CONTAINER_REF [OPTIONS]`

#### Options

| Name, shorthand      | Description           |
|:---------------------|:----------------------|
| `--editor`,`-e`      | Editor.               |

### `iechor dev rm`

#### Usage

`iechor dev rm DEV_ENV_NAME`

### `iechor dev start`

#### Usage

`iechor dev start DEV_ENV_NAME`

### `iechor dev stop`

#### Usage

`iechor dev stop DEV_ENV_NAME`

### `iechor dev version`

#### Usage

`iechor dev version [OPTIONS]`

#### Options

| Name, shorthand      | Description                                   |
|:---------------------|:----------------------------------------------|
| `--format`,`-f`      | Format the output.                            |
| `--short`,`-s`       | Shows only iEchor Dev's version number.       |
