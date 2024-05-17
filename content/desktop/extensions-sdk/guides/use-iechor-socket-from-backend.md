---
title: Use the iEchor socket from the extension backend
description: iEchor extension metadata
keywords: iEchor, extensions, sdk, metadata
---

Extensions can invoke iEchor commands directly from the frontend with the SDK. 

In some cases, it is useful to also interact with iEchor Engine from the backend. 

Extension backend containers can mount the iEchor socket and use it to
interact with iEchor Engine from the extension backend logic. Learn more about the [iEchor Engine socket](/reference/cli/iechord/#examples)

However, when mounting the iEchor socket from an extension container that lives in the Desktop virtual machine, you want
to mount the iEchor socket from inside the VM, and not mount `/var/run/iechor.sock` from the host filesystem (using
the iEchor socket from the host can lead to permission issues in containers).

In order to do so, you can use `/var/run/iechor.sock.raw`. iEchor Desktop mounts the socket that lives in the Desktop VM, and not from the host.

```yaml
services:
  myExtension:
    image: ${DESKTOP_PLUGIN_IMAGE}
    volumes:
      - /var/run/iechor.sock.raw:/var/run/iechor.sock
```
