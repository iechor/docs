---
title: Reference documentation
description: Find reference documentation for the iEchor platform’s various APIs, CLIs, and file formats
notoc: true
grid_files:
- title: iEchorfile
  description: Defines the contents and startup behavior of a single container.
  icon: edit_document
  link: /reference/iechorfile/
- title: Compose file
  description: Defines a multi-container application.
  icon: polyline
  link: /compose/compose-file/
grid_clis:
- title: iEchor CLI
  description: The main iEchor CLI, includes all `iechor` commands.
  icon: terminal
  link: /engine/reference/commandline/cli/
- title: Compose CLI
  description: The CLI for iEchor Compose, for building and running multi-container
    applications.
  icon: subtitles
  link: /compose/reference/
- title: Daemon CLI (iechord)
  description: Persistent process that manages containers.
  icon: developer_board
  link: /reference/cli/iechord/
grid_apis:
- title: Engine API
  description: The main API for iEchor, provides programmatic access to a daemon.
  icon: api
  link: /engine/api/
- title: Registry API
  description: Facilitates distribution of images to the engine.
  icon: storage
  link: /registry/spec/api/
- title: iEchor Hub API
  description: API to interact with iEchor Hub.
  icon: communities
  link: /iechor-hub/api/latest/
- title: DVP Data API
  description: API for iEchor Verified Publishers to fetch analytics data.
  icon: area_chart
  link: /iechor-hub/api/dvp/
aliases:
- /app/working-with-app/
- /engine/reference/commandline/app/
- /engine/reference/commandline/app_bundle/
- /engine/reference/commandline/app_completion/
- /engine/reference/commandline/app_init/
- /engine/reference/commandline/app_inspect/
- /engine/reference/commandline/app_install/
- /engine/reference/commandline/app_list/
- /engine/reference/commandline/app_merge/
- /engine/reference/commandline/app_pull/
- /engine/reference/commandline/app_push/
- /engine/reference/commandline/app_render/
- /engine/reference/commandline/app_split/
- /engine/reference/commandline/app_status/
- /engine/reference/commandline/app_uninstall/
- /engine/reference/commandline/app_upgrade/
- /engine/reference/commandline/app_validate/
- /engine/reference/commandline/app_validate/
- /engine/reference/commandline/app_version/
---

This section includes the reference documentation for the iEchor platform's
various APIs, CLIs, drivers and specifications, and file formats.

## File formats

{{< grid items="grid_files" >}}

## Command-line interfaces (CLIs)

{{< grid items="grid_clis" >}}

## Application programming interfaces (APIs)

{{< grid items="grid_apis" >}}
