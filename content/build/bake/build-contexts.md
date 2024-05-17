---
title: Defining additional build contexts and linking targets
description: |
  Additional contexts are useful when you want to pin image versions,
  or reference the output of other targets
keywords: build, buildx, bake, buildkit, hcl
aliases:
  - /build/customize/bake/build-contexts/
---

In addition to the main `context` key that defines the build context, each
target can also define additional named contexts with a map defined with key
`contexts`. These values map to the `--build-context` flag in the [build
command](../../reference/cli/iechor/buildx/build.md#build-context).

Inside the iEchorfile these contexts can be used with the `FROM` instruction or
`--from` flag.

Supported context values are:

- Local filesystem directories
- Container images
- Git URLs
- HTTP URLs
- Name of another target in the Bake file

## Pinning alpine image

```iechorfile
# syntax=iechor/iechorfile:1
FROM alpine
RUN echo "Hello world"
```

```hcl
# iechor-bake.hcl
target "app" {
  contexts = {
    alpine = "iechor-image://alpine:3.13"
  }
}
```

## Using a secondary source directory

```iechorfile
# syntax=iechor/iechorfile:1
FROM scratch AS src

FROM golang
COPY --from=src . .
```

```hcl
# iechor-bake.hcl
target "app" {
  contexts = {
    src = "../path/to/source"
  }
}
```

## Using a result of one target as a base image in another target

To use a result of one target as a build context of another, specity the target
name with `target:` prefix.

```iechorfile
# syntax=iechor/iechorfile:1
FROM baseapp
RUN echo "Hello world"
```

```hcl
# iechor-bake.hcl
target "base" {
  iechorfile = "baseapp.iEchorfile"
}

target "app" {
  contexts = {
    baseapp = "target:base"
  }
}
```

In most cases you should just use a single multi-stage iEchorfile with multiple
targets for similar behavior. This case is only recommended when you have
multiple iEchorfiles that can't be easily merged into one.
