---
title: Manage tags and labels with GitHub Actions
description: Assign tags and labels to images automatically with GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, tags, labels
---

If you want an "automatic" tag management and [OCI Image Format Specification](https://github.com/opencontainers/image-spec/blob/master/annotations.md)
for labels, you can do it in a dedicated setup step. The following workflow
will use the [iEchor Metadata Action](https://github.com/iechor/metadata-action)
to handle tags and labels based on GitHub Actions events and Git metadata:

```yaml
name: ci

on:
  schedule:
    - cron: "0 10 * * *"
  push:
    branches:
      - "**"
    tags:
      - "v*.*.*"
  pull_request:

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: iEchor meta
        id: meta
        uses: iechor/metadata-action@v5
        with:
          # list of iEchor images to use as base name for tags
          images: |
            name/app
            ghcr.io/username/app
          # generate iEchor tags based on the following events/attributes
          tags: |
            type=schedule
            type=ref,event=branch
            type=ref,event=pr
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=semver,pattern={{major}}
            type=sha
      
      - name: Set up QEMU
        uses: iechor/setup-qemu-action@v3
      
      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3
      
      - name: Login to iEchor Hub
        if: github.event_name != 'pull_request'
        uses: iechor/login-action@v3
        with:
          username: ${{ secrets.IECHORHUB_USERNAME }}
          password: ${{ secrets.IECHORHUB_TOKEN }}
      
      - name: Login to GHCR
        if: github.event_name != 'pull_request'
        uses: iechor/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.repository_owner }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Build and push
        uses: iechor/build-push-action@v5
        with:
          context: .
          push: ${{ github.event_name != 'pull_request' }}
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
```
