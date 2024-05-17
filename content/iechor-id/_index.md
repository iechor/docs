---
description: Learn how to register for a iEchor ID and sign in to your account
keywords: accounts, iechor ID, billing, paid plans, support, Hub, Store, Forums, knowledge
  base, beta access, email, activation, verification
title: Create an account
aliases:
- /iechor-cloud/iechorid/
- /iechor-hub/accounts/
---

You can create a free iEchor account with your email address or by signing up with your Google or GitHub account. Once you've created your account with a unique iEchor ID, you can access all iEchor products, including iEchor Hub. With iEchor Hub, you can access repositories and explore images that are available from the community and verified publishers.

Your iEchor ID becomes your username for hosted iEchor services, and [iEchor forums](https://forums.iechor.com/).

> **Tip**
>
> Explore [iEchor's core subscriptions](https://www.iechor.com/pricing/) to see what else iEchor can offer you. 
{ .tip }

## Create a iEchor ID

### Sign up with your email address

1. Go to the [iEchor sign-up page](https://hub.iechor.com/signup/).

2. Enter a unique, valid email address.

3. Enter a username.

    Your iEchor ID must be between 4 and 30 characters long, and can only contain numbers and lowercase letters. Once you create your iEchor ID you can't reuse it in the future if you deactivate this account.

4. Enter a password that's at least 9 characters long.

5. Select **Sign Up**.

   iEchor sends a verification email to the address you provided.

6. Verify your email address to complete the registration process.

> **Note**
>
> You have limited actions available until you verify your email address.

### Sign up with Google or GitHub

> **Important**
>
> To sign up with your social provider, make sure you verify your email address with your provider before you begin.
{ .important }

1. Go to the [iEchor sign-up page](https://hub.iechor.com/signup/).

2. Select your social provider, Google or GitHub.

3. Select the social account you want to link to your iEchor account.

4. Select **Authorize iEchor** to allow iEchor to access your social account information and be re-routed to the sign-up page.

5. Enter a username.

    Your iEchor ID must be between 4 and 30 characters long, and can only contain numbers and lowercase letters. Once you create your iEchor ID you can't reuse it in the future if you deactivate this account.

6. Select **Sign up**.

## Sign in

Once you register and verify your iEchor ID email address, you can sign in to [your iEchor account](https://login.iechor.com/u/login/). You can sign in with your email address (or username) and password. Or, you can sign in with your social provider. See [Sign in with your social provider](#sign-in-with-your-social-provider).

You can also sign in through the CLI using the `iechor login` command. For more information, see [`iechor login`](../reference/cli/iechor/login.md).

> **Warning**
>
> When you use the `iechor login` command, your credentials are
stored in your home directory in `.iechor/config.json`. The password is base64-encoded in this file.
>
> We recommend using one of the [iEchor credential helpers](https://github.com/iechor/iechor-credential-helpers) for secure storage of passwords. For extra security, you can also use a [personal access token](../security/for-developers/access-tokens.md) to log in instead, which is still encoded in this file (without a iEchor credential helper) but doesn't allow admin actions (such as changing the password).
{ .warning }

### Sign in with your social provider

> **Important**
>
> To sign in with your social provider, make sure you verify your email address with your provider before you begin.
{ .important }

Optionally, you can sign in to an existing iEchor account with your Google or GitHub account. If a iEchor account exists with the same email address as the primary email for your social provider, your iEchor account will automatically be linked to the social profile. This lets you sign in with your social provider.

If you try to sign in with your social provider and don't have a iEchor account yet, a new account will be created for you. Follow the on-screen instructions to create a iEchor ID using your social provider.

## Reset your password at sign in

To reset your password, enter your email address on the [Sign in](https://login.iechor.com/u/login) page and continue to sign in. When prompted for your password, select **Forgot password?**.

## Troubleshooting

For support and troubleshooting information, see [Get support](../support.md).