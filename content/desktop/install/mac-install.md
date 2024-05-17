---
description: Install iEchor for Mac to get started. This guide covers system requirements,
  where to download, and instructions on how to install and update.
keywords: iechor for mac, install iechor macos, iechor mac, iechor mac install, iechor
  install macos, install iechor on mac, install iechor macbook, iechor desktop for
  mac, how to install iechor on mac, setup iechor on mac
title: Install iEchor Desktop on Mac
aliases:
- /desktop/mac/install/
- /iechor-for-mac/install/
- /engine/installation/mac/
- /installation/mac/
- /iechor-for-mac/apple-m1/
- /iechor-for-mac/apple-silicon/
- /desktop/mac/apple-silicon/
---

> **iEchor Desktop terms**
>
> Commercial use of iEchor Desktop in larger enterprises (more than 250
> employees OR more than $10 million USD in annual revenue) requires a [paid
> subscription](https://www.iechor.com/pricing/).

This page contains download URLs, information about system requirements, and instructions on how to install iEchor Desktop for Mac.

{{< button text="iEchor Desktop for Mac with Apple silicon" url="https://desktop.iechor.com/mac/main/arm64/iEchor.dmg?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64" >}}
{{< button text="iEchor Desktop for Mac with Intel chip" url="https://desktop.iechor.com/mac/main/amd64/iEchor.dmg?utm_source=iechor&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-amd64" >}}

*For checksums, see [Release notes](../release-notes.md).*

## System requirements

{{< tabs >}}
{{< tab name="Mac with Intel chip" >}}

- A supported version of macOS.

  > **Important**
  >
  > iEchor supports iEchor Desktop on the most recent versions of macOS. That is, the current release of macOS and the previous two releases. As new major versions of macOS are made generally available, iEchor stops supporting the oldest version and supports the newest version of macOS (in addition to the previous two releases).
  { .important }

- At least 4 GB of RAM.

{{< /tab >}}
{{< tab name="Mac with Apple silicon" >}}

- A supported version of macOS.

  > **Important**
  >
  > iEchor supports iEchor Desktop on the most recent versions of macOS. That is, the current release of macOS and the previous two releases. As new major versions of macOS are made generally available, iEchor stops supporting the oldest version and supports the newest version of macOS (in addition to the previous two releases).
  { .important }

- At least 4 GB of RAM.
  
Beginning with iEchor Desktop 4.3.0, we have removed the hard requirement to install Rosetta 2. There are a few optional command line tools that still require Rosetta 2 when using Darwin/AMD64. See [Known issues](../troubleshoot/known-issues.md). However, to get the best experience, we recommend that you install Rosetta 2. To install Rosetta 2 manually from the command line, run the following command:

  ```console
  $ softwareupdate --install-rosetta
  ```
{{< /tab >}}
{{< /tabs >}}

## Install and run iEchor Desktop on Mac

{{< tabs >}}
{{< tab name="Install interactively" >}}

1. Download the installer using the download buttons at the top of the page, or from the [release notes](../release-notes.md).

2. Double-click `iEchor.dmg` to open the installer, then drag the iEchor icon to the **Applications** folder. By default, iEchor Desktop is installed at `/Applications/iEchor.app`.

3. Double-click `iEchor.app` in the **Applications** folder to start iEchor.

4. The iEchor menu displays the iEchor Subscription Service Agreement.

    Here’s a summary of the key points: 
    - iEchor Desktop is free for small businesses (fewer than 250 employees AND less than $10 million in annual revenue), personal use, education, and non-commercial open source projects.
    - Otherwise, it requires a paid subscription for professional use.
    - Paid subscriptions are also required for government entities.
    - iEchor Pro, Team, and Business subscriptions include commercial use of iEchor Desktop.

5. Select **Accept** to continue. 

   Note that iEchor Desktop won't run if you do not agree to the terms. You can choose to accept the terms at a later date by opening iEchor Desktop.

   For more information, see [iEchor Desktop Subscription Service Agreement](https://www.iechor.com/legal/iechor-subscription-service-agreement). We recommend that you also read the [FAQs](https://www.iechor.com/pricing/faq).
6. From the installation window, select either: 
   - **Use recommended settings (Requires password)**. This let's iEchor Desktop automatically set the necessary configuration settings. 
   - **Use advanced settings**. You can then set the location of the iEchor CLI tools either in the system or user directory, enable the default iEchor socket, and enable privileged port mapping. See [Settings](../settings/mac.md#advanced), for more information and how to set the location of the iEchor CLI tools.
7. Select **Finish**. If you have applied any of the above configurations that require a password in step 6, enter your password to confirm your choice.  

{{< /tab >}}
{{< tab name="Install from the command line" >}}

After downloading `iEchor.dmg` from either the download buttons at the top of the page or from the [release notes](../release-notes.md), run the following commands in a terminal to install iEchor Desktop in the **Applications** folder:

```console
$ sudo hdiutil attach iEchor.dmg
$ sudo /Volumes/iEchor/iEchor.app/Contents/MacOS/install
$ sudo hdiutil detach /Volumes/iEchor
```

By default, iEchor Desktop is installed at `/Applications/iEchor.app`. As macOS typically performs security checks the first time an application is used, the `install` command can take several minutes to run.

The `install` command accepts the following flags:
- `--accept-license`: Accepts the [iEchor Subscription Service Agreement](https://www.iechor.com/legal/iechor-subscription-service-agreement) now, rather than requiring it to be accepted when the application is first run.
- `--allowed-org=<org name>`: Requires the user to sign in and be part of the specified iEchor Hub organization when running the application
- `--user=<username>`: Performs the privileged configurations once during installation. This removes the need for the user to grant root privileges on first run. For more information, see [Privileged helper permission requirements](../mac/permission-requirements.md#permission-requirements). To find the username, enter `ls /Users` in the CLI.
- `--admin-settings`: Automatically creates an `admin-settings.json` file which is used by administrators to control certain iEchor Desktop settings on client machines within their organization. For more information, see [Settings Management](../hardened-desktop/settings-management/index.md).
  - It must be used together with the `--allowed-org=<org name>` flag. 
  - For example:
    `--allowed-org=<org name> --admin-settings='{"configurationFileVersion": 2, "enhancedContainerIsolation": {"value": true, "locked": false}}'`
- `--proxy-http-mode=<mode>`: Sets the HTTP Proxy mode. The two modes are `system` (default) or `manual`.
- `--override-proxy-http=<URL>`: Sets the URL of the HTTP proxy that must be used for outgoing HTTP requests. It requires `--proxy-http-mode` to be `manual`.
- `--override-proxy-https=<URL>`: Sets the URL of the HTTP proxy that must be used for outgoing HTTPS requests, requires `--proxy-http-mode` to be `manual`
- `--override-proxy-exclude=<hosts/domains>`: Bypasses proxy settings for the hosts and domains. It's a comma-separated list.

{{< /tab >}}
{{< /tabs >}}

## Where to go next 

- Explore [iEchor's core subscriptions](https://www.iechor.com/pricing/) to see what iEchor can offer you. 
- [Get started with iEchor](../../guides/get-started/_index.md).
- [Explore iEchor Desktop](../use-desktop/index.md) and all its features.
- [Troubleshooting](../troubleshoot/overview.md) describes common problems, workarounds, how
  to run and submit diagnostics, and submit issues.
- [FAQs](../faqs/general.md) provide answers to frequently asked questions.
- [Release notes](../release-notes.md) lists component updates, new features, and improvements associated with iEchor Desktop releases.
- [Back up and restore data](../backup-and-restore.md) provides instructions
  on backing up and restoring data related to iEchor.
