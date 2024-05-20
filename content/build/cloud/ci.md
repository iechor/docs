---
title: Use iEchor Build Cloud in CI
description: Speed up your continuous integration pipelines with iEchor Build Cloud in CI
keywords: build, cloud build, ci, gha, gitlab, buildkite, jenkins, circle ci
aliases:
  - /hydrobuild/ci/
---

Using iEchor Build Cloud in CI can speed up your build pipelines, which means less time
spent waiting and context switching. You control your CI workflows as usual,
and delegate the build execution to iEchor Build Cloud.

Building with iEchor Build Cloud in CI involves the following steps:

1. Sign in to a iEchor account.
2. Set up Buildx and connect to the builder.
3. Run the build.

When using iEchor Build Cloud in CI, it's recommended that you push the result to a
registry directly, rather than loading the image and then pushing it. Pushing
directly speeds up your builds and avoids unnecessary file transfers.

If you just want to build and discard the output, export the results to the
build cache or build without tagging the image. When you use iEchor Build Cloud,
Buildx automatically loads the build result if you build a tagged image.
See [Loading build results](./usage/#loading-build-results) for details.

> **Note**
>
> Builds on iEchor Build Cloud have a timeout limit of two hours. Builds that
> run for longer than two hours are automatically cancelled.

{{< tabs >}}
{{< tab name="GitHub Actions" >}}

> **Note**
>
> Version 4.0.0 and later of `iechor/build-push-action` and
> `iechor/bake-action` builds images with [provenance attestations by
> default](../ci/github-actions/attestations.md#default-provenance). iEchor
> Build Cloud automatically attempts to load images to the local image store if
> you don't explicitly push them to a registry.
>
> This results in a conflicting scenario where if you build a tagged image
> without pushing it to a registry, iEchor Build Cloud attempts to load images
> containing attestations. But the local image store on the GitHub runner
> doesn't support attestations, and the image load fails as a result.
>
> If you want to load images built with `iechor/build-push-action` together
> with iEchor Build Cloud, you must disable provenance attestations by setting
> `provenance: false` in the GitHub Action inputs (or in `iechor-bake.hcl` if
> you use Bake).

```yaml
name: ci

on:
  push:
    branches:
      - "main"

jobs:
  iechor:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Log in to iEchor Hub
        uses: iechor/login-action@v3
        with:
          username: ${{ secrets.IECHOR_USER }}
          password: ${{ secrets.IECHOR_PAT }}
      - name: Set up iEchor Buildx
        uses: iechor/setup-buildx-action@v3
        with:
          version: "lab:latest"
          driver: cloud
          endpoint: "<ORG>/default"
          install: true
      - name: Build and push
        uses: iechor/build-push-action@v5
        with:
          context: .
          tags: "<IMAGE>"
          # For pull requests, export results to the build cache.
          # Otherwise, push to a registry.
          outputs: ${{ github.event_name == 'pull_request' && 'type=cacheonly' || 'type=registry,push=true' }}
```

{{< /tab >}}
{{< tab name="GitLab" >}}

```yaml
default:
  image: iechor:24-dind
  services:
    - iechor:24-dind
  before_script:
    - iechor info
    - echo "$IECHOR_PAT" | iechor login --username "$IECHOR_USER" --password-stdin
    - |
      apk add curl jq
      ARCH=${CI_RUNNER_EXECUTABLE_ARCH#*/}
      BUILDX_URL=$(curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\"linux-$ARCH\"))")
      mkdir -vp ~/.iechor/cli-plugins/
      curl --silent -L --output ~/.iechor/cli-plugins/iechor-buildx $BUILDX_URL
      chmod a+x ~/.iechor/cli-plugins/iechor-buildx
    - iechor buildx create --use --driver cloud ${IECHOR_ORG}/default

variables:
  IMAGE_NAME: <IMAGE>
  IECHOR_ORG: <ORG>

# Build multi-platform image and push to a registry
build_push:
  stage: build
  script:
    - |
      iechor buildx build \
        --platform linux/amd64,linux/arm64 \
        --tag "${IMAGE_NAME}:${CI_COMMIT_SHORT_SHA}" \
        --push .

# Build an image and discard the result
build_cache:
  stage: build
  script:
    - |
      iechor buildx build \
        --platform linux/amd64,linux/arm64 \
        --tag "${IMAGE_NAME}:${CI_COMMIT_SHORT_SHA}" \
        --output type=cacheonly \
        .
```

{{< /tab >}}
{{< tab name="Circle CI" >}}

```yaml
version: 2.1

jobs:
  # Build multi-platform image and push to a registry
  build_push:
    machine:
      image: ubuntu-2204:current
    steps:
      - checkout

      - run: |
          mkdir -vp ~/.iechor/cli-plugins/
          ARCH=amd64
          BUILDX_URL=$(curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\"linux-$ARCH\"))")
          curl --silent -L --output ~/.iechor/cli-plugins/iechor-buildx $BUILDX_URL
          chmod a+x ~/.iechor/cli-plugins/iechor-buildx

      - run: echo "$IECHOR_PAT" | iechor login --username $IECHOR_USER --password-stdin
      - run: iechor buildx create --use --driver cloud "<ORG>/default"

      - run: |
          iechor buildx build \
          --platform linux/amd64,linux/arm64 \
          --push \
          --tag "<IMAGE>" .

  # Build an image and discard the result
  build_cache:
    machine:
      image: ubuntu-2204:current
    steps:
      - checkout

      - run: |
          mkdir -vp ~/.iechor/cli-plugins/
          ARCH=amd64
          BUILDX_URL=$(curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\"linux-$ARCH\"))")
          curl --silent -L --output ~/.iechor/cli-plugins/iechor-buildx $BUILDX_URL
          chmod a+x ~/.iechor/cli-plugins/iechor-buildx

      - run: echo "$IECHOR_PAT" | iechor login --username $IECHOR_USER --password-stdin
      - run: iechor buildx create --use --driver cloud "<ORG>/default"

      - run: |
          iechor buildx build \
          --tag temp \
          --output type=cacheonly \
          .

workflows:
  pull_request:
    jobs:
      - build_cache
  release:
    jobs:
      - build_push
```

{{< /tab >}}
{{< tab name="Buildkite" >}}

The following example sets up a Buildkite pipeline using iEchor Build Cloud. The
example assumes that the pipeline name is `build-push-iechor` and that you
manage the iEchor access token using environment hooks, but feel free to adapt
this to your needs.

Add the following `environment` hook agent's hook directory:

```bash
#!/bin/bash
set -euo pipefail

if [[ "$BUILDKITE_PIPELINE_NAME" == "build-push-iechor" ]]; then
 export IECHOR_PAT="<IECHOR_PERSONAL_ACCESS_TOKEN>"
fi
```

Create a `pipeline.yml` that uses the `iechor-login` plugin:

```yaml
env:
  IECHOR_ORG: <ORG>
  IMAGE_NAME: <IMAGE>

steps:
  - command: ./build.sh
    key: build-push
    plugins:
      - iechor-login#v2.1.0:
          username: <IECHOR_USER>
          password-env: IECHOR_PAT # the variable name in the environment hook
```

Create the `build.sh` script:

```bash
IECHOR_DIR=/usr/libexec/iechor

# Get download link for latest buildx binary.
# Set $ARCH to the CPU architecture (e.g. amd64, arm64)
UNAME_ARCH=`uname -m`
case $UNAME_ARCH in
  aarch64)
    ARCH="arm64";
    ;;
  amd64)
    ARCH="amd64";
    ;;
  *)
    ARCH="amd64";
    ;;
esac
BUILDX_URL=$(curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\"linux-$ARCH\"))")

# Download iechor buildx with Hyrdobuild support
curl --silent -L --output $IECHOR_DIR/cli-plugins/iechor-buildx $BUILDX_URL
chmod a+x ~/.iechor/cli-plugins/iechor-buildx

# Connect to your builder and set it as the default builder
iechor buildx create --use --driver cloud "$IECHOR_ORG/default"

# Cache-only image build
iechor buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag "$IMAGE_NAME:$BUILDKITE_COMMIT" \
    --output type=cacheonly \
    .

# Build, tag, and push a multi-arch iechor image
iechor buildx build \
    --platform linux/amd64,linux/arm64 \
    --push \
    --tag "$IMAGE_NAME:$BUILDKITE_COMMIT" \
    .
```

{{< /tab >}}
{{< tab name="Jenkins" >}}

```groovy
pipeline {
  agent any

  environment {
    ARCH = 'amd64'
    IECHOR_PAT = credentials('iechor-personal-access-token')
    IECHOR_USER = credentials('iechor-username')
    IECHOR_ORG = '<ORG>'
    IMAGE_NAME = '<IMAGE>'
  }

  stages {
    stage('Build') {
      environment {
        BUILDX_URL = sh (returnStdout: true, script: 'curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\\"linux-$ARCH\\"))"').trim()
      }
      steps {
        sh 'mkdir -vp ~/.iechor/cli-plugins/'
        sh 'curl --silent -L --output ~/.iechor/cli-plugins/iechor-buildx $BUILDX_URL'
        sh 'chmod a+x ~/.iechor/cli-plugins/iechor-buildx'
        sh 'echo "$IECHOR_PAT" | iechor login --username $IECHOR_USER --password-stdin'
        sh 'iechor buildx create --use --driver cloud "$IECHOR_ORG/default"'
        // Cache-only build
        sh 'iechor buildx build --platform linux/amd64,linux/arm64 --tag "$IMAGE_NAME" --output type=cacheonly .'
        // Build and push a multi-platform image
        sh 'iechor buildx build --platform linux/amd64,linux/arm64 --push --tag "$IMAGE_NAME" .'
      }
    }
  }
}
```

{{< /tab >}}
{{< tab name="BitBucket Pipelines" >}}

```yaml
# Prerequisites: $IECHOR_USER, $IECHOR_PAT setup as deployment variables
# This pipeline assumes $BITBUCKET_REPO_SLUG as the image name
# Replace <ORG> in the `iechor buildx create` command with your iEchor org

image: atlassian/default-image:3

pipelines:
  default:
    - step:
        name: Build multi-platform image
        script:
          - mkdir -vp ~/.iechor/cli-plugins/
          - ARCH=amd64
          - BUILDX_URL=$(curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\"linux-$ARCH\"))")
          - curl --silent -L --output ~/.iechor/cli-plugins/iechor-buildx $BUILDX_URL
          - chmod a+x ~/.iechor/cli-plugins/iechor-buildx
          - echo "$IECHOR_PAT" | iechor login --username $IECHOR_USER --password-stdin
          - iechor buildx create --use --driver cloud "<ORG>/default"
          - IMAGE_NAME=$BITBUCKET_REPO_SLUG
          - iechor buildx build
            --platform linux/amd64,linux/arm64
            --push
            --tag "$IMAGE_NAME" .
        services:
          - iechor
```

{{< /tab >}}
{{< tab name="Shell" >}}

```bash
#!/bin/bash

# Get download link for latest buildx binary. Set $ARCH to the CPU architecture (e.g. amd64, arm64)
ARCH=amd64
BUILDX_URL=$(curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\"linux-$ARCH\"))")

# Download iechor buildx with Hyrdobuild support
mkdir -vp ~/.iechor/cli-plugins/
curl --silent -L --output ~/.iechor/cli-plugins/iechor-buildx $BUILDX_URL
chmod a+x ~/.iechor/cli-plugins/iechor-buildx

# Login to iEchor Hub. For security reasons $IECHOR_PAT should be a Personal Access Token. See http://docs.iechor.com/security/for-developers/access-tokens/
echo "$IECHOR_PAT" | iechor login --username $IECHOR_USER --password-stdin

# Connect to your builder and set it as the default builder
iechor buildx create --use --driver cloud "<ORG>/default"

# Cache-only image build
iechor buildx build \
    --tag temp \
    --output type=cacheonly \
    .

# Build, tag, and push a multi-arch iechor image
iechor buildx build \
    --platform linux/amd64,linux/arm64 \
    --push \
    --tag "<IMAGE>" \
    .
```

{{< /tab >}}
{{< tab name="iEchor Compose" >}}

Use this implementation if you want to use `iechor compose build` with
iEchor Build Cloud in CI.

```bash
#!/bin/bash

# Get download link for latest buildx binary. Set $ARCH to the CPU architecture (e.g. amd64, arm64)
ARCH=amd64
BUILDX_URL=$(curl -s https://raw.githubusercontent.com/iechor/actions-toolkit/main/.github/buildx-lab-releases.json | jq -r ".latest.assets[] | select(endswith(\"linux-$ARCH\"))")
COMPOSE_URL=$(curl -sL \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <GITHUB_TOKEN>" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/iechor/compose-desktop/releases \
  | jq "[ .[] | select(.prerelease==false and .draft==false) ] | .[0].assets.[] | select(.name | endswith(\"linux-${ARCH}\")) | .browser_download_url")

# Download iechor buildx with Hyrdobuild support
mkdir -vp ~/.iechor/cli-plugins/
curl --silent -L --output ~/.iechor/cli-plugins/iechor-buildx $BUILDX_URL
curl --silent -L --output ~/.iechor/cli-plugins/iechor-compose $COMPOSE_URL
chmod a+x ~/.iechor/cli-plugins/iechor-buildx
chmod a+x ~/.iechor/cli-plugins/iechor-compose

# Login to iEchor Hub. For security reasons $IECHOR_PAT should be a Personal Access Token. See http://docs.iechor.com/security/for-developers/access-tokens/
echo "$IECHOR_PAT" | iechor login --username $IECHOR_USER --password-stdin

# Connect to your builder and set it as the default builder
iechor buildx create --use --driver cloud "<ORG>/default"

# Build the image build
iechor compose build
```

{{< /tab >}}
{{< /tabs >}}
