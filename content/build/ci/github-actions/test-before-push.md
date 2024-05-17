---
title: Test before push with GitHub Actions
description: Here's how you can validate an image, before pushing it to a registry
keywords: ci, github actions, gha, buildkit, buildx, test
---

In some cases, you might want to validate that the image works as expected
before pushing it. The following workflow implements several steps to achieve
this:

1. Build and export the image to iEchor
2. Test your image
3. Multi-platform build and push the image

```yaml
name: ci

on:
  push:

env:
  TEST_TAG: user/app:test
  LATEST_TAG: user/app:latest

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Set up QEMU
        uses: iechor/setup-qemu-action@v3
      
      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3
      
      - name: Login to iEchor Hub
        uses: iechor/login-action@v3
        with:
          username: ${{ secrets.IECHORHUB_USERNAME }}
          password: ${{ secrets.IECHORHUB_TOKEN }}
      
      - name: Build and export to iEchor
        uses: iechor/build-push-action@v5
        with:
          context: .
          load: true
          tags: ${{ env.TEST_TAG }}
      
      - name: Test
        run: |
          iechor run --rm ${{ env.TEST_TAG }}
      
      - name: Build and push
        uses: iechor/build-push-action@v5
        with:
          context: .
          platforms: linux/amd64,linux/arm64
          push: true
          tags: ${{ env.LATEST_TAG }}
```

> **Note**
>
> The `linux/amd64` image is only built once in this workflow. The image is
> built once, and the following steps use the internal cache from the first
> `Build and push` step. The second `Build and push` step only builds
> `linux/arm64`.
