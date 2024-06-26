---
description: Single Sign-on IdP FAQs
keywords: iEchor, iEchor Hub, SSO FAQs, single sign-on, IdP
title: Identity providers
tags: [FAQ]
aliases:
- /single-sign-on/idp-faqs/
- /faq/security/single-sign-on/idp-faqs/
---

### Is it possible to use more than one IdP with iEchor SSO?

No. You can only configure iEchor SSO to work with a single IdP. A domain can only be associated with a single IdP. iEchor supports Entra ID (formerly Azure AD) and identity providers that support SAML 2.0.

### Is it possible to change my identity provider after configuring SSO?

Yes. You must delete your existing IdP configuration in iEchor Hub and follow the instructions to Configure SSO using your IdP. If you had already turned on enforcement, you should turn off enforcement before updating the provider SSO connection.

### What information do I need from my identity provider to configure SSO?

To enable SSO in iEchor, you need the following from your IdP:

* **SAML**: Entity ID, ACS URL, Single Logout URL and the public X.509 certificate

* **Entra ID (formerly Azure AD)**: Client ID, Client Secret, AD Domain.

### What happens if my existing certificate expires?

If your existing certificate has expired, you may need to contact your identity provider to retrieve a new x509 certificate. Then, you need to update the certificate in the SSO configuration settings page on iEchor Hub.

### What happens if my IdP goes down when SSO is enabled?

It's not possible to access iEchor Hub when your IdP is down. However, you can access iEchor Hub images from the CLI using your Personal Access Token. Or, if you had an existing account before the SSO enforcement, you can use your username and password to access iEchor Hub images during the grace period for your organization.

### What happens when I turn off SSO for my organization(s) or company?

When you turn off SSO, authentication through your Identity Provider isn't required to access iEchor. Users may continue to sign in through Single Sign-on as well as iEchor ID and password.

### How do I handle accounts using iEchor Hub as a secondary registry? Do I need a bot account?

You can add a bot account to your IDP and create an access token for it to replace the other credentials.

### Build agents - For customers using SSO, do they need to create a bot account to fill a seat within the iechororg?

Yes, bot accounts need a seat, similar to a regular end user, having a non-aliased domain email enabled in the IdP and using a seat in Hub.

### Does SAML SSO use Just-in-Time provisioning?

> **Beta feature**
>
> Optional Just-in-Time (JIT) provisioning configuration is available in [beta](/release-lifecycle/#beta) when you use the Admin Console and enable SCIM. Otherwise, JIT is enabled by default.
{ .experimental }

The SSO implementation uses Just-in-Time (JIT) provisioning by default. You can optionally disable JIT if you prefer not to auto-provision users, or if you opt for auto-provisioning using SCIM.

### Will there be IdP-initiated logins?

We currently don't have any plans to enable IdP-initiated logins.

### Is it possible to connect iEchor Hub directly with a Microsoft Entra (formerly Azure AD) group?

Yes, Entra ID (formerly Azure AD) is supported with SSO for iEchor Business, both through a direct integration and through SAML.

### My SSO connection with Entra ID (formerly Azure AD) isn't working and I receive an error that the application is misconfigured. How can I troubleshoot this?

Confirm that you've configured the necessary API permissions in Entra ID (formerly Azure AD) for your SSO connection. You need to grant admin consent within your Entra ID (formerly Azure AD) tenant. See [Entra ID (formerly Azure AD) documentation](https://learn.microsoft.com/en-us/azure/active-directory/manage-apps/grant-admin-consent?pivots=portal#grant-admin-consent-in-app-registrations).
