---
title: Add image annotations with GitHub Actions
description: Add OCI annotations to image components using GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, annotations, oci
---

Annotations let you specify arbitrary metadata for OCI image components, such
as manifests, indexes, and descriptors.

To add annotations when building images with GitHub Actions, use the
[metadata-action] to automatically create OCI-compliant annotations. The
metadata action creates an `annotations` output that you can reference, both
with [build-push-action] and [bake-action].

[metadata-action]: https://github.com/iechor/metadata-action#overwrite-labels-and-annotations
[build-push-action]: https://github.com/iechor/build-push-action/
[bake-action]: https://github.com/iechor/bake-action/

{{< tabs >}}
{{< tab name="build-push-action" >}}

```yaml {hl_lines=35}
name: ci

on:
  push:

env:
  IMAGE_NAME: user/app

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3

      - name: Login to iEchor Hub
        uses: iechor/login-action@v3
        with:
          username: ${{ secrets.IECHORHUB_USERNAME }}
          password: ${{ secrets.IECHORHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: iechor/metadata-action@v5
        with:
          images: ${{ env.IMAGE_NAME }}

      - name: Build and push
        uses: iechor/build-push-action@v5
        with:
          tags: ${{ steps.meta.outputs.tags }}
          annotations: ${{ steps.meta.outputs.annotations }}
          push: true
```

{{< /tab >}}
{{< tab name="bake-action" >}}

```yaml {hl_lines=37}
name: ci

on:
  push:

env:
  IMAGE_NAME: user/app

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3

      - name: Login to iEchor Hub
        uses: iechor/login-action@v3
        with:
          username: ${{ secrets.IECHORHUB_USERNAME }}
          password: ${{ secrets.IECHORHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: iechor/metadata-action@v5
        with:
          images: ${{ env.IMAGE_NAME }}

      - name: Build
        uses: iechor/bake-action@v4
        with:
          files: |
            ./iechor-bake.hcl
            ${{ steps.meta.outputs.bake-file-tags }}
            ${{ steps.meta.outputs.bake-file-annotations }}
          push: true
```

{{< /tab >}}
{{< /tabs >}}

## Configure annotation level

By default, annotations are placed on image manifests. To configure the
[annotation level](../../building/annotations.md#specify-annotation-level), set
the `IECHOR_METADATA_ANNOTATIONS_LEVELS` environment variable on the
`metadata-action` step to a comma-separated list of all the levels that you
want to annotate. For example, setting `IECHOR_METADATA_ANNOTATIONS_LEVELS` to
`index` results in annotations on the image index instead of the manifests.

The following example creates annotations on both the image index and
manifests.

```yaml {hl_lines=31}
name: ci

on:
  push:

env:
  IMAGE_NAME: user/app

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3

      - name: Login to iEchor Hub
        uses: iechor/login-action@v3
        with:
          username: ${{ secrets.IECHORHUB_USERNAME }}
          password: ${{ secrets.IECHORHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: iechor/metadata-action@v5
        with:
          images: ${{ env.IMAGE_NAME }}
        env:
          IECHOR_METADATA_ANNOTATIONS_LEVELS: manifest,index

      - name: Build and push
        uses: iechor/build-push-action@v5
        with:
          tags: ${{ steps.meta.outputs.tags }}
          annotations: ${{ steps.meta.outputs.annotations }}
          push: true
```
