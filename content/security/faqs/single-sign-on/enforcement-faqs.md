---
description: Single Sign-on enforcement FAQs
keywords: iEchor, iEchor Hub, SSO FAQs, single sign-on, enforce SSO, SSO enforcement
title: Enforcement
tags: [FAQ]
aliases:
- /single-sign-on/enforcement-faqs/
- /faq/security/single-sign-on/enforcement-faqs/
---

### We currently have a iEchor Team subscription. How do we enable SSO?

SSO is available with a iEchor Business subscription. To enable SSO, you must first upgrade your subscription to a iEchor Business subscription. To learn how to upgrade your existing account, see [Upgrade your subscription](../../../subscription/core-subscription/upgrade.md).

### How do service accounts work with SSO?

Service accounts work like any other user when SSO is turned on. If the service account is using an email for a domain with SSO turned on, it needs a PAT for CLI and API usage.

### Is DNS verification required to enable SSO?

Yes. You must verify a domain before using it with an SSO connection.

### Does iEchor SSO support authenticating through the command line?

Yes. When SSO is enforced, you can access the iEchor CLI through Personal Access Tokens (PATs).  Each user must create a PAT to access the CLI. To learn how to create a PAT, see [Manage access tokens](../../../security/for-developers/access-tokens.md).

### How does SSO affect our automation systems and CI/CD pipelines?

Before enforcing SSO, you must create PATs for automation systems and CI/CD pipelines and use the tokens instead of a password.

### I have a user working on projects within iEchor Desktop but authenticated with personal or no email. After they buy iEchor Business licenses, they will implement and enforce SSO through Okta to manage their users. When this user signs on SSO, is their work on DD compromised/impacted with the migration to the new account?

If they already have their organization email on their account, then it will be migrated to SSO.

### If an organization enables SSO, the owners can control iEchor IDs associated with their work email domain. Some of these iEchor IDs won't be users of iEchor Desktop and therefore don't require a Business subscription. Can the owners choose which iEchor IDs they add to their iEchor org and get access to Business features? Is there a way to flag which of these iEchor IDs are iEchor Desktop users?

SSO enforcement will apply to any domain email user, and automatically add that user to the iEchor Hub org that enables enforcement. The admin could remove users from the org manually, but those users wouldn't be able to authenticate if SSO is enforced.

### Can I enable SSO and hold off on the enforcement option?

Yes, you can choose to not enforce, and users have the option to use either iEchor ID (standard email/password) or email address (SSO) at the sign-in screen.

### SSO is enforced, but one of our users is connected to several organizations (and several email addresses) and is able to bypass SSO and sign in through username and password. Why is this happening?

Users can bypass SSO if the email they're using to sign in doesn't match the organization email that's used for SSO enforcement.

### Is there a way to test this functionality in a test tenant with Okta before going to production?

Yes, you can create a test organization. Companies can set up a new 5 seat Business plan on a new organization to test with (making sure to only enable SSO, not enforce it or all domain email users will be forced to sign in to that test tenant).

### Once we enable SSO for iEchor Desktop, what's the impact to the flow for Build systems that use service accounts?

If you enable SSO, there is no impact for now. We'll continue to support either username/password or personal access token sign-in.
However, if you enforce SSO:

* Service Account domain email addresses must be unaliased and enabled in their IdP
* Username/password and personal access token will still work (but only if they exist, which they won't for new accounts)
* Those who know the IdP credentials can sign in as that Service Account through SSO on Hub and create or change the personal access token for that service account.

### Is enforcing Single Sign-On the same as enforcing sign-in to iEchor Desktop?

No. They are different features that you can use separately or together.

Enforcing SSO ensures that users sign in using their SSO credentials instead of their iEchor ID. One of the benefits is that SSO enables you to better manage user credentials.

Enforcing sign-in to iEchor Desktop ensures that users always sign in to an
account that's a member of your organization. The benefits are that your organization's security settings are always applied to the user's session and your users always receive the benefits of your subscription. For more details, see [Enforce sign-in for Desktop](../../../security/for-admins/configure-sign-in.md).

