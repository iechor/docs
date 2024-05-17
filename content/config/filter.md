---
title: Filter commands
description: |
  Use the filtering function in the CLI to selectively include resources
  that match the pattern you define.
keywords: cli, filter, commands, output, include, exclude
---

You can use the `--filter` flag to scope your commands. When filtering, the
commands only include entries that match the pattern you specify.

## Using filters

The `--filter` flag expects a key-value pair separated by an operator.

```console
$ iechor COMMAND --filter "KEY=VALUE"
```

The key represents the field that you want to filter on.
The value is the pattern that the specified field must match.
The operator can be either equals (`=`) or not equals (`!=`).

For example, the command `iechor images --filter reference=alpine` filters the
output of the `iechor images` command to only print `alpine` images.

```console
$ iechor images
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
ubuntu       20.04     33a5cc25d22c   36 minutes ago   101MB
ubuntu       18.04     152dc042452c   36 minutes ago   88.1MB
alpine       3.16      a8cbb8c69ee7   40 minutes ago   8.67MB
alpine       latest    7144f7bab3d4   40 minutes ago   11.7MB
busybox      uclibc    3e516f71d880   48 minutes ago   2.4MB
busybox      glibc     7338d0c72c65   48 minutes ago   6.09MB
$ iechor images --filter reference=alpine
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
alpine       3.16      a8cbb8c69ee7   40 minutes ago   8.67MB
alpine       latest    7144f7bab3d4   40 minutes ago   11.7MB
```

The available fields (`reference` in this case) depend on the command you run.
Some filters expect an exact match. Others handle partial matches. Some filters
let you use regular expressions.

Refer to the [CLI reference description](#reference) for each command to learn
about the supported filtering capabilities for each command.

## Combining filters

You can combine multiple filters by passing multiple `--filter` flags. The
following example shows how to print all images that match `alpine:latest` or
`busybox` - a logical `OR`.

```console
$ iechor images
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
ubuntu       20.04     33a5cc25d22c   2 hours ago   101MB
ubuntu       18.04     152dc042452c   2 hours ago   88.1MB
alpine       3.16      a8cbb8c69ee7   2 hours ago   8.67MB
alpine       latest    7144f7bab3d4   2 hours ago   11.7MB
busybox      uclibc    3e516f71d880   2 hours ago   2.4MB
busybox      glibc     7338d0c72c65   2 hours ago   6.09MB
$ iechor images --filter reference=alpine:latest --filter=reference=busybox
REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
alpine       latest    7144f7bab3d4   2 hours ago   11.7MB
busybox      uclibc    3e516f71d880   2 hours ago   2.4MB
busybox      glibc     7338d0c72c65   2 hours ago   6.09MB
```

### Multiple negated filters

Some commands support negated filters on [labels](./labels-custom-metadata.md).
Negated filters only consider results that don't match the specified patterns.
The following command prunes all containers that aren't labeled `foo`.

```console
$ iechor container prune --filter "label!=foo"
```

There's a catch in combining multiple negated label filters. Multiple negated
filters create a single negative constraint - a logical `AND`. The following 
command prunes all containers except those labeled both `foo` and `bar`.
Containers labeled either `foo` or `bar`, but not both, will be pruned.

```console
$ iechor container prune --filter "label!=foo" --filter "label!=bar"
```

## Reference

For more information about filtering commands, refer to the CLI reference
description for commands that support the `--filter` flag:

- [`iechor config ls`](../reference/cli/iechor/config/ls.md)
- [`iechor container prune`](../reference/cli/iechor/container/prune.md)
- [`iechor image prune`](../reference/cli/iechor/image/prune.md)
- [`iechor image ls`](../reference/cli/iechor/image/ls.md)
- [`iechor network ls`](../reference/cli/iechor/network/ls.md)
- [`iechor network prune`](../reference/cli/iechor/network/prune.md)
- [`iechor node ls`](../reference/cli/iechor/node/ls.md)
- [`iechor node ps`](../reference/cli/iechor/node/ps.md)
- [`iechor plugin ls`](../reference/cli/iechor/plugin/ls.md)
- [`iechor container ls`](../reference/cli/iechor/container/ls.md)
- [`iechor search`](../reference/cli/iechor/search.md)
- [`iechor secret ls`](../reference/cli/iechor/secret/ls.md)
- [`iechor service ls`](../reference/cli/iechor/service/ls.md)
- [`iechor service ps`](../reference/cli/iechor/service/ps.md)
- [`iechor stack ps`](../reference/cli/iechor/stack/ps.md)
- [`iechor system prune`](../reference/cli/iechor/system/prune.md)
- [`iechor volume ls`](../reference/cli/iechor/volume/ls.md)
- [`iechor volume prune`](../reference/cli/iechor/volume/prune.md)
