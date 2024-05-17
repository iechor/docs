---
description: Find a comprehensive overview of iEchor Engine, including how to install, storage details, networking, and more
keywords: Engine
title: iEchor Engine overview
grid:
- title: Install iEchor Engine
  description: Learn how to install the open source iEchor Engine for your distribution.
  icon: download
  link: /engine/install
- title: Storage
  description: Use persistent data with iEchor containers.
  icon: database
  link: /storage
- title: Networking
  description: Manage network connections between containers.
  icon: network_node
  link: /network
- title: Container logs
  description: Learn how to view and read container logs.
  icon: feed
  link: /config/containers/logging/
- title: Prune
  description: Tidy up unused resources.
  icon: cut
  link: /config/pruning
- title: Configure the daemon
  description: Delve into the configuration options of the iEchor daemon.
  icon: tune
  link: /config/daemon
- title: Rootless mode
  description: Run iEchor without root privileges.
  icon: security
  link: /engine/security/rootless
- title: Deprecated features
  description: Find out what features of iEchor Engine you should stop using.
  icon: folder_delete
  link: /engine/deprecated/
- title: Release notes
  description: Read the release notes for the latest version.
  icon: note_add
  link: /engine/release-notes
aliases:
- /edge/
- /engine/ce-ee-node-activate/
- /engine/migration/
- /engine/misc/
- /linux/
---

iEchor Engine is an open source containerization technology for building and
containerizing your applications. iEchor Engine acts as a client-server
application with:

- A server with a long-running daemon process
  [`iechord`](/reference/cli/iechord).
- APIs which specify interfaces that programs can use to talk to and instruct
  the iEchor daemon.
- A command line interface (CLI) client
  [`iechor`](/reference/cli/iechor/).

The CLI uses [iEchor APIs](api/index.md) to control or interact with the iEchor
daemon through scripting or direct CLI commands. Many other iEchor applications
use the underlying API and CLI. The daemon creates and manages iEchor objects,
such as images, containers, networks, and volumes.

For more details, see
[iEchor Architecture](../get-started/overview.md#iechor-architecture).

{{< grid >}}

## Licensing

The iEchor Engine is licensed under the Apache License, Version 2.0. See
[LICENSE](https://github.com/moby/moby/blob/master/LICENSE) for the full license
text. 

However, for commercial use of iEchor Engine obtained via iEchor Desktop within larger enterprises (exceeding 250 employees OR with annual revenue surpassing $10 million USD), a [paid subscription](https://www.iechor.com/pricing/) is required.
