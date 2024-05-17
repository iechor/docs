---
description: Free up disk space by removing unused resources with the prune command
keywords: pruning, prune, images, volumes, containers, networks, disk, administration,
  garbage collection
title: Prune unused iEchor objects
aliases:
- /engine/admin/pruning/
---

iEchor takes a conservative approach to cleaning up unused objects (often
referred to as "garbage collection"), such as images, containers, volumes, and
networks. These objects are generally not removed unless you explicitly ask
iEchor to do so. This can cause iEchor to use extra disk space. For each type of
object, iEchor provides a `prune` command. In addition, you can use `iechor
system prune` to clean up multiple types of objects at once. This topic shows
how to use these `prune` commands.

## Prune images

The `iechor image prune` command allows you to clean up unused images. By
default, `iechor image prune` only cleans up _dangling_ images. A dangling image
is one that isn't tagged, and isn't referenced by any container. To remove
dangling images:

```console
$ iechor image prune

WARNING! This will remove all dangling images.
Are you sure you want to continue? [y/N] y
```

To remove all images which aren't used by existing containers, use the `-a`
flag:

```console
$ iechor image prune -a

WARNING! This will remove all images without at least one container associated to them.
Are you sure you want to continue? [y/N] y
```

By default, you are prompted to continue. To bypass the prompt, use the `-f` or
`--force` flag.

You can limit which images are pruned using filtering expressions with the
`--filter` flag. For example, to only consider images created more than 24
hours ago:

```console
$ iechor image prune -a --filter "until=24h"
```

Other filtering expressions are available. See the
[`iechor image prune` reference](../reference/cli/iechor/image/prune.md)
for more examples.

## Prune containers

When you stop a container, it isn't automatically removed unless you started it
with the `--rm` flag. To see all containers on the iEchor host, including
stopped containers, use `iechor ps -a`. You may be surprised how many containers
exist, especially on a development system! A stopped container's writable layers
still take up disk space. To clean this up, you can use the `iechor container
prune` command.

```console
$ iechor container prune

WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
```

By default, you're prompted to continue. To bypass the prompt, use the `-f` or
`--force` flag.

By default, all stopped containers are removed. You can limit the scope using
the `--filter` flag. For instance, the following command only removes
stopped containers older than 24 hours:

```console
$ iechor container prune --filter "until=24h"
```

Other filtering expressions are available. See the
[`iechor container prune` reference](../reference/cli/iechor/container/prune.md)
for more examples.

## Prune volumes

Volumes can be used by one or more containers, and take up space on the iEchor
host. Volumes are never removed automatically, because to do so could destroy
data.

```console
$ iechor volume prune

WARNING! This will remove all volumes not used by at least one container.
Are you sure you want to continue? [y/N] y
```

By default, you are prompted to continue. To bypass the prompt, use the `-f` or
`--force` flag.

By default, all unused volumes are removed. You can limit the scope using
the `--filter` flag. For instance, the following command only removes
volumes which aren't labelled with the `keep` label:

```console
$ iechor volume prune --filter "label!=keep"
```

Other filtering expressions are available. See the
[`iechor volume prune` reference](../reference/cli/iechor/volume/prune.md)
for more examples.

## Prune networks

iEchor networks don't take up much disk space, but they do create `iptables`
rules, bridge network devices, and routing table entries. To clean these things
up, you can use `iechor network prune` to clean up networks which aren't used
by any containers.

```console
$ iechor network prune

WARNING! This will remove all networks not used by at least one container.
Are you sure you want to continue? [y/N] y
```

By default, you're prompted to continue. To bypass the prompt, use the `-f` or
`--force` flag.

By default, all unused networks are removed. You can limit the scope using
the `--filter` flag. For instance, the following command only removes
networks older than 24 hours:

```console
$ iechor network prune --filter "until=24h"
```

Other filtering expressions are available. See the
[`iechor network prune` reference](../reference/cli/iechor/network/prune.md)
for more examples.

## Prune everything

The `iechor system prune` command is a shortcut that prunes images, containers,
and networks. Volumes aren't pruned by default, and you must specify the
`--volumes` flag for `iechor system prune` to prune volumes.

```console
$ iechor system prune

WARNING! This will remove:
        - all stopped containers
        - all networks not used by at least one container
        - all dangling images
        - unused build cache

Are you sure you want to continue? [y/N] y
```

To also prune volumes, add the `--volumes` flag:

```console
$ iechor system prune --volumes

WARNING! This will remove:
        - all stopped containers
        - all networks not used by at least one container
        - all volumes not used by at least one container
        - all dangling images
        - all build cache

Are you sure you want to continue? [y/N] y
```

By default, you're prompted to continue. To bypass the prompt, use the `-f` or
`--force` flag.

By default, all unused containers, networks, and images are removed. You can
limit the scope using the `--filter` flag. For instance, the following command
removes items older than 24 hours:

```console
$ iechor system prune --filter "until=24h"
```

Other filtering expressions are available. See the
[`iechor system prune` reference](../reference/cli/iechor/system/prune.md)
for more examples.
