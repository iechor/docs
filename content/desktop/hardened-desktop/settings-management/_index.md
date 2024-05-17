---
description: Understand how Settings Management works, who it is for, and what the
  benefits are
keywords: Settings Management, rootless, iechor desktop, hardened desktop
title: What is Settings Management?
---

>**Note**
>
>Settings Management is available to iEchor Business customers only.

Settings Management is a feature that helps admins to control certain iEchor Desktop settings on client machines within their organization.

With a few lines of JSON, admins can configure controls for iEchor Desktop settings such as proxies and network settings. For an extra layer of security, admins can also use Settings Management to enable and lock in [Enhanced Container Isolation](../enhanced-container-isolation/index.md) which ensures that any configurations set with Settings Management cannot be modified by containers.

It is available with [iEchor Desktop 4.13.0 and later](../../release-notes.md).

### Who is it for?

- For organizations that want to configure iEchor Desktop to be within their organization's centralized control.
- For organizations that want to create a standardized iEchor Desktop environment at scale.
- For iEchor Business customers who want to confidently manage their use of iEchor Desktop within tightly regulated environments.

### How does it work?

Administrators can configure several iEchor Desktop settings using an `admin-settings.json` file. This file is located on the iEchor Desktop host and can only be accessed by developers with root or admin privileges.

Values that are set to `locked: true` within the `admin-settings.json` override any previous values set by developers and ensure that these cannot be modified. For more information, see [Configure Settings Management](../settings-management/configure.md#step-two-configure-the-settings-you-want-to-lock-in).

### What features can I configure with Settings Management?

Using the `admin-settings.json` file, admins can:

- Turn on and lock in [Enhanced Container Isolation](../enhanced-container-isolation/index.md)
- Configure HTTP proxies
- Configure network settings
- Configure Kubernetes settings
- Enforce the use of WSL 2 based engine or Hyper-V
- Enforce the use of Rosetta for x86_64/amd64 emulation on Apple Silicon
- Configure iEchor Engine
- Turn off iEchor Desktop's ability to checks for updates
- Turn off iEchor Extensions
- Turn off iEchor Scout SBOM indexing
- Turn off beta and experimental features
- Turn off iEchor Desktop's onboarding survey
- Control the file sharing implementation for your developers on macOS
- Specify which paths your developers can add file shares to
- Configure air-gapped containers (Beta)

For more details on the syntax and options admins can set, see [Configure Settings Management](configure.md).

### How do I set up and enforce Settings Management?

As an administrator, you first need to [configure a registry.json to enforce sign-in](../../../security/for-admins/configure-sign-in.md). This is because the Settings Management feature requires a iEchor Business subscription and therefore your iEchor Desktop developers must authenticate to your organization for this configuration to take effect.

Next, you must either manually [create and configure the admin-settings.json file](configure.md), or use the `--admin-settings` installer flag on [macOS](../../install/mac-install.md#install-from-the-command-line) or [Windows](../../install/windows-install.md#install-from-the-command-line) to automatically create the `admin-settings.json` and save it in the correct location.

Once this is done, iEchor Desktop developers receive the changed settings when they either:
- Quit, re-launch, and sign in to iEchor Desktop
- Launch and sign in to iEchor Desktop for the first time

iEchor doesn't automatically mandate that developers re-launch and re-authenticate once a change has been made, so as not to disrupt your developers' workflow.

### What do developers see when the settings are enforced?

Any settings that are enforced, are grayed out in iEchor Desktop and the user is unable to edit them, either via the iEchor Desktop UI, CLI, or the `settings.json` file. In addition, if Enhanced Container Isolation is enforced, developers can't use privileged containers or similar techniques to modify enforced settings within the iEchor Desktop Linux VM, for example, reconfigure proxy and networking of reconfigure iEchor Engine.

![Proxy settings grayed out](/assets/images/grayed-setting.png)

## More resources

- [Video: Settings Managmeent](https://www.youtube.com/watch?v=I9oJOJ1P9PQ)
