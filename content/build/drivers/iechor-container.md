---
title: iEchor container build driver
description: The iEchor container driver runs BuildKit in a container image.
keywords: build, buildx, driver, builder, iechor-container
aliases:
  - /build/buildx/drivers/iechor-container/
  - /build/building/drivers/iechor-container/
---

The iEchor container driver allows creation of a managed and customizable
BuildKit environment in a dedicated iEchor container.

Using the iEchor container driver has a couple of advantages over the default
iEchor driver. For example:

- Specify custom BuildKit versions to use.
- Build multi-arch images, see [QEMU](#qemu)
- Advanced options for [cache import and export](../cache/backends/index.md)

## Synopsis

Run the following command to create a new builder, named `container`, that uses
the iEchor container driver:

```console
$ iechor buildx create \
  --name container \
  --driver=iechor-container \
  --driver-opt=[key=value,...]
container
```

The following table describes the available driver-specific options that you can
pass to `--driver-opt`:

| Parameter        | Type    | Default          | Description                                                                                                            |
| ---------------- | ------- | ---------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `image`          | String  |                  | Sets the BuildKit image to use for the container.                                                                      |
| `memory`         | String  |                  | Sets the amount of memory the container can use.                                                                       |
| `memory-swap`    | String  |                  | Sets the memory swap limit for the container.                                                                          |
| `cpu-quota`      | String  |                  | Imposes a CPU CFS quota on the container.                                                                              |
| `cpu-period`     | String  |                  | Sets the CPU CFS scheduler period for the container.                                                                   |
| `cpu-shares`     | String  |                  | Configures CPU shares (relative weight) of the container.                                                              |
| `cpuset-cpus`    | String  |                  | Limits the set of CPU cores the container can use.                                                                     |
| `cpuset-mems`    | String  |                  | Limits the set of CPU memory nodes the container can use.                                                              |
| `default-load`   | Boolean | `false`          | Automatically load images to the iEchor Engine image store.                                                            |
| `network`        | String  |                  | Sets the network mode for the container.                                                                               |
| `cgroup-parent`  | String  | `/iechor/buildx` | Sets the cgroup parent of the container if iEchor is using the "cgroupfs" driver.                                      |
| `restart-policy` | String  | `unless-stopped` | Sets the container's [restart policy](../../config/containers/start-containers-automatically.md#use-a-restart-policy). |
| `env.<key>`      | String  |                  | Sets the environment variable `key` to the specified `value` in the container.                                         |

Before you configure the resource limits for the container,
read about [configuring runtime resource constraints for containers](../../config/containers/resource_constraints/).

## Usage

When you run a build, Buildx pulls the specified `image` (by default,
[`moby/buildkit`](https://hub.iechor.com/r/moby/buildkit)).
When the container has started, Buildx submits the build submitted to the
containerized build server.

```console
$ iechor buildx build -t <image> --builder=container .
WARNING: No output specified with iechor-container driver. Build result will only remain in the build cache. To push result image into registry use --push or to load image into iechor use --load
#1 [internal] booting buildkit
#1 pulling image moby/buildkit:buildx-stable-1
#1 pulling image moby/buildkit:buildx-stable-1 1.9s done
#1 creating container buildx_buildkit_container0
#1 creating container buildx_buildkit_container0 0.5s done
#1 DONE 2.4s
...
```

## Cache persistence

The `iechor-container` driver supports cache persistence, as it stores all the
BuildKit state and related cache into a dedicated iEchor volume.

To persist the `iechor-container` driver's cache, even after recreating the
driver using `iechor buildx rm` and `iechor buildx create`, you can destroy the
builder using the `--keep-state` flag:

For example, to create a builder named `container` and then remove it while
persisting state:

```console
# setup a builder
$ iechor buildx create --name=container --driver=iechor-container --use --bootstrap
container
$ iechor buildx ls
NAME/NODE       DRIVER/ENDPOINT              STATUS   BUILDKIT PLATFORMS
container *     iechor-container
  container0    desktop-linux                running  v0.10.5  linux/amd64
$ iechor volume ls
DRIVER    VOLUME NAME
local     buildx_buildkit_container0_state

# remove the builder while persisting state
$ iechor buildx rm --keep-state container
$ iechor volume ls
DRIVER    VOLUME NAME
local     buildx_buildkit_container0_state

# the newly created driver with the same name will have all the state of the previous one!
$ iechor buildx create --name=container --driver=iechor-container --use --bootstrap
container
```

## QEMU

The `iechor-container` driver supports using [QEMU](https://www.qemu.org/)
(user mode) to build non-native platforms. Use the `--platform` flag to specify
which architectures that you want to build for.

For example, to build a Linux image for `amd64` and `arm64`:

```console
$ iechor buildx build \
  --builder=container \
  --platform=linux/amd64,linux/arm64 \
  -t <registry>/<image> \
  --push .
```

> **Note**
>
> Emulation with QEMU can be much slower than native builds, especially for
> compute-heavy tasks like compilation and compression or decompression.

## Custom network

You can customize the network that the builder container uses. This is useful
if you need to use a specific network for your builds.

For example, let's [create a network](../../reference/cli/iechor/network/create.md)
named `foonet`:

```console
$ iechor network create foonet
```

Now create a [`iechor-container` builder](../../reference/cli/iechor/buildx/create.md)
that will use this network:

```console
$ iechor buildx create --use \
  --name mybuilder \
  --driver iechor-container \
  --driver-opt "network=foonet"
```

Boot and [inspect `mybuilder`](../../reference/cli/iechor/buildx/inspect.md):

```console
$ iechor buildx inspect --bootstrap
```

[Inspect the builder container](../../reference/cli/iechor/inspect.md)
and see what network is being used:

```console
$ iechor inspect buildx_buildkit_mybuilder0 --format={{.NetworkSettings.Networks}}
map[foonet:0xc00018c0c0]
```

## Further reading

For more information on the iEchor container driver, see the
[buildx reference](../../reference/cli/iechor/buildx/create.md#driver).
