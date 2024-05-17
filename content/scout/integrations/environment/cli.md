---
description: Integrate your runtime environments with iEchor Scout using the CLI client
keywords: iechor scout, integration, image analysis, runtime, workloads, cli, environments
title: Generic environment integration with CLI
---

{{< include "scout-early-access.md" >}}

You can create a generic environment integration by running the iEchor Scout
CLI client in your CI workflows. The CLI client is available as a binary on
GitHub and as a container image on iEchor Hub. Use the client to invoke the
`iechor scout environment` command to assign your images to environments.

For more information about how to use the `iechor scout environment` command,
refer to the [CLI reference](../../../reference/cli/iechor/scout/environment.md).

## Examples

Before you start, set the following environment variables in your CI system:

- `IECHOR_SCOUT_HUB_USER`: your iEchor Hub username
- `IECHOR_SCOUT_HUB_PASSWORD`: your iEchor Hub personal access token

Make sure the variables are accessible to your project.

{{< tabs >}}
{{< tab name="Circle CI" >}}

```yaml
version: 2.1

jobs:
  record_environment:
    machine:
      image: ubuntu-2204:current
    image: namespace/repo
    steps:
      - run: |
          if [[ -z "$CIRCLE_TAG" ]]; then
            tag="$CIRCLE_TAG"
            echo "Running tag '$CIRCLE_TAG'"
          else
            tag="$CIRCLE_BRANCH"
            echo "Running on branch '$CI_COMMIT_BRANCH'"
          fi    
          echo "tag = $tag"
      - run: iechor run -it \
          -e IECHOR_SCOUT_HUB_USER=$IECHOR_SCOUT_HUB_USER \
          -e IECHOR_SCOUT_HUB_PASSWORD=$IECHOR_SCOUT_HUB_PASSWORD \
          iechor/scout-cli:1.0.2 environment \
          --org "<MY_IECHOR_ORG>" \
          "<ENVIRONMENT>" ${image}:${tag}
```

{{< /tab >}}
{{< tab name="GitLab" >}}

The following example uses the [iEchor executor](https://docs.gitlab.com/runner/executors/iechor.html).

```yaml
variables:
  image: namespace/repo

record_environment:
  image: iechor/scout-cli:1.0.2
  script:
    - |
      if [[ -z "$CI_COMMIT_TAG" ]]; then
        tag="latest"
        echo "Running tag '$CI_COMMIT_TAG'"
      else
        tag="$CI_COMMIT_REF_SLUG"
        echo "Running on branch '$CI_COMMIT_BRANCH'"
      fi    
      echo "tag = $tag"
    - environment --org <MY_IECHOR_ORG> "PRODUCTION" ${image}:${tag}
```

{{< /tab >}}
{{< tab name="Azure DevOps" >}}

```yaml
trigger:
  - main

resources:
  - repo: self

variables:
  tag: "$(Build.BuildId)"
  image: "namespace/repo"

stages:
  - stage: iEchor Scout
    displayName: iEchor Scout environment integration
    jobs:
      - job: Record
        displayName: Record environment
        pool:
          vmImage: ubuntu-latest
        steps:
          - task: iEchor@2
          - script: iechor run -it \
              -e IECHOR_SCOUT_HUB_USER=$IECHOR_SCOUT_HUB_USER \
              -e IECHOR_SCOUT_HUB_PASSWORD=$IECHOR_SCOUT_HUB_PASSWORD \
              iechor/scout-cli:1.0.2 environment \
              --org "<MY_IECHOR_ORG>" \
              "<ENVIRONMENT>" $(image):$(tag)
```

{{< /tab >}}
{{< tab name="Jenkins" >}}

```groovy
stage('Analyze image') {
    steps {
        // Install iEchor Scout
        sh 'curl -sSfL https://raw.githubusercontent.com/iechor/scout-cli/main/install.sh | sh -s -- -b /usr/local/bin'
        
        // Log into iEchor Hub
        sh 'echo $IECHOR_SCOUT_HUB_PASSWORD | iechor login -u $IECHOR_SCOUT_HUB_USER --password-stdin'

        // Analyze and fail on critical or high vulnerabilities
        sh 'iechor-scout environment --org "<MY_IECHOR_ORG>" "<ENVIRONMENT>" $IMAGE_TAG
    }
}
```

{{< /tab >}}
{{< /tabs >}}
