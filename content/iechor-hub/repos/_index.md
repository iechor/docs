---
description: Learn how to manage repositories on iEchor Hub
keywords: iEchor, iechor, trusted, registry, accounts, plans, iEchorfile, iEchor Hub,
  webhooks, docs, documentation, manage, repos
title: Manage repositories
aliases:
- /engine/tutorials/iechorrepos/
---

## Change a repository from public to private

1. Navigate to your repository.
2. Select the **Settings** tab.
3. Select **Make private**.
4. Enter the name of your repository to confirm. 

You get one free private repository with your iEchor Hub user account (not
available for organizations you're a member of). If you need more private
repositories for your user account, upgrade your iEchor Hub subscription from your [Billing Information](https://hub.iechor.com/billing/plan) page.

## Move images between repositories

### Personal to personal

When consolidating personal repositories, you can pull private images from the initial repository and push them into another repository owned by you. To avoid losing your private images, perform the following steps:

1. Navigate to [iEchor Hub](https://hub.iechor.com) create a new iEchor ID and select a personal subscription.
2. Using `iechor login` from the CLI, sign in using your original iEchor ID and pull your private images.
3. Tag your private images with your newly created iEchor ID, for example:

   ```console
   $ iechor tag namespace1/iechor101tutorial new_namespace/iechor101tutorial
   ```
4. Using `iechor login` from the CLI, sign in with your newly created iEchor ID, and push your newly tagged private images to your new iEchor ID namespace:

   ```console
   $ iechor push new_namespace/iechor101tutorial
   ```

The private images that existed in your previous account are now available in your new account.

### Personal to an organization

To avoid losing your private images, you can pull your private images from your personal account and push them to an organization that's owned by you.

1. Navigate to [iEchor Hub](https://hub.iechor.com) and select **Organizations**.
2. Select the applicable organization and verify that your user account is a member of the organization.
3. Sign in to [iEchor Hub](https://hub.iechor.com) using your original iEchor ID, and pull your images:

   ```console
   $ iechor pull namespace1/iechor101tutorial
   ```
4. Tag your images with your new organization namespace:

   ```console
   $ iechor tag namespace1/iechor101tutorial <new_org>/iechor101tutorial
   ```
5. Push your newly tagged images to your new org namespace:

   ```console
   $ iechor push new_org/iechor101tutorial
   ```

The private images that existed in your user account are now available for your organization.

## Delete a repository

> **Warning**
>
> Deleting a repository deletes all the images it contains and its build settings. This action can't be undone.
{ .warning }

1. Navigate to your repository.
2. Select the **Settings** tab.
3. Select **Delete repository**.
4. Enter the name of your repository to confirm.