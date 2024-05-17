---
title: Export to iEchor with GitHub Actions
description: Load the build results to the image store with GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, iechor, export, load
---

You may want your build result to be available in the iEchor client through
`iechor images` to be able to use it in another step of your workflow:

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
          load: true
          tags: myimage:latest
      
      - name: Inspect
        run: |
          iechor image inspect myimage:latest
```
