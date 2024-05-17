---
description: Learn how single sign-on works, how to set it up, and the required SSO attributes.
keywords: Single Sign-On, SSO, sign-on, admin, iechor hub, admin console, security
title: Single sign-on overview
aliases:
- /single-sign-on/
- /admin/company/settings/sso/
- /admin/organization/security-settings/sso-management/
---

Single sign-on (SSO) allows users to authenticate using their identity providers (IdPs) to access iEchor. SSO is available for a whole company, and all associated organizations, or an individual organization that has a iEchor Business subscription. To upgrade your existing account to a iEchor Business subscription, see [Upgrade your subscription](/subscription/upgrade/).

## How it works

When you enable SSO, your users can't authenticate using their iEchor login credentials (iEchor ID and password). iEchor supports Service Provider Initiated SSO flow. Instead, they are redirected to your IdP's authentication page to sign in. Your users must sign in to iEchor Hub or iEchor Desktop to initiate the SSO authentication process.

The following diagram shows how SSO operates and is managed in iEchor Hub and iEchor Desktop. In addition, it provides information on how to authenticate between your IdP.

![SSO architecture](images/SSO.png)

## How to set it up

1. Configure SSO by adding and verify your domain for your organization, then create an SSO connection with your IdP. iEchor provides the Assertion Consumer Service (ACS) URL and Entity ID needed to establish a connection between your IdP server and iEchor Hub.
2. Test your connection by attempting to sign in to iEchor Hub using your domain email address.
3. Optionally, you can enforce SSO sign-in.
4. Complete SSO enablement. A first-time user can sign in to iEchor Hub using their company's domain email address. They're then added to your company, assigned to an organization, and optionally assigned to a team.

## Prerequisites

* You must first notify your company about the new SSO login procedures.
* Verify that your members have iEchor Desktop version 4.4.2, or later, installed on their machines.
* If your organization uses the iEchor Hub CLI, we recommend that members [create a Personal Access Token (PAT)](/iechor-hub/access-tokens/) to sign in to the CLI instead of with a username and password. iEchor may deprecate signing in to the CLI with a username and password in the future, so using a PAT instead is a best practice to prevent potential issues with authentication.
In addition, you should add all email addresses to your IdP.
* Confirm that all CI/CD pipelines have replaced their passwords with PATs.
* For your service accounts, add your additional domains or enable it in your IdP.

## What's next?

- Start [configuring SSO](configure/_index.md) in iEchor
- Explore the [FAQs](../../../security/faqs/single-sign-on/faqs.md)
