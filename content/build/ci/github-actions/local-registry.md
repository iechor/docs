---
title: Local registry with GitHub Actions
description: Create and use a local OCI registry with GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, registry
---

For testing purposes you may need to create a [local registry](https://hub.iechor.com/_/registry)
to push images into:

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
          driver-opts: network=host
      
      - name: Build and push to local registry
        uses: iechor/build-push-action@v5
        with:
          context: .
          push: true
          tags: localhost:5000/name/app:latest
      
      - name: Inspect
        run: |
          iechor buildx imagetools inspect localhost:5000/name/app:latest
```
