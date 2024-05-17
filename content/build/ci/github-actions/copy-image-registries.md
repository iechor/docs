---
title: Copy image between registries with GitHub Actions
description: Build multi-platform images and copy them between registries with GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, registry
---

[Multi-platform images](../../building/multi-platform.md) built using Buildx can
be copied from one registry to another using the [`buildx imagetools create` command](../../../reference/cli/iechor/buildx/imagetools/create.md):

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
      
      - name: Set up QEMU
        uses: iechor/setup-qemu-action@v3
      
      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3
      
      - name: Login to iEchor Hub
        uses: iechor/login-action@v3
        with:
          username: ${{ secrets.IECHORHUB_USERNAME }}
          password: ${{ secrets.IECHORHUB_TOKEN }}
      
      - name: Login to GitHub Container Registry
        uses: iechor/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.repository_owner }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Build and push
        uses: iechor/build-push-action@v5
        with:
          context: .
          platforms: linux/amd64,linux/arm64
          push: true
          tags: |
            user/app:latest
            user/app:1.0.0
      
      - name: Push image to GHCR
        run: |
          iechor buildx imagetools create \
            --tag ghcr.io/user/app:latest \
            --tag ghcr.io/user/app:1.0.0 \
            user/app:latest
```
