---
description: Learn how to enable two-factor authentication on iEchor Hub
keywords: iEchor, iechor, registry, security, iEchor Hub, authentication, two-factor
  authentication
title: Enable two-factor authentication for iEchor Hub
aliases:
- /iechor-hub/2fa/
---

Two-factor authentication adds an extra layer of security to your iEchor Hub
account by requiring a unique security code when you sign in to your account. The
security code is required in addition to your password.

When you enable two-factor authentication, you are also provided with a recovery
code. Each recovery code is unique and specific to your account. You can use
this code to recover your account in case you lose access to your authenticator
app. See [Recover your iEchor Hub account](recover-hub-account/).


## Prerequisites

You need a mobile phone with a time-based one-time password (TOTP) authenticator
application installed. Common examples include Google Authenticator or Yubico
Authenticator with a registered YubiKey.

## Enable two-factor authentication

1. Sign in to your iEchor Hub account. 
2. Select your avatar and then from the drop-down menu, select **My Account**. 
3. Select the **Security** tab and then select **Enable Two-Factor Authentication**.
4. Enter your account password, then select **Confirm**.
5. Save your recovery code and store it somewhere safe. You can use your recovery code to recover your account in the event you lose access to your authenticator app.
6. Use a TOTP mobile app to scan the QR code or enter the text code.
7. Once you've linked your authenticator app, enter the six-digit code in the text-field.
8. Select **Enable 2FA**.

Two-factor authentication is now enabled. The next time you sign
in to your iEchor Hub account, you are asked for a security code.