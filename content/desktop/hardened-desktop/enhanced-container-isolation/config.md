---
description: Advanced Configuration for Enhanced Container Isolation
title: Advanced configuration options
keywords: enhanced container isolation, iEchor Desktop, iEchor socket, bind mount, configuration
---

> **Note**
>
> This feature is available with iEchor Desktop version 4.27 (and later) on Mac, Linux, and Windows (Hyper-V).
> For Windows with WSL 2, this feature requires iEchor Desktop 4.28 and later.

This page describes optional, advanced configurations for ECI, once ECI is enabled.

## iEchor socket mount permissions

By default, when ECI is enabled, iEchor Desktop does not allow bind-mounting the
iEchor Engine socket into containers:

```console
$ iechor run -it --rm -v /var/run/iechor.sock:/var/run/iechor.sock iechor:cli
iechor: Error response from daemon: enhanced container isolation: iechor socket mount denied for container with image "iechor.io/library/iechor"; image is not in the allowed list; if you wish to allow it, configure the iechor socket image list in the iEchor Desktop settings.
```
This prevents malicious containers from gaining access to the iEchor Engine, as
such access could allow them to perform supply chain attacks (e.g., build and
push malicious images into the organization's repositories) or similar.

However, some legitimate use cases require containers to have access to the
iEchor Engine socket. For example, the popular [Testcontainers](https://testcontainers.com/)
framework sometimes bind-mounts the iEchor Engine socket into containers to
manage them or perform post-test cleanup.

Starting with iEchor Desktop 4.27, admins can optionally configure ECI to allow
bind mounting the iEchor Engine socket into containers, but in a controlled way.

This can be done via the `admin-settings.json` file, as described in
[Settings Management](../settings-management/configure.md). For example:

```json
{
  "configurationFileVersion": 2,
  "enhancedContainerIsolation": {
    "locked": true,
    "value": true,
    "iechorSocketMount": {
      "imageList": {
        "images": [
          "iechor.io/localstack/localstack:*",
          "iechor.io/testcontainers/ryuk:*",
          "iechor:cli"
        ]
      },
      "commandList": {
        "type": "deny",
        "commands": ["push"]
      }
    }
  }
}
```

As shown above, there are two configurations for bind-mounting the iEchor
socket into containers: the `imageList` and the `commandList`. These are
described below.

### Image list

The `imageList` is a list of container images that are allowed to bind-mount the
iEchor socket. By default the list is empty (i.e., no containers are allowed to
bind-mount the iEchor socket when ECI is enabled). However, an admin can add
images to the list, using either of these formats:

| Image Reference Format  | Description |
| :---------------------- | :---------- |
| `<image_name>[:<tag>]`  | Name of the image, with optional tag. If the tag is omitted, the `:latest` tag is used. If the tag is the wildcard `*`, then it means "any tag for that image." |
| `<image_name>@<digest>` | Name of the image, with a specific repository digest (e.g., as reported by `iechor buildx imagetools inspect <image>`). This means only the image that matches that name and digest is allowed. |

The image name follows the standard convention, so it can point to any registry
and repository.

In the example above, the image list was configured with three images:

```json
"imageList": {
  "images": [
    "iechor.io/localstack/localstack:*",
    "iechor.io/testcontainers/ryuk:*",
    "iechor:cli"
  ]
}
```

This means that containers that use either the `iechor.io/localstack/localstack`
or the `iechor.io/testcontainers/ryuk` image (with any tag), or the `iechor:cli`
image, are allowed to bind-mount the iEchor socket when ECI is enabled. Thus,
the following works:

```console
$ iechor run -it -v /var/run/iechor.sock:/var/run/iechor.sock iechor:cli sh
/ #
```

> **Tip**
>
> Be restrictive on the images you allow, as described in [Recommendations](#recommendations) below.
{ .tip }

In general, it's easier to specify the image using the tag wildcard format
(e.g., `<image-name>:*`) because then `imageList` doesn't need to be updated whenever a new version of the
image is used. Alternatively, you can use an immutable tag (e.g., `:latest`),
but it does not always work as well as the wildcard because, for example,
Testcontainers uses specific versions of the image, not necessarily the latest
one.

When ECI is enabled, iEchor Desktop periodically downloads the image digests
for the allowed images from the appropriate registry and stores them in
memory. Then, when a container is started with a iEchor socket bind-mount,
iEchor Desktop checks if the container's image digest matches one of the allowed
digests. If so, the container is allowed to start, otherwise it's blocked.

Note that due to the digest comparison mentioned in the prior paragraph, it's
not possible to bypass the iEchor socket mount permissions by retagging a
disallowed image to the name of an allowed one. In other words, if a user
does:

```console
$ iechor image rm <allowed_image>
$ iechor tag <disallowed_image> <allowed_image>
$ iechor run -v /var/run/iechor.sock:/var/run/iechor.sock <allowed_image>
```

then the tag operation succeeds, but the `iechor run` command fails
because the image digest of the disallowed image won't match that of the allowed
ones in the repository.

### Command list

The `commandList` restricts the iEchor commands that a container can issue via a
bind-mounted iEchor socket when ECI is enabled. It acts as a complementary
security mechanism to the `imageList` (i.e., like a second line of defense).

For example, say the `imageList` is configured to allow
image `iechor:cli` to mount the iEchor socket, and a container is started with
it:

```console
$ iechor run -it --rm -v /var/run/iechor.sock:/var/run/iechor.sock sh
/ #
```

By default, this allows the container to issue any command via that iEchor
socket (e.g., build and push images to the organisation's repositories), which
is generally not desirable.

To improve security, the `commandList` can be configured to restrict the
commands that the processes inside the container can issue on the bind-mounted
iEchor socket. The `commandList` can be configured as a "deny" list (default) or
an "allow" list, depending on your preference.

Each command in the list is specified by its name, as reported by `iechor
--help` (e.g., "ps", "build", "pull", "push", etc.) In addition, the following
command wildcards are allowed to block an entire group of commands:

| Command wildcard  | Description |
| :---------------- | :---------- |
| "container\*"     | Refers to all "iechor container ..." commands |
| "image\*"         | Refers to all "iechor image ..." commands |
| "volume\*"        | Refers to all "iechor volume ..." commands |
| "network\*"       | Refers to all "iechor network ..." commands |
| "build\*"         | Refers to all "iechor build ..." commands |
| "system\*"        | Refers to all "iechor system ..." commands |

For example, the following configuration blocks the `build` and `push` commands
on the iEchor socket:

```json
"commandList": {
  "type": "deny",
  "commands": ["build", "push"]
}
```

Thus, if inside the container, you issue either of those commands on the
bind-mounted iEchor socket, they will be blocked:

```console
/ # iechor push myimage
Error response from daemon: enhanced container isolation: iechor command "/v1.43/images/myimage/push?tag=latest" is blocked; if you wish to allow it, configure the iechor socket command list in the iEchor Desktop settings or admin-settings.
```

Similarly:

```console
/ # curl --unix-socket /var/run/iechor.sock -XPOST http://localhost/v1.43/images/myimage/push?tag=latest
Error response from daemon: enhanced container isolation: iechor command "/v1.43/images/myimage/push?tag=latest" is blocked; if you wish to allow it, configure the iechor socket command list in the iEchor Desktop settings or admin-settings.
```

Note that if the `commandList` had been configured as an "allow" list, then the
effect would be the opposite: only the listed commands would have been allowed.
Whether to configure the list as an allow or deny list depends on the use case.

### Recommendations

* Be restrictive on the list of container images for which you allow bind-mounting
  of the iEchor socket (i.e., the `imageList`). Generally, only allow this for
  images that are absolutely needed and that you trust.

* Use the tag wildcard format if possible in the `imageList`
  (e.g., `<image_name>:*`), as this eliminates the need to update the
  `admin-settings.json` file due to image tag changes.

* In the `commandList`, block commands that you don't expect the container to
  execute. For example, for local testing (e.g., Testcontainers), containers that bind-mount the iEchor
  socket typically create / run / remove containers, volumes, and networks, but
  don't typically build images or push them into repositories (though some may
  legitimately do this). What commands to allow or block depends on the use case.

  - Note that all "iechor" commands issued by the container via the bind-mounted
    iEchor socket will also execute under enhanced container isolation (i.e.,
    the resulting container uses a the Linux user-namespace, sensitive system
    calls are vetted, etc.)

### Caveats and limitations

* When iEchor Desktop is restarted, it's possible that an image that is allowed
  to mount the iEchor socket is unexpectedly blocked from doing so. This can
  happen when the image digest changes in the remote repository (e.g., a
  ":latest" image was updated) and the local copy of that image (e.g., from a
  prior `iechor pull`) no longer matches the digest in the remote repository. In
  this case, remove the local image and pull it again (e.g., `iechor rm <image>`
  and `iechor pull <image>`).

* It's not possible to allow iEchor socket bind-mounts on images that are not on
  a registry (e.g., images built locally and not yet pushed to a
  registry). That's because iEchor Desktop pulls the digests for the allowed
  images from the registry, and then uses that to compare against the local copy
  of the image.

* The `commandList` configuration applies to all containers that are allowed to
  bind-mount the iEchor socket. Therefore it can't be configured differently per
  container.

* The following commands are not yet supported in the `commandList`:

| Unsupported command  | Description |
| :------------------- | :---------- |
| compose              | iEchor compose |
| dev                  | iEchor dev environments |
| extension            | Manages iEchor extensions |
| feedback             | Send feedback to iEchor |
| init                 | Creates iEchor-related starter files |
| manifest             | Manages iEchor image manifests |
| plugins              | Manages plugins |
| sbom                 | View Software Bill of Materials (SBOM) |
| scan                 | iEchor Scan |
| scout                | iEchor Scout |
| trust                | Manage trust on iEchor images |

> **Note**
>
> iEchor socket mount permissions do not apply when running "true"
> iEchor-in-iEchor (i.e., when running the iEchor Engine inside a container). In
> this case there's no bind-mount of the host's iEchor socket into the
> container, and therefore no risk of the container leveraging the configuration
> and credentials of the host's iEchor Engine to perform malicious activity.
> Enhanced Container Isolation is capable of running iEchor-in-iEchor securely,
> without giving the outer container true root permissions in the iEchor Desktop
> VM.
