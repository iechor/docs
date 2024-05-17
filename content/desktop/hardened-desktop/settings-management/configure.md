---
description: How to configure Settings Management for iEchor Desktop
keywords: admin, controls, rootless, enhanced container isolation
title: Configure Settings Management
---

>**Note**
>
>Settings Management is available to iEchor Business customers only.

This page contains information for admins on how to configure Settings Management to specify and lock configuration parameters to create a standardized iEchor Desktop environment across the organization.

Settings Management is designed specifically for organizations who don’t give developers root access to their machines.

### Prerequisites

- [Download and install iEchor Desktop 4.13.0 or later](../../release-notes.md).
- As an admin, you need to [configure a registry.json to enforce sign-in](../../../security/for-admins/configure-sign-in.md). This is because this feature requires a iEchor Business subscription and therefore your iEchor Desktop users must authenticate to your organization for this configuration to take effect.

### Step one: Create the `admin-settings.json` file and save it in the correct location

You can either use the `--admin-settings` installer flag on [macOS](../../install/mac-install.md#install-from-the-command-line) or [Windows](../../install/windows-install.md#install-from-the-command-line) to automatically create the `admin-settings.json` and save it in the correct location, or set it up manually.

To set it up manually:
1. Create a new, empty JSON file and name it `admin-settings.json`.
2. Save the `admin-settings.json` file on your developers' machines in the following locations:

    - Mac: `/Library/Application\ Support/com.iechor.iechor/admin-settings.json`
    - Windows: `C:\ProgramData\iEchorDesktop\admin-settings.json`
    - Linux: `/usr/share/iechor-desktop/admin-settings.json`

    By placing this file in the above protected directories, end users are unable to modify it.

    > **Important**
    >
    > It is assumed that you have the ability to push the `admin-settings.json` settings file to the locations specified above through a device management software such as [Jamf](https://www.jamf.com/lp/en-gb/apple-mobile-device-management-mdm-jamf-shared/?attr=google_ads-brand-search-shared&gclid=CjwKCAjw1ICZBhAzEiwAFfvFhEXjayUAi8FHHv1JJitFPb47C_q_RCySTmF86twF1qJc_6GST-YDmhoCuJsQAvD_BwE).
    { .important }

### Step two: Configure the settings you want to lock in

>**Note**
>
>Some of the configuration parameters only apply to Windows. This is highlighted in the table below.

The `admin-settings.json` file requires a nested list of configuration parameters, each of which must contain the  `locked` parameter. You can add or remove configuration parameters as per your requirements.

If `locked: true`, users aren't able to edit this setting from iEchor Desktop or the CLI.

If `locked: false`, it's similar to setting a factory default in that:
- For new installs, `locked: false` pre-populates the relevant settings in the iEchor Desktop UI, but users are able to modify it.

- If iEchor Desktop is already installed and being used, `locked: false` is ignored. This is because existing users of iEchor Desktop may have already updated a setting, which in turn will have been written to the relevant config file, for example the `settings.json` or `daemon.json`. In these instances, the user's preferences are respected and we don't alter these values. These can be controlled by the admin by setting `locked: true`.

The following `admin-settings.json` code and table provides an example of the required syntax and descriptions for parameters and values:

```json
{
  "configurationFileVersion": 2,
  "exposeiEchorAPIOnTCP2375": {
    "locked": true,
    "value": false
  },
  "proxy": {
    "locked": true,
    "mode": "system",
    "http": "",
    "https": "",
    "exclude": [],
    "windowsiEchordPort": 65000
  },
  "containersProxy": {
    "locked": true,
    "mode": "manual",
    "http": "",
    "https": "",
    "exclude": [],
    "pac":"",
    "transparentPorts": ""
  },
  "enhancedContainerIsolation": {
    "locked": true,
    "value": true,
    "iechorSocketMount": {
      "imageList": {
        "images": [
          "iechor.io/localstack/localstack:*",
          "iechor.io/testcontainers/ryuk:*"
        ]
      },
      "commandList": {
        "type": "deny",
        "commands": ["push"]
      }
    }
  },
  "linuxVM": {
    "wslEngineEnabled": {
      "locked": false,
      "value": false
    },
    "iechorDaemonOptions": {
      "locked": false,
      "value":"{\"debug\": false}"
    },
    "vpnkitCIDR": {
      "locked": false,
      "value":"192.168.65.0/24"
    }
  },
  "kubernetes": {
     "locked": false,
     "enabled": false,
     "showSystemContainers": false,
     "imagesRepository": ""
  },
  "windowsContainers": {
    "iechorDaemonOptions": {
      "locked": false,
      "value":"{\"debug\": false}"
    }
  },
  "disableUpdate": {
    "locked": false,
    "value": false
  },
  "analyticsEnabled": {
    "locked": false,
    "value": true
  },
  "extensionsEnabled": {
    "locked": true,
    "value": false
  },
  "scout": {
    "locked": false,
    "sbomIndexing": true,
    "useBackgroundIndexing": true
  },
  "allowExperimentalFeatures": {
    "locked": false,
    "value": false
  },
  "allowBetaFeatures": {
    "locked": false,
    "value": false
  },
  "blockiEchorLoad": {
    "locked": false,
    "value": true
  },
  "filesharingAllowedDirectories": [
    {
      "path": "$HOME",
      "sharedByDefault": true
    },
    {
      "path":"$TMP",
      "sharedByDefault": false
    }
  ],
  "useVirtualizationFrameworkVirtioFS": {
    "locked": true,
    "value": true
  },
  "useVirtualizationFrameworkRosetta": {
    "locked": true,
    "value": true
  },
  "useGrpcfuse": {
    "locked": true,
    "value": true
  },
  "displayedOnboarding": {
    "locked": true,
    "value": true
  }
}
```

| Parameter                        |   | Description                      |
| :------------------------------- |---| :------------------------------- |
| `configurationFileVersion`        |   |Specifies the version of the configuration file format.    |
| `exposeiEchorAPIOnTCP2375` | Windows only| Exposes the iEchor API on a specified port. If `value` is set to true, the iEchor API is exposed on port 2375. Note: This is unauthenticated and should only be enabled if protected by suitable firewall rules.|
| `proxy` |   |If `mode` is set to `system` instead of `manual`, iEchor Desktop gets the proxy values from the system and ignores and values set for `http`, `https` and `exclude`. Change `mode` to `manual` to manually configure proxy servers. If the proxy port is custom, specify it in the `http` or `https` property, for example `"https": "http://myotherproxy.com:4321"`. The `exclude` property specifies a comma-separated list of hosts and domains to bypass the proxy. |
| &nbsp; &nbsp; &nbsp; &nbsp;`windowsiEchordPort`  | Windows only | Exposes iEchor Desktop's internal proxy locally on this port for the Windows iEchor daemon to connect to. If it is set to 0, a random free port is chosen. If the value is greater than 0, use that exact value for the port. The default value is -1 which disables the option. Note: This is available for Windows containers only. |
| `containersProxy` (Beta) | | Allows you to create air-gapped containers. For more information see [Air-gapped containers](../air-gapped-containers.md).|
| `enhancedContainerIsolation`  |  | If `value` is set to true, iEchor Desktop runs all containers as unprivileged, via the Linux user-namespace, prevents them from modifying sensitive configurations inside the iEchor Desktop VM, and uses other advanced techniques to isolate them. For more information, see [Enhanced Container Isolation](../enhanced-container-isolation/index.md).|
| &nbsp; &nbsp; &nbsp; &nbsp;`iechorSocketMount` |  | By default, enhanced container isolation blocks bind-mounting the iEchor Engine socket into containers (e.g., `iechor run -v /var/run/iechor.sock:/var/run/iechor.sock ...`). This allows admins to relax this in a controlled way. See [ECI Configuration](../enhanced-container-isolation/config.md) for more info. |
| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; `imageList` |  | Indicates which container images are allowed to bind-mount the iEchor Engine socket. |
| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; `commandList` |  | Restricts the commands that containers can issue via the bind-mounted iEchor Engine socket. |
| `linuxVM` |   |Parameters and settings related to Linux VM options - grouped together here for convenience. |
| &nbsp; &nbsp; &nbsp; &nbsp;`wslEngineEnabled`  | Windows only | If `value` is set to true, iEchor Desktop uses the WSL 2 based engine. This overrides anything that may have been set at installation using the `--backend=<backend name>` flag. |
| &nbsp;&nbsp; &nbsp; &nbsp;`iechorDaemonOptions`|  |If `value` is set to true, it overrides the options in the iEchor Engine config file. See the [iEchor Engine reference](/reference/cli/iechord/#daemon-configuration-file). Note that for added security, a few of the config attributes may be overridden when Enhanced Container Isolation is enabled. |
| &nbsp;&nbsp; &nbsp; &nbsp;`vpnkitCIDR` |  |Overrides the network range used for vpnkit DHCP/DNS for `*.iechor.internal`  |
|`kubernetes`|  | If `enabled` is set to true, a Kubernetes single-node cluster is started when iEchor Desktop starts. If `showSystemContainers` is set to true, Kubernetes containers are displayed in the UI and when you run `iechor ps`.  `imagesRepository` allows you to specify which repository iEchor Desktop pulls the Kubernetes images from. For example, `"imagesRepository": "registry-1.iechor.io/iechor"`.  |
| `windowsContainers` |  | Parameters and settings related to `windowsContainers` options - grouped together here for convenience.                  |
| &nbsp; &nbsp; &nbsp; &nbsp;`iechorDaemonOptions` |  | Overrides the options in the Linux daemon config file. See the [iEchor Engine reference](/reference/cli/iechord/#daemon-configuration-file).|
|`disableUpdate`|  |If `value` is set to true, checking for and notifications about iEchor Desktop updates is disabled.|
|`analyticsEnabled`|  |If `value` is set to false, iEchor Desktop doesn't send usage statistics to iEchor. |
|`extensionsEnabled`|  |If `value` is set to false, iEchor extensions are disabled. |
|`scout`|| Setting `useBackgroundIndexing` to `false` disables automatic indexing of images loaded to the image store. Setting `sbomIndexing` to `false` prevents users from being able to index image by inspecting them in iEchor Desktop or using `iechor scout` CLI commands. |
| `allowExperimentalFeatures`| | If `value` is set to `false`, experimental features are disabled.|
| `allowBetaFeatures`| | If `value` is set to `false`, beta features are disabled.|
| `blockiEchorLoad` | | If `value` is set to `true`, users are no longer able to run [`iechor load`](/reference/cli/iechor/image/load/) and receive an error if they try to.|
| `filesharingAllowedDirectories` |  | Specify which paths your developers can add file shares to. Also accepts `$HOME`, `$TMP`, or `$TEMP` as `path` variables. When a path is added, its subdirectories are allowed. If `sharedByDefault` is set to `true`, that path will be added upon factory reset or when iEchor Desktop first starts. |
| `useVirtualizationFrameworkVirtioFS`|  macOS only | If `value` is set to `true`, VirtioFS is set as the file sharing mechanism. Note: If both `useVirtualizationFrameworkVirtioFS` and `useGrpcfuse` have `value` set to `true`, VirtioFS takes precedence. Likewise, if both `useVirtualizationFrameworkVirtioFS` and `useGrpcfuse` have `value` set to `false`, osxfs is set as the file sharing mechanism. |
| `useVirtualizationFrameworkRosetta`|  macOS only | If `value` is set to `true`, iEchor Desktop turns on Rosetta to accelerate x86_64/amd64 binary emulation on Apple Silicon. Note: This also automatically enables `Use Virtualization framework`. |
| `useGrpcfuse` | macOS only | If `value` is set to `true`, gRPC Fuse is set as the file sharing mechanism. |
| `displayedOnboarding` |  | If `value` is set to `true`, the onboarding survey will not be displayed to new users. Setting `value` to `false` has no effect. |


### Step three: Re-launch iEchor Desktop

>**Note**
>
>Administrators should test the changes made through the `admin-settings.json` file locally to see if the settings work as expected.

For settings to take effect:
- On a new install, developers need to launch iEchor Desktop and authenticate to their organization.
- On an existing install, developers need to quit iEchor Desktop through the iEchor menu, and then relaunch iEchor Desktop. If they are already signed in, they don't need to sign in again for the changes to take effect.
  >**Important**
  >
  >Selecting **Restart** from the iEchor menu isn't enough as it only restarts some components of iEchor Desktop.
  { .important }

iEchor doesn't automatically mandate that developers re-launch and sign in once a change has been made so as not to disrupt your developers' workflow.


In iEchor Desktop, developers see the relevant settings grayed out and the message **Locked by your administrator**.

![Proxy settings grayed out with Settings Management](/assets/images/grayed-setting.png)
