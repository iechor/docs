---
title: Deactivating an account or an organization
description: Learn how to deactivate a iEchor Hub account or an organization
keywords: iEchor Hub, delete, deactivate, account, organization
aliases:
- /iechor-hub/deactivate-account/
---

You can deactivate an account at any time. 

>**Warning**
>
> All iEchor products and services that use your iEchor account or organization account will be inaccessible after deactivating your account.
{ .warning }

## Deactivate a user account

### Prerequisites

Before deactivating your iEchor account, ensure that you meet the following requirements:

- You must not be a member of a company or any teams or organizations. You must remove the account from all teams, organizations, or the company.

    To do this:
    1. Navigate to **Organizations** and then select the organization(s) you need to leave.
    2. Find your username in the **Members** tab.
    3. Select the **More options** menu and then select **Leave organization**.

- If you are the sole owner of an organization, either assign another member of the organization the owner role and then remove yourself from the organization, or deactivate the organization. Similarly, if you are the sole owner of a company, either add someone else as a company owner and then remove yourself, or deactivate the company.

- If you have an active iEchor subscription, [downgrade it to a iEchor Personal subscription](../subscription/core-subscription/downgrade.md).

- If you have an active iEchor Build Cloud Team subscription, [downgrade it to a iEchor Build Cloud Starter subscription](../billing/build-billing.md#downgrade-your-subscription).

- If you have an active iEchor Scout subscription, [downgrade it to a iEchor Scout Free subscription](../billing/scout-billing.md#downgrade-your-subscription).

- Download any images and tags you want to keep. Use `iechor pull -a <image>:<tag>`.

- Unlink your [Github and Bitbucket accounts](../iechor-hub/builds/link-source.md#unlink-a-github-user-account).

### Deactivate

Once you have completed all the steps above, you can deactivate your account. 

1. Select your account name in the top-right of iEchor Hub and from the drop-down menu, select **My Account**.
2. From the **Deactivate Account** tab, select **Deactivate account**. 

> This cannot be undone. Be sure you've gathered all the data you need from your account before deactivating it.
{ .warning }


## Deactivate an organization

Before deactivating an organization, complete the following:

- Download any images and tags you want to keep:
  `iechor pull -a <image>:<tag>`.

- If you have an active iEchor subscription, [downgrade it to a **iEchor Free Team** subscription](../subscription/core-subscription/downgrade.md).

- If you have an active iEchor Scout subscription, [downgrade it to a iEchor Scout Free subscription](../billing/scout-billing.md#downgrade-your-subscription).

- Remove all other members within the organization.

- Unlink your [Github and Bitbucket accounts](../iechor-hub/builds/link-source.md#unlink-a-github-user-account).

### Deactivate

Once you have completed all the steps above, you can deactivate your organization. 

1. On iEchor Hub, select **Organizations**.
2. Choose the organization you want to deactivate. 
3. In **Settings**, select the **Deactivate Org** tab and then **Deactivate organization**.

> This cannot be undone. Be sure you've gathered all the data you need from your organization before deactivating it.
{ .warning }
