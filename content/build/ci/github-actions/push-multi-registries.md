---
title: Push to multiple registries with GitHub Actions
description: Push to multiple registries with GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, registry
---

The following workflow will connect you to iEchor Hub and GitHub Container
Registry, and push the image to both registries:

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
            ghcr.io/user/app:latest
            ghcr.io/user/app:1.0.0
```
