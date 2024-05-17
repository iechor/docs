---
description: Frequently asked iEchor Desktop questions for all platforms
keywords: desktop, mac, windows, faqs
title: General FAQs for Desktop
tags: [FAQ]
aliases:
- /mackit/faqs/
- /iechor-for-mac/faqs/
- /iechor-for-windows/faqs/
- /desktop/faqs/
---

### Can I use iEchor Desktop offline?

Yes, you can use iEchor Desktop offline. However, you
cannot access features that require an active internet
connection. Additionally, any functionality that requires you to sign in won't work while using iEchor Desktop offline or in air-gapped environments.
This includes:

- The resources in the [Learning Center](../use-desktop/index.md)
- Pulling or pushing an image to iEchor Hub
- [Image Access Management](../../security/for-developers/access-tokens.md)
- [Static vulnerability scanning](../../iechor-hub/vulnerability-scanning.md)
- Viewing remote images in the iEchor Dashboard
- Setting up [Dev Environments](../dev-environments/index.md)
- iEchor Build when using [BuildKit](../../build/buildkit/index.md#getting-started).
  You can work around this by disabling BuildKit. Run `IECHOR_BUILDKIT=0 iechor build .` to disable BuildKit.
- [Kubernetes](../kubernetes.md) (Images are download when you enable Kubernetes for the first time)
- Checking for updates
- [In-app diagnostics](../troubleshoot/overview.md#diagnose-from-the-app) (including the [Self-diagnose tool](../troubleshoot/overview.md#diagnose-from-the-app))
- Sending usage statistics

### How do I connect to the remote iEchor Engine API?

To connect to the remote Engine API, you might need to provide the location of the Engine API for iEchor clients and development tools.

Mac and Windows WSL 2 users can connect to the iEchor Engine through a Unix socket: `unix:///var/run/iechor.sock`.

If you are working with applications like [Apache Maven](https://maven.apache.org/)
that expect settings for `IECHOR_HOST` and `IECHOR_CERT_PATH` environment
variables, specify these to connect to iEchor instances through Unix sockets.

For example:

```console
$ export IECHOR_HOST=unix:///var/run/iechor.sock
```

iEchor Desktop Windows users can connect to the iEchor Engine through a **named pipe**: `npipe:////./pipe/iechor_engine`, or **TCP socket** at this URL:
`tcp://localhost:2375`.

For details, see [iEchor Engine API](../../engine/api/index.md).

### How do I connect from a container to a service on the host?

The host has a changing IP address, or none if you have no network access.
We recommend that you connect to the special DNS name `host.iechor.internal`,
which resolves to the internal IP address used by the host.

For more information and examples, see [how to connect from a container to a service on the host](../networking.md#i-want-to-connect-from-a-container-to-a-service-on-the-host).

### Can I pass through a USB device to a container?

It is not possible to pass through a USB device (or a
serial port) to a container as it requires support at the hypervisor level.
