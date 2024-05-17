---
description: Learn how to audit your domains for uncaptured users.
keywords: domain audit, security, identify users, manage users
title: Domain audit
aliases:
- /iechor-hub/domain-audit/
- /admin/company/settings/domains/
- /admin/organization/security-settings/domains/
---

Domain audit identifies uncaptured users in an organization. Uncaptured users are iEchor users who have authenticated to iEchor using an email address associated with one of your verified domains, but they're not a member of your organization in iEchor. You can audit domains on organizations that are part of the iEchor Business subscription. To upgrade your existing account to a iEchor Business subscription, see [Upgrade your subscription](/subscription/upgrade/).

Uncaptured users who access iEchor Desktop in your environment may pose a security risk because your organization's security settings, like Image Access Management and Registry Access Management, aren't applied to a user's session. In addition, you won't have visibility into the activity of uncaptured users. You can add uncaptured users to your organization to gain visibility into their activity and apply your organization's security settings.

Domain audit can't identify the following iEchor users in your environment:

- Users who access iEchor Desktop without authenticating
- Users who authenticate using an account that doesn't have an email address associated with one of your verified domains

Although domain audit can't identify all iEchor users in your environment, you can enforce sign-in to prevent unidentifiable users from accessing iEchor Desktop in your environment. For more details about enforcing sign-in, see [Configure registry.json to enforce sign-in](configure-sign-in.md).

## Prerequisites

Before you audit your domains, review the following required prerequisites:

- Your organization must be part of a iEchor Business subscription. To upgrade your existing account to a iEchor Business subscription, see [Upgrade your subscription](../../subscription/core-subscription/upgrade.md).
- You must [add and verify your domains](./single-sign-on/configure/_index.md#step-one-add-and-verify-your-domain).

> **Important**
>
> Domain audit is not supported for companies or organizations within a company.
{ .important }

## Audit your domains for uncaptured users

{{< tabs >}}
{{< tab name="iEchor Hub" >}}

{{% admin-domain-audit product="hub" %}}

{{< /tab >}}
{{< tab name="Admin Console" >}}

{{< include "admin-early-access.md" >}}

{{% admin-domain-audit product="admin" %}}

{{< /tab >}}
{{< /tabs >}}

