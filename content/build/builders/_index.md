---
title: Builders
keywords: build, buildx, builders, buildkit, drivers, backend
description: Learn about builders and how to manage them
---

A builder is a BuildKit daemon that you can use to run your builds. BuildKit
is the build engine that solves the build steps in a iEchorfile to produce a
container image or other artifacts.

You can create and manage builders, inspect them, and even connect to builders
running remotely. You interact with builders using the iEchor CLI.

## Default builder

iEchor Engine automatically creates a builder that becomes the default backend
for your builds. This builder uses the BuildKit library bundled with the
daemon. This builder requires no configuration.

The default builder is directly bound to the iEchor daemon and its
[context](../../engine/context/working-with-contexts.md). If you change the
iEchor context, your `default` builder refers to the new iEchor context.

## Build drivers

Buildx implements a concept of [build drivers](../drivers/index.md) to refer to
different builder configurations. The default builder created by the daemon
uses the [`iechor` driver](../drivers/iechor.md).

Buildx supports the following build drivers:

- `iechor`: uses the BuildKit library bundled into the iEchor daemon.
- `iechor-container`: creates a dedicated BuildKit container using iEchor.
- `kubernetes`: creates BuildKit pods in a Kubernetes cluster.
- `remote`: connects directly to a manually managed BuildKit daemon.

## Selected builder

Selected builder refers to the builder that's used by default when you run
build commands.

When you run a build, or interact with builders in some way using the CLI,
you can use the optional `--builder` flag, or the `BUILDX_BUILDER`
[environment variable](../building/variables.md#buildx_builder),
to specify a builder by name. If you don't specify a builder,
the selected builder is used.

Use the `iechor buildx ls` command to see the available builder instances.
The asterisk (`*`) next to a builder name indicates the selected builder.

```console
$ iechor buildx ls
NAME/NODE       DRIVER/ENDPOINT      STATUS   BUILDKIT PLATFORMS
default *       iechor
  default       default              running  v0.11.6  linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/386
my_builder      iechor-container
  my_builder0   default              running  v0.11.6  linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/386
```

### Select a different builder

To switch between builders, use the `iechor buildx use <name>` command.

After running this command, the builder you specify is automatically
selected when you invoke builds.

## Additional information

- For information about how to interact with and manage builders,
  see [Manage builders](./manage.md)
- To learn about different types of builders,
  see [Build drivers](../drivers/index.md)
