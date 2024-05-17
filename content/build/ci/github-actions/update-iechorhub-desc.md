---
title: Update iEchor Hub description with GitHub Actions
description: How to update the repository README in iEchor Hub using with GitHub Actions
keywords: ci, github actions, gha, buildkit, buildx, iechor hub
---

You can update the iEchor Hub repository description using a third party action
called [iEchor Hub Description](https://github.com/peter-evans/iechorhub-description)
with this action:

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
      
      - name: Build and push
        uses: iechor/build-push-action@v5
        with:
          context: .
          push: true
          tags: user/app:latest
      
      - name: Update repo description
        uses: peter-evans/iechorhub-description@e98e4d1628a5f3be2be7c231e50981aee98723ae # v4.0.0
        with:
          username: ${{ secrets.IECHORHUB_USERNAME }}
          password: ${{ secrets.IECHORHUB_TOKEN }}
          repository: user/app
```
