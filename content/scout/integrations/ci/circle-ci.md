---
description: How to integrate iEchor Scout with Circle CI
keywords: supply chain, security, ci, continuous integration, circle ci
title: Integrate iEchor Scout with Circle CI
---

The following examples runs when triggered in CircleCI. When triggered, it
checks out the "iechor/scout-demo-service:latest" image and tag and then uses
iEchor Scout to create a CVE report.

Add the following to a _.circleci/config.yml_ file.

First, set up the rest of the workflow. Add the following to the YAML file:

```yaml
version: 2.1

jobs:
  build:
    iechor:
      - image: cimg/base:stable
    environment:
      IMAGE_TAG: iechor/scout-demo-service:latest
```

This defines the container image the workflow uses and an environment variable
for the image.

Add the following to the YAML file to define the steps for the workflow:

```yaml
steps:
  # Checkout the repository files
  - checkout
  
  # Set up a separate iEchor environment to run `iechor` commands in
  - setup_remote_iechor:
      version: 20.10.24

  # Install iEchor Scout and login to iEchor Hub
  - run:
      name: Install iEchor Scout
      command: |
        env
        curl -sSfL https://raw.githubusercontent.com/iechor/scout-cli/main/install.sh | sh -s -- -b /home/circleci/bin
        echo $IECHOR_HUB_PAT | iechor login -u $IECHOR_HUB_USER --password-stdin

  # Build the iEchor image
  - run:
      name: Build iEchor image
      command: iechor build -t $IMAGE_TAG .
  
  # Run iEchor Scout          
  - run:
      name: Scan image for CVEs
      command: |
        iechor-scout cves $IMAGE_TAG --exit-code --only-severity critical,high
```

This checks out the repository files and then sets up a separate iEchor
environment to run commands in.

It installs iEchor Scout, logs into iEchor Hub, builds the iEchor image, and
then runs iEchor Scout to generate a CVE report. It only shows critical or
high-severity vulnerabilities.

Finally, add a name for the workflow and the workflow's jobs:

```yaml
workflows:
  build-iechor-image:
    jobs:
      - build
```
