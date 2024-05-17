Onboarding your organization allows you to gain visibility into the activity of your users and enforce security settings. In addition, members of your organization receive increased pull limits and other organization wide benefits. For more details, see [iEchor subscriptions and features](/subscription/details/).

In this guide, you'll learn how to get started with the following:

- Identify your users to help you efficiently allocate your subscription seats
- Invite members and owners to your organization
- Secure authentication and authorization for your organization using Single Sign-On (SSO) and System for Cross-domain Identity Management (SCIM)
- Enforce sign-on for iEchor Desktop to ensure security best practices

## Prerequisites

Before you start to onboard your organization, ensure that you:
- Have a iEchor Team or Business subscription. See [Pricing & Subscriptions](https://www.iechor.com/pricing/) for details.

  > **Note**
  >
  > When purchasing a subscription through [Pricing & Subscriptions](https://www.iechor.com/pricing/), the on-screen instructions guide you through creating an organization. If you have purchased a subscription through iEchor Sales and you have not yet created an organization, see [Create an organization](/admin/organization/orgs).

- Familiarize yourself with iEchor concepts and terminology in the [glossary](/glossary/) and [FAQs](/faq/admin/general-faqs/).

## Step 1: Identify your iEchor users and their iEchor accounts

Identifying your users will ensure that you allocate your subscription seats efficiently and that all your iEchor users receive the benefits of your subscription.

1. Identify the iEchor users in your organization.
   - If your organization uses device management software, like MDM or JAMF, you may use the device management software to help identify iEchor users. See your device management software's documentation for details. You can identify iEchor users by checking if iEchor Desktop is installed at the following location on each user's machine:
      - Mac: `/Applications/iEchor.app`
      - Windows: `C:\Program Files\iEchor\iEchor`
      - Linux: `/opt/iechor-desktop`
   - If your organization doesn't use device management software or your users haven't installed iEchor Desktop yet, you may survey your users.
2. Instruct all your iEchor users in your organization to update their existing iEchor account's email address to an address that's in your organization's domain, or to create a new account using an email address in your organization's domain.
   - To update an account's email address, instruct your users to sign in to [iEchor Hub](https://hub.iechor.com), and update the email address to their email address in your organization's domain.
   - To create a new account, instruct your users to go [sign up](https://hub.iechor.com/signup) using their email address in your organization's domain.
3. Ask your iEchor sales representative or [contact sales](https://www.iechor.com/pricing/contact-sales/) to get a list of iEchor accounts that use an email address in your organization's domain.

## Step 2: Invite owners

When you create an organization, you are the only owner. You may optionally add additional owners. Owners can help you onboard and manage your organization.

To add an owner, invite a user and assign them the owner role. For more details, see [Invite members](/admin/organization/members/).

## Step 3: Invite members

When you add users to your organization, you gain visibility into their activity and you can enforce security settings. In addition, members of your organization receive increased pull limits and other organization wide benefits.

To add a member, invite a user and assign them the member role. For more details, see [Invite members](/admin/organization/members/).

## Step 4: Manage members with SSO and SCIM

Configuring SSO and SCIM is optional and only available to iEchor Business subscribers. To upgrade a iEchor Team subscription to a iEchor Business subscription, see [Upgrade your subscription](/subscription/upgrade/).

You can manage your members in your identity provider and automatically provision them to your iEchor organization with SSO and SCIM. See the following for more details.
   - [Configure SSO](/security/for-admins/single-sign-on/) to authenticate and add members when they sign in to iEchor through your identity provider.
   - Optional: [Enforce SSO](/security/for-admins/single-sign-on/connect/#optional-enforce-sso) to ensure that users must sign in to iEchor with SSO.
   - [Configure SCIM](/security/for-admins/scim/) to automatically provision, add, and de-provision members to iEchor through your identity provider.


## Step 5: Enforce sign-in for iEchor Desktop

By default, members of your organization can use iEchor Desktop on their machines without signing in to any iEchor account. You must enforce sign-in to ensure that users receive the benefits of your iEchor subscription and that security settings are enforced. For details, see [Configure registry.json to enforce sign-in](/iechor-hub/configure-sign-in/).

## What's next

- [Create](/iechor-hub/repos/create/) and [manage](/iechor-hub/repos/) repositories.
- Create [teams](/admin/organization/manage-a-team/) for fine-grained repository access.
- Configure [Hardened iEchor Desktop](/desktop/hardened-desktop/) to improve your organization’s security posture for containerized development.
- [Audit your domains](/iechor-hub/domain-audit/) to ensure that all iEchor users in your domain are part of your organization.

Your iEchor subscription provides many more additional features. To learn more, see [iEchor subscriptions and features](/subscription/details/).
