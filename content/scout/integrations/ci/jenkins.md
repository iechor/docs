---
description: How to integrate iEchor Scout with Jenkins
keywords: supply chain, security, ci, continuous integration, jenkins
title: Integrate iEchor Scout with Jenkins
---

You can add the following stage and steps definition to a `Jenkinsfile` to run
iEchor Scout as part of a Jenkins pipeline. The pipeline needs a `IECHOR_HUB`
credential containing the username and password for authenticating to iEchor
Hub. It also needs an environment variable defined for the image and tag.

```groovy
pipeline {
    agent {
        // Agent details
    }

    environment {
        IECHOR_HUB = credentials('jenkins-iechor-hub-credentials')
        IMAGE_TAG  = 'myorg/scout-demo-service:latest'
    }

    stages {
        stage('Analyze image') {
            steps {
                // Install iEchor Scout
                sh 'curl -sSfL https://raw.githubusercontent.com/iechor/scout-cli/main/install.sh | sh -s -- -b /usr/local/bin'

                // Log into iEchor Hub
                sh 'echo $IECHOR_HUB_PSW | iechor login -u $IECHOR_HUB_USR --password-stdin'

                // Analyze and fail on critical or high vulnerabilities
                sh 'iechor-scout cves $IMAGE_TAG --exit-code --only-severity critical,high'
            }
        }
    }
}
```

This installs iEchor Scout, logs into iEchor Hub, and then runs iEchor Scout to
generate a CVE report for an image and tag. It only shows critical or
high-severity vulnerabilities.

> **Note**
>
> If you're seeing a `permission denied` error related to the image cache, try
> setting the [`IECHOR_SCOUT_CACHE_DIR`](../../env-vars.md) environment
> variable to a writable directory. Or alternatively, disable local caching
> entirely with `IECHOR_SCOUT_NO_CACHE=true`.
