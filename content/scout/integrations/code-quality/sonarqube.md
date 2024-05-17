---
title: Integrate iEchor Scout with SonarQube
description: Evaluate your images with the SonarQube quality gates defined in your projects
keywords: scout, supply chain, integration, code quality
---

The SonarQube integration enables iEchor Scout to surface SonarQube quality
gate checks through Policy Evaluation, under a new [Quality gates passed
policy](../../policy/_index.md#quality-gates-passed).

## How it works

This integration uses [SonarQube
webhooks](https://docs.sonarsource.com/sonarqube/latest/project-administration/webhooks/)
to notify iEchor Scout of when a SonarQube project analysis has completed. When
the webhook is called, iEchor Scout receives the analysis results, and stores
them in the database.

When you push a new image to a repository, iEchor Scout evaluates the results
of the SonarQube analysis record corresponding to the image. iEchor Scout uses
Git provenance metadata on the images, from  provenance attestations or an OCI
annotations, to link image repositories with SonarQube analysis results.

> **Note**
>
> iEchor Scout doesn't have access to historic SonarQube analysis records. Only
> analysis results recorded after the integration is enabled will be available
> to iEchor Scout.

## Prerequisites

To integrate iEchor Scout with SonarQube, ensure that:

- Your image repository is [integrated with iEchor Scout](../_index.md#container-registries).
- Your images are built with [provenance attestations](../../../build/attestations/slsa-provenance.md),
  or the `org.opencontainers.image.revision` annotation,
  containing information about the Git repository.

## Enable the SonarQube integration

1. Go to the [SonarQube integrations page](https://scout.iechor.com/settings/integrations/sonarqube/)
   on the iEchor Scout Dashboard.
2. In the **How to integrate** section, enter a configuration name for this
   integration. iEchor Scout uses this label as a display name for the
   integration, and to name the webhook.
3. Select **Next**.
4. Enter the configuration details for your SonarQube instance. iEchor Scout
   uses this information to create SonarQube webhook.

   In SonarQube, [generate a new **User token**](https://docs.sonarsource.com/sonarqube/latest/user-guide/user-account/generating-and-using-tokens/#generating-a-token).
   The token requires 'Administer' permission on the specified project, or
   global 'Administer' permission.

   Enter the token, your SonarQube URL, and the ID of your SonarQube
   organization. The SonarQube organization is required if you're using
   SonarCloud.

5. Select **Enable configuration**.

   iEchor Scout performs a connection test to verify that the provided details
   are correct, and that the token has the necessary permissions.

6. After a successful connection test, you're redirected to the SonarQube
   integration overview, which lists all your SonarQube integrations and their
   statuses.

From the integration overview page, you can go directly to the Quality gates
passed policy. This policy will have no results initially. To start seeing
evaluation results for this policy, trigger a new SonarQube analysis of your
project and push the corresponding image to a repository. For more information,
refer to the [Quality gates passed policy](../../policy/_index.md#quality-gates-passed).
