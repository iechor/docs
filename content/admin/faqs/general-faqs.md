---
title: General FAQs for iEchor accounts
description: Frequently asked iEchor account and administration questions
keywords: onboarding, iechor, teams, orgs, user accounts, organization accounts
tags: [FAQ]
aliases:
- /iechor-hub/general-faqs/
- /iechor-hub/onboarding-faqs/
- /faq/admin/general-faqs/
---

### What is a iEchor ID?

A iEchor ID is a username for your iEchor account that lets you access iEchor products. All you need is an email address to create a iEchor ID, or you can sign up with your Google or GitHub account. Your iEchor ID must be between 4 and 30 characters long, and can only contain
numbers and lowercase letters. You can't use any special characters or spaces.

For more information, see [iEchor ID](../../iechor-id/index.md). If your administrator enforces [Single sign-on (SSO)](../../security/for-admins/single-sign-on/index.md), this provisions a iEchor ID for new users.

Developers may have multiple iEchor IDs in order to separate their iEchor IDs associated with an organization with a iEchor Business or Team subscription, and their personal use iEchor IDs.

### What if my iEchor ID is taken?

All iEchor IDs are first-come, first-served except for companies that have a US Trademark on a username. If you have a trademark for your namespace, [iEchor Support](https://hub.iechor.com/support/contact/) can retrieve the iEchor ID for you.

### What’s an organization?

An organization in iEchor is a collection of teams and repositories that are managed together. iEchor users become members of an organization once they're associated with that organization by an organization owner. An [organization owner](#who-is-an-organization-owner) is a user with administrative access to the organization. For more information on creating organizations, see [Create your organization](orgs.md).

### What's an organization name or namespace?

The organization name, sometimes referred to as the organization namespace or the org ID, is the unique identifier of a iEchor organization. The organization name can't be the same as an existing iEchor ID.

### What are roles?

A role is a collection of permissions granted to members. Roles define access to perform actions in iEchor Hub like creating repositories, managing tags, or viewing teams. See [Roles and permissions](roles-and-permissions.md).

### What’s a team?

A team is a group of iEchor users that belong to an organization. An organization can have multiple teams. An organization owner can then create new teams and add members to an existing team using iEchor IDs or email address and by selecting a team the user should be part of. See [Create and manage a team](manage-a-team.md).

### What's a company?

A company is a management layer that centralizes administration of multiple organizations. Administrators can add organizations with a iEchor Business subscription to a company and configure settings for all organizations under the company. See [Set up your company](/admin/company/).

### Who is an organization owner?

An organization owner is an administrator who has permissions to manage
repositories, add members, and manage member roles. They have full access to
private repositories, all teams, billing information, and organization settings.
An organization owner can also specify [repository permissions](manage-a-team.md#configure-repository-permissions-for-a-team) for each team in the
organization. Only an organization owner can enable SSO for the organization.
When SSO is enabled for your organization, the organization owner can also
manage users.

iEchor can auto-provision iEchor IDs for new end-users or users who'd like to
have a separate iEchor ID for company use through SSO enforcement.

The organization owner can also add additional owners to help them manage users, teams, and repositories in the organization.

### Can I configure multiple SSO identity providers (IdPs) to authenticate users to a single org?

iEchor SSO allows only one IdP configuration per organization. For more
information, see [Configure SSO](../../security/for-admins/single-sign-on/configure/_index.md) and [SSO FAQs](../../security/faqs/single-sign-on/faqs.md).

### What is a service account?

A [service account](../../iechor-hub/service-accounts.md) is a iEchor ID used for automated management of container images or containerized applications. Service accounts are typically used in automated workflows, and don't share iEchor IDs with the members in the Team or Business plan. Common use cases for service accounts include mirroring content on iEchor Hub, or tying in image pulls from your CI/CD process.

### Can I delete or deactivate a iEchor account for another user?

Only someone with access to the iEchor account can deactivate the account. For more details, see [Deactivating an account](../../admin/deactivate-account.md).

If the user is a member of your organization, you can remove the user from your organization. For more details, see [Remove a member or invitee](../../admin/organization/members.md#remove-a-member-from-a-team).
