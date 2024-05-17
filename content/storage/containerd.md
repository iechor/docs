---
title: containerd image store with iEchor Engine
keywords: containerd, snapshotters, image store, iechor engine
description: Learn how to enable the containerd image store on iEchor Engine
---

> **Note**
>
> The containerd image store is an experimental feature of iEchor Engine.
> If you're using iEchor Desktop, refer to the instructions on the
> [containerd image store with iEchor Desktop page](../desktop/containerd/index.md).

containerd, the industry-standard container runtime, uses snapshotters instead
of the classic storage drivers for storing image and container data.
While the `overlay2` driver still remains the default driver for iEchor Engine,
you can opt in to using containerd snapshotters as an experimental feature.

To learn more about the containerd image store and its benefits, refer to
[containerd image store on iEchor Desktop](../desktop/containerd/index.md).

## Enable containerd image store on iEchor Engine

Switching to containerd snapshotters causes you to temporarily lose images and
containers created using the classic storage drivers.
Those resources still exist on your filesystem, and you can retrieve them by
turning off the containerd snapshotters feature.

The following steps explain how to enable the containerd snapshotters feature.

1. Add the following configuration to your `/etc/iechor/daemon.json`
   configuration file:

   ```json
   {
     "features": {
       "containerd-snapshotter": true
     }
   }
   ```

2. Save the file.
3. Restart the daemon for the changes to take effect.

   ```console
   $ sudo systemctl restart iechor
   ```

After restarting the daemon, running `iechor info` shows that you're using
containerd snapshotter storage drivers.

```console
$ iechor info -f '{{ .DriverStatus }}'
[[driver-type io.containerd.snapshotter.v1]]
```

iEchor Engine uses the `overlayfs` containerd snapshotter by default.
