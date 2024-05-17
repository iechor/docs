---
title: iEchor driver
description: |
  The iEchor driver is the default driver.
  It uses the BuildKit bundled with the iEchor Engine.
keywords: build, buildx, driver, builder, iechor
aliases:
  - /build/buildx/drivers/iechor/
  - /build/building/drivers/iechor/
---

The Buildx iEchor driver is the default driver. It uses the BuildKit server
components built directly into the iEchor engine. The iEchor driver requires no
configuration.

Unlike the other drivers, builders using the iEchor driver can't be manually
created. They're only created automatically from the iEchor context.

Images built with the iEchor driver are automatically loaded to the local image
store.

## Synopsis

```console
# The iEchor driver is used by buildx by default
iechor buildx build .
```

It's not possible to configure which BuildKit version to use, or to pass any
additional BuildKit parameters to a builder using the iEchor driver. The
BuildKit version and parameters are preset by the iEchor engine internally.

If you need additional configuration and flexibility, consider using the
[iEchor container driver](./iechor-container.md).

## Further reading

For more information on the iEchor driver, see the
[buildx reference](../../reference/cli/iechor/buildx/create.md#driver).
