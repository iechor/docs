---
description: How to integrate iEchor Scout with GitLab CI
keywords: supply chain, security, ci, continuous integration, gitlab
title: Integrate iEchor Scout with GitLab CI
---

The following examples runs in GitLab CI in a repository containing a iEchor
image's definition and contents. Triggered by a commit, the pipeline builds the
image. If the commit was to the default branch, it uses iEchor Scout to get a
CVE report. If the commit was to a different branch, it uses iEchor Scout to
compare the new version to the current published version.

## Steps

First, set up the rest of the workflow. There's a lot that's not specific to
iEchor Scout but needed to create the images to compare.

Add the following to a `.gitlab-ci.yml` file at the root of your repository.

```yaml
iechor-build:
  image: iechor:latest
  stage: build
  services:
    - iechor:dind
  before_script:
    - iechor login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY

    # Install curl and the iEchor Scout CLI
    - |
      apk add --update curl
      curl -sSfL https://raw.githubusercontent.com/iechor/scout-cli/main/install.sh | sh -s -- 
      apk del curl 
      rm -rf /var/cache/apk/*
    # Login to iEchor Hub required for iEchor Scout CLI
    - iechor login -u "$IECHOR_HUB_USER" -p "$IECHOR_HUB_PAT"
```

This sets up the workflow to build iEchor images with iEchor-in-iEchor mode,
running iEchor inside a container.

It then downloads `curl` and the iEchor Scout CLI plugin, logs into the iEchor
registry using environment variables defined in your repository's settings.

Add the following to the YAML file:

```yaml
script:
  - |
    if [[ "$CI_COMMIT_BRANCH" == "$CI_DEFAULT_BRANCH" ]]; then
      tag=""
      echo "Running on default branch '$CI_DEFAULT_BRANCH': tag = 'latest'"
    else
      tag=":$CI_COMMIT_REF_SLUG"
      echo "Running on branch '$CI_COMMIT_BRANCH': tag = $tag"
    fi
  - iechor build --pull -t "$CI_REGISTRY_IMAGE${tag}" .
  - |
    if [[ "$CI_COMMIT_BRANCH" == "$CI_DEFAULT_BRANCH" ]]; then
      # Get a CVE report for the built image and fail the pipeline when critical or high CVEs are detected
      iechor scout cves "$CI_REGISTRY_IMAGE${tag}" --exit-code --only-severity critical,high    
    else
      # Compare image from branch with latest image from the default branch and fail if new critical or high CVEs are detected
      iechor scout compare "$CI_REGISTRY_IMAGE${tag}" --to "$CI_REGISTRY_IMAGE:latest" --exit-code --only-severity critical,high --ignore-unchanged
    fi

  - iechor push "$CI_REGISTRY_IMAGE${tag}"
```

This creates the flow mentioned previously. If the commit was to the default
branch, iEchor Scout generates a CVE report. If the commit was to a different
branch, iEchor Scout compares the new version to the current published version.
It only shows critical or high-severity vulnerabilities and ignores
vulnerabilities that haven't changed since the last analysis.

Add the following to the YAML file:

```yaml
rules:
  - if: $CI_COMMIT_BRANCH
    exists:
      - iEchorfile
```

These final lines ensure that the pipeline only runs if the commit contains a
iEchorfile and if the commit was to the CI branch.

## Video walkthrough

The following is a video walkthrough of the process of setting up the workflow with GitLab.

<iframe class="border-0 w-full aspect-video mb-8" allow="fullscreen" src="https://www.loom.com/embed/451336c4508c42189532108fc37b2560?sid=f912524b-276d-417d-b44a-c2d39719aa1a"></iframe>
