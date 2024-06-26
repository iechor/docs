---
description: Troubleshooting volume errors
keywords: cadvisor, troubleshooting, volumes, bind-mounts
title: Troubleshoot storage errors
aliases:
- /engine/admin/troubleshooting_volume_errors/
tags: [ Troubleshooting ]
---

This topic discusses errors which may occur when you use iEchor volumes or bind
mounts.

## `Error: Unable to remove filesystem`

Some container-based utilities, such
as [Google cAdvisor](https://github.com/google/cadvisor), mount iEchor system
directories, such as `/var/lib/iechor/`, into a container.  For instance, the
documentation for `cadvisor` instructs you to run the `cadvisor` container as
follows:


```console
$ sudo iechor run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/iechor/:/var/lib/iechor:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  google/cadvisor:latest
```

When you bind-mount `/var/lib/iechor/`, this effectively mounts all resources of
all other running containers as filesystems within the container which mounts
`/var/lib/iechor/`. When you attempt to remove any of these containers, the
removal attempt may fail with an error like the following:

```none
Error: Unable to remove filesystem for
74bef250361c7817bee19349c93139621b272bc8f654ae112dd4eb9652af9515:
remove /var/lib/iechor/containers/74bef250361c7817bee19349c93139621b272bc8f654ae112dd4eb9652af9515/shm:
Device or resource busy
```

The problem occurs if the container which bind-mounts `/var/lib/iechor/`
uses `statfs` or `fstatfs` on filesystem handles within `/var/lib/iechor/`
and does not close them.

Typically, we would advise against bind-mounting `/var/lib/iechor` in this way.
However, `cAdvisor` requires this bind-mount for core functionality.

If you are unsure which process is causing the path mentioned in the error to
be busy and preventing it from being removed, you can use the `lsof` command
to find its process. For instance, for the error above:

```console
$ sudo lsof /var/lib/iechor/containers/74bef250361c7817bee19349c93139621b272bc8f654ae112dd4eb9652af9515/shm
```

To work around this problem, stop the container which bind-mounts
`/var/lib/iechor` and try again to remove the other container.
