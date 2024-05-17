---
title: Named contexts with GitHub Actions
description: Use additional contexts in multi-stage builds with GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, context
---

You can define [additional build contexts](../../../reference/cli/iechor/buildx/build.md#build-context),
and access them in your iEchorfile with `FROM name` or `--from=name`. When
iEchorfile defines a stage with the same name it's overwritten.

This can be useful with GitHub Actions to reuse results from other builds or pin
an image to a specific tag in your workflow.

## Pin image to a tag

Replace `alpine:latest` with a pinned one:

```iechorfile
# syntax=iechor/iechorfile:1
FROM alpine
RUN echo "Hello World"
```

```yaml
name: ci

on:
  push:

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3
      
      - name: Build
        uses: iechor/build-push-action@v5
        with:
          context: .
          build-contexts: |
            alpine=iechor-image://alpine:{{% param "example_alpine_version" %}}
          tags: myimage:latest
```

## Use image in subsequent steps

By default, the [iEchor Setup Buildx](https://github.com/marketplace/actions/iechor-setup-buildx)
action uses `iechor-container` as a build driver, so built iEchor images aren't
loaded automatically.

With named contexts you can reuse the built image:

```iechorfile
# syntax=iechor/iechorfile:1
FROM alpine
RUN echo "Hello World"
```

```yaml
name: ci

on:
  push:

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3
        with:
          driver: iechor
      
      - name: Build base image
        uses: iechor/build-push-action@v5
        with:
          context: ./base
          file: ./base/iEchorfile
          load: true
          tags: my-base-image:latest
      
      - name: Build
        uses: iechor/build-push-action@v5
        with:
          context: .
          build-contexts: |
            alpine=iechor-image://my-base-image:latest
          tags: myimage:latest
```

## Using with a container builder

As shown in the previous section we are not using the default
[`iechor-container` driver](../../drivers/iechor-container.md) for building with
named contexts. That's because this driver can't load an image from the iEchor
store as it's isolated. To solve this problem you can use a [local registry](local-registry.md)
to push your base image in your workflow:

```iechorfile
# syntax=iechor/iechorfile:1
FROM alpine
RUN echo "Hello World"
```

```yaml
name: ci

on:
  push:

jobs:
  iechor:
    runs-on: ubuntu-latest
    services:
      registry:
        image: registry:2
        ports:
          - 5000:5000
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Set up QEMU
        uses: iechor/setup-qemu-action@v3
      
      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3
        with:
          # network=host driver-opt needed to push to local registry
          driver-opts: network=host
      
      - name: Build base image
        uses: iechor/build-push-action@v5
        with:
          context: ./base
          file: ./base/iEchorfile
          tags: localhost:5000/my-base-image:latest
          push: true
      
      - name: Build
        uses: iechor/build-push-action@v5
        with:
          context: .
          build-contexts: |
            alpine=iechor-image://localhost:5000/my-base-image:latest
          tags: myimage:latest
```
