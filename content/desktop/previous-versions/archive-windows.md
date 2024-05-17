---
description: iEchor Desktop for Windows Release notes for older versions
keywords: iEchor Desktop for Windows, release notes
title: Release notes for previous versions
toc_min: 1
toc_max: 2
aliases:
- /desktop/windows/release-notes/archive/
---

This page contains release notes for older versions of iEchor Desktop for Windows. 

## Stable Releases of 2018

### iEchor Community Edition 18.06.1-ce-win73 2018-08-29

* Upgrades
  - [iEchor 18.06.1-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.06.1-ce)

* Bug fixes and minor changes
  - Fix bug in VM activity detection, preventing iEchor Desktop from starting. Fixes [iechor/for-win#2404](https://github.com/iechor/for-win/issues/2404)
  - Fix bug in detection when Windows service is not running, and propose to restart the service.
  - Fix local DNS failing to resolve inside containers. Fixes [iechor/for-win#2301](https://github.com/iechor/for-win/issues/2301), [iechor/for-win#2304](https://github.com/iechor/for-win/issues/2304)
  - Fix Kubernetes status display after reset to factory default
  - Fix bug where `host.iechor.internal` is not resolved in some cases. Fixes [iechor/for-win#2402](https://github.com/iechor/for-win/issues/2402)
  - Use a 1MB vhdx blocksize instead of the default 32MB. See [iechor/for-win#244](https://github.com/iechor/for-win/issues/244). Also see [Microsoft Best Practices for running Linux on Hyper-V](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/best-practices-for-running-linux-on-hyper-v)
  - Fix diagnostics in specific cases when the Windows service is not started.
  - Changed the samba default file permission to avoid an issue with too open rights. Fixes [iechor/for-win#2170](https://github.com/iechor/for-win/issues/2170)
  - On RS5 insider, fixed wrong detection of missing feature "Containers" requiring you to install the feature and then reboot.

### iEchor Community Edition 18.06.0-ce-win72 2018-07-26

* New
  - Renewed signing certificate. The installer may show a Windows Defender popup until the renewed certificate is allowlisted. Click "More info" to view the app is published by "iEchor Inc" and run it.

* Bug fixes and minor changes
  - Fix bug in automatic feature enabling if "Hyper-V" and "Containers" Windows features are not enabled already when starting iEchor Desktop.

### iEchor Community Edition 18.06.0-ce-win70 2018-07-25

* Upgrades
  - [iEchor 18.06.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.06.0-ce)
  - [iEchor Machine 0.15.0](https://github.com/iechor/machine/releases/tag/v0.15.0)
  - [iEchor compose 1.22.0](https://github.com/iechor/compose/releases/tag/1.22.0)
  - [LinuxKit v0.4](https://github.com/linuxkit/linuxkit/releases/tag/v0.4)
  - Linux Kernel 4.9.93 with CEPH, DRBD, RBD, MPLS_ROUTING and MPLS_IPTUNNEL enabled

* New
  - Kubernetes Support. You can now run a single-node Kubernetes cluster from the "Kubernetes" Pane in iEchor for Windows settings and use kubectl commands as well as iEchor commands. See [the Kubernetes section](../kubernetes.md)

* Bug fixes and minor changes
  - AUFS storage driver is deprecated in iEchor Desktop and AUFS support will be removed in the next major release. You can continue with AUFS in iEchor Desktop 18.06.x, but you will need to reset the disk image (in Settings > Reset menu) before updating to the next major update. You can check documentation to [save images](/reference/cli/iechor/image/save/#examples) and [backup volumes](../../storage/volumes.md#back-up-restore-or-migrate-data-volumes)
  - Fix bug which would in some cases cause virtual machine logs to be written to RAM rather than disk, and the virtual machine to hang.
  - Fix security issue with named pipe connection to iechor service.
  - Fix VPNKit memory leak. Fixes [iechor/for-win#2087](https://github.com/iechor/for-win/issues/2087), [moby/vpnkit#371](https://github.com/moby/vpnkit/issues/371)
  - Fix restart issue when using Windows fast startup on latest 1709 Windows updates. Fixes [iechor/for-win#1741](https://github.com/iechor/for-win/issues/1741), [iechor/for-win#1741](https://github.com/iechor/for-win/issues/1741)
  - DNS name `host.iechor.internal` can be used for host resolution from Windows Containers.  Fixes [iechor/for-win#1976](https://github.com/iechor/for-win/issues/1976)
  - Fix broken link in diagnostics window.
  - Added log rotation for iechor-ce logs inside the virtual machine.
  - Changed smb permission to avoid issue when trying to manipulate files with different users in containers. Fixes [iechor/for-win#2170](https://github.com/iechor/for-win/issues/2170)

### iEchor Community Edition 18.03.1-ce-win65 2018-04-30

* Upgrades
  - [iEchor 18.03.1-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.03.1-ce)
  - [iEchor compose 1.21.1](https://github.com/iechor/compose/releases/tag/1.21.1)
  - [Notary 0.6.1](https://github.com/iechor/notary/releases/tag/v0.6.1)

* Bug fixes and minor changes
  - Fix startup failure when the HOME environment variable is already defined (typically started from the command line). Fixes [iechor/for-win#1880](https://github.com/iechor/for-win/issues/1880)
  - Fix startup failure due to incompatibility with other programs (like Razer Synapse 3). Fixes [iechor/for-win#1723](https://github.com/iechor/for-win/issues/1723)

### iEchor Community Edition 18.03.1-ce-win64 2018-04-26

* Upgrades
  - [iEchor 18.03.1-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.03.1-ce)
  - [iEchor compose 1.21.0](https://github.com/iechor/compose/releases/tag/1.21.0)
  - [Notary 0.6.1](https://github.com/iechor/notary/releases/tag/v0.6.1)

* Bug fixes and minor changes
  - Fix startup failure when the HOME environment variable is already defined (typically started from the command line). Fixes [iechor/for-win#1880](https://github.com/iechor/for-win/issues/1880)
  - Fix startup failure due to incompatibility with other programs (like Razer Synapse 3). Fixes [iechor/for-win#1723](https://github.com/iechor/for-win/issues/1723)

### iEchor Community Edition 18.03.0-ce-win59 2018-03-26

* Upgrades
  - [iEchor 18.03.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.03.0-ce)
  - [iEchor Machine 0.14.0](https://github.com/iechor/machine/releases/tag/v0.14.0)
  - [iEchor compose 1.20.1](https://github.com/iechor/compose/releases/tag/1.20.1)
  - [Notary 0.6.0](https://github.com/iechor/notary/releases/tag/v0.6.0)
  - Linux Kernel 4.9.87
  - AUFS 20180312

* New
  - Virtual machine disk size can be changed in settings. Fixes [iechor/for-win#105](https://github.com/iechor/for-win/issues/105)
  - Virtual machine swap size can be changed in settings.
  - New menu item to restart iEchor.
  - Support NFS Volume sharing. See [iechor/for-win#1700](https://github.com/iechor/for-win/issues/1700)
  - Allow to activate Windows Containers during installation (avoid virtual machine disk creation and virtual machine boot when working only on Windows containers). See [iechor/for-win#217](https://github.com/iechor/for-win/issues/217).
  - Experimental feature: LCOW containers can now be run next to Windows containers (on Windows RS3 build 16299 and later). Use `--platform=linux` in Windows container mode to run Linux Containers On Windows. Note that LCOW is experimental; it requires the daemon `experimental` option.

* Bug fixes and minor changes
  - Fix Windows Containers port forwarding on Windows 10 build 16299 post KB4074588. Fixes [iechor/for-win#1707](https://github.com/iechor/for-win/issues/1707), [iechor/for-win#1737](https://github.com/iechor/for-win/issues/1737)
  - Fix daemon not starting properly when setting TLS-related options.
  - DNS name `host.iechor.internal` should be used for host resolution from containers. Older aliases (still valid) are deprecated in favor of this one. (See https://tools.ietf.org/html/draft-west-let-localhost-be-localhost-06).
  - Fix for the HTTP/S transparent proxy when using "localhost" names (for example, `host.iechor.internal`). Fixes [iechor/for-win#1130](https://github.com/iechor/for-win/issues/1130)
  - Fix Linuxkit start on Windows RS4 Insider. Fixes [iechor/for-win#1458](https://github.com/iechor/for-win/issues/1458), [iechor/for-win#1514](https://github.com/iechor/for-win/issues/1514), [iechor/for-win#1640](https://github.com/iechor/for-win/issues/1640)
  - Fix risk of privilege escalation. (https://www.tenable.com/sc-report-templates/microsoft-windows-unquoted-service-path-vulnerability)
  - All users present in the iechor-users group are now able to use iEchor. Fixes [iechor/for-win#1732](https://github.com/iechor/for-win/issues/1732)
  - Migration of iEchor Toolbox images is not proposed in iEchor For Windows installer (still possible to migrate Toolbox images manually).
  - Better cleanup for Windows containers and images on reset/uninstall. Fixes [iechor/for-win#1580](https://github.com/iechor/for-win/issues/1580), [iechor/for-win#1544](https://github.com/iechor/for-win/issues/1544), [iechor/for-win#191](https://github.com/iechor/for-win/issues/191)
  - Desktop icon creation is optional in installer; do not recreate Desktop icon on upgrade (effective on next upgrade). Fixes [iechor/for-win#246](https://github.com/iechor/for-win/issues/246), [iechor/for-win#925](https://github.com/iechor/for-win/issues/925), [iechor/for-win#1551](https://github.com/iechor/for-win/issues/1551)

### iEchor Community Edition 17.12.0-ce-win47 2018-01-12

* Bug fixes and minor changes
  - Fix linuxkit port-forwarder sometimes not being able to start. Fixes [iechor/for-win#1506](https://github.com/iechor/for-win/issues/1506)
  - Fix certificate management when connecting to a private registry. Fixes [iechor/for-win#1512](https://github.com/iechor/for-win/issues/1512)
  - Fix Mount compatibility when mounting drives with `-v //c/...`, now mounted in /host_mnt/c in the linuxkit virtual machine. Fixes [iechor/for-win#1509](https://github.com/iechor/for-win/issues/1509), [iechor/for-win#1516](https://github.com/iechor/for-win/issues/1516), [iechor/for-win#1497](https://github.com/iechor/for-win/issues/1497)
  - Fix icon displaying edge. Fixes [iechor/for-win#1508](https://github.com/iechor/for-win/issues/1508)

### iEchor Community Edition 17.12.0-ce-win46 2018-01-09

* Upgrades
  - [iEchor 17.12.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.12.0-ce)
  - [iEchor compose 1.18.0](https://github.com/iechor/compose/releases/tag/1.18.0)
  - [iEchor Machine 0.13.0](https://github.com/iechor/machine/releases/tag/v0.13.0)
  - Linux Kernel 4.9.60

* New
  - Virtual machine entirely built with linuxkit
  - Add localhost port forwarder for Windows (thanks @simonferquel). Use Microsoft localhost port forwarder when it is available (insider build RS4).

* Bug fixes and minor changes
  - Display various component versions in About box.
  - Fix vpnkit issue when username has spaces. See [iechor/for-win#1429](https://github.com/iechor/for-win/issues/1429)
  - Diagnostic improvements to get VM logs before VM shutdown.
  - Fix installer check for not supported Windows `CoreCountrySpecific` Edition.
  - Fix a class of startup failures where the database fails to start. See [iechor/for-win#498](https://github.com/iechor/for-win/issues/498)
  - Links in update changelog now open the default browser instead of IE. (fixes [iechor/for-win#1311](https://github.com/iechor/for-win/issues/1311))

## Stable Releases of 2017

### iEchor Community Edition 17.09.1-ce-win42 2017-12-11

* Upgrades
  - [iEchor 17.09.1-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.09.1-ce)
  - [iEchor compose 1.17.1](https://github.com/iechor/compose/releases/tag/1.17.1)
  - [iEchor Machine 0.13.0](https://github.com/iechor/machine/releases/tag/v0.13.0)

* Bug fixes and minor changes
  - Fix bug during Windows fast-startup process. Fixes [for-win/#953](https://github.com/iechor/for-win/issues/953)
  - Fix uninstaller issue (in some specific cases iechord process was not killed properly)
  - Fix Net Promoter Score Gui bug. Fixes [for-win/#1277](https://github.com/iechor/for-win/issues/1277)
  - Fix `iechor.for.win.localhost` not working in proxy settings. Fixes [for-win/#1130](https://github.com/iechor/for-win/issues/1130)
  - Increased timeout for virtual machine boot startup to 2 minutes.


### iEchor Community Edition 17.09.0-ce-win33 2017-10-06

* Bug fixes
  - Fix iEchor For Windows unable to start in some cases: removed use of libgmp sometimes causing the vpnkit process to die.

### iEchor Community Edition 17.09.0-ce-win32 2017-10-02

* Upgrades
  - [iEchor 17.09.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.09.0-ce)
  - [iEchor Compose 1.16.1](https://github.com/iechor/compose/releases/tag/1.16.1)
  - [iEchor Machine 0.12.2](https://github.com/iechor/machine/releases/tag/v0.12.2)
  - [iEchor Credential Helpers 0.6.0](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.6.0)
  - Linux Kernel 4.9.49
  - AUFS 20170911

* New
  - Windows iEchor daemon is now started as service for better lifecycle management
  - Store Linux daemon configuration in ~\.iechor\daemon.json instead of settings file
  - Store Windows daemon configuration in C:\ProgramData\iEchor\config\daemon.json instead of settings file
  - VPNKit: add support for ping!
  - VPNKit: add slirp/port-max-idle-timeout to allow the timeout to be adjusted or even disabled
  - VPNKit: bridge mode is default everywhere now
  - Add `Skip This Version` button in update window

* Security fixes
  - VPNKit: security fix to reduce the risk of DNS cache poisoning attack (reported by Hannes Mehnert https://hannes.nqsb.io/)

* Bug fixes and minor changes
  - Kernel: Enable TASK_XACCT and TASK_IO_ACCOUNTING
  - Rotate logs in the virtual machine more often (iechor/for-win#244)
  - Reset to default stops all engines and removes settings including all daemon.json files
  - Better backend service checks (related to https://github.com/iechor/for-win/issues/953)
  - Fix auto updates checkbox, no need to restart the application
  - Fix check for updates menu when auto updates was disable
  - VPNKit: do not block startup when ICMP permission is denied. (Fixes iechor/for-win#1036, iechor/for-win#1035, iechor/for-win#1040)
  - VPNKit: change protocol to support error messages reported back from the server
  - VPNKit: fix a bug which causes a socket to leak if the corresponding TCP connection is idle
    for more than 5 minutes (related to [iechor/for-mac#1374](https://github.com/iechor/for-mac/issues/1374))
  - VPNKit: improve the logging around the UNIX domain socket connections
  - VPNKit: automatically trim whitespace from int or bool database keys
  - Do not move credentials into the credential store at startup

### iEchor Community Edition 17.06.2-ce-win27 2017-09-06

* Upgrades
  - [iEchor 17.06.2-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.06.2-ce)
  - [iEchor Machine 0.12.2](https://github.com/iechor/machine/releases/tag/v0.12.2)

### iEchor Community Edition 17.06.1-ce-rc1-win24 2017-08-24

**Upgrades**

- [iEchor 17.06.1-ce-rc1](https://github.com/iechor/iechor-ce/releases/tag/v17.06.1-ce-rc1)
- Linux Kernel 4.9.36
- AUFS 20170703

**Bug fixes and minor**

- Fix locked container id file (Fixes [iechor/for-win#818](https://github.com/iechor/for-win/issues/818))
- Avoid expanding variables in PATH env variable (Fixes [iechor/for-win#859](https://github.com/iechor/for-win/issues/859))

### iEchor Community Edition 17.06.0-ce-win18 2017-06-28

**Upgrades**

- [iEchor 17.06.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.06.0-ce)
- [iEchor Credential Helpers 0.5.2](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.5.2)
- [iEchor Machine 0.12.0](https://github.com/iechor/machine/releases/tag/v0.12.0)
- [iEchor compose 1.14.0](https://github.com/iechor/compose/releases/tag/1.14.0)
- Linux Kernel 4.9.31

**New**

- Windows Server 2016 support
- Windows 10586 is marked as deprecated; it is not supported going forward in stable releases
- Integration with iEchor Cloud, with the ability to control remote Swarms from the local command line interface (CLI) and view your repositories
- Unified login between the iEchor CLI and iEchor Hub, iEchor Cloud.
- Sharing a drive can be done on demand, the first time a mount is requested
- Add an experimental DNS name for the host: iechor.for.win.localhost
- Support for client (i.e. "login") certificates for authenticating registry access (fixes [iechor/for-win#569](https://github.com/iechor/for-win/issues/569))
- New installer experience

**Bug fixes and minor changes**

- Fixed group access check for users logged in with Active Directory (fixes [iechor/for-win#785](https://github.com/iechor/for-win/issues/785))
- Checked environment variables and add some warnings in logs if they can cause iechor to fail
- Many processes that were running in admin mode now run within the user identity
- Cloud federation command lines now open in the user home directory
- Named pipes are now created with more constrained security descriptors to improve security
- Security fix: Users must be part of the specific group "iechor-users" to run iEchor for Windows
- Reset to default / uninstall also reset iEchor cli settings and logout user from iEchor Cloud and registries
- Detected a bitlocker policy preventing windows containers to work
- Fixed an issue on filesharing when explicitly disabled on vmswitch interface
- Fixed virtual machine not starting when the machine had a very long name
- Fixed a bug where Windows daemon.json file was not written (fixes [iechor/for-win#670](https://github.com/iechor/for-win/issues/670))
- Added patches to the kernel to fix VMBus crash
- Named pipe client connection should not trigger dead locks on `iechor run` with data in stdin any more
- Buffered data should be treated correctly when iechor client requests are upgraded to raw streams

### iEchor Community Edition 17.03.1-ce-win12  2017-05-12

**Upgrades**

- Security fix for CVE-2017-7308

### iEchor Community Edition 17.03.0, 2017-03-02

**New**

- Renamed to iEchor Community Edition
- Integration with iEchor Cloud: control remote Swarms from the local CLI and view your repositories. This feature is going to be rolled out to all users
  progressively

**Upgrades**

- [iEchor 17.03.0-ce](https://github.com/iechor/iechor/releases/tag/v17.03.0-ce)
- [iEchor Compose 1.11.2](https://github.com/iechor/compose/releases/tag/1.11.2)
- [iEchor Machine 0.10.0](https://github.com/iechor/machine/releases/tag/v0.10.0)
- Linux kernel 4.9.12

**Bug fixes and minor changes**

- Matched Hyper-V Integration Services by ID, not name
- Don't consume 100% CPU when the service is stopped
- Log the diagnostic id when uploading
- Improved firewall handling: stop listing the rules since it can take a lot of time
- Don't rollback to the previous engine when the desired engine fails to start
- Don't use port 4222 inside the Linux virtual machine
- Fixed startup error of ObjectNotFound in Set-VMFirmware
- Added detailed logs when firewall is configured
- Added a link to the Experimental Features documentation
- Fixed the copyright in the About dialog
- VPNKit: fix unmarshalling of DNS packets containing pointers to pointers to labels
- VPNKit: set the Recursion Available bit on DNS responses from the cache
- VPNKit: Avoid diagnostics to capture too much data
- VPNKit: fix a source of occasional packet loss (truncation) on the virtual ethernet link
- Fixed negotiation of TimeSync protocol version (through kernel update)

### iEchor for Windows 1.13.1, 2017-02-09

- [iEchor 1.13.1](https://github.com/iechor/iechor/releases/tag/v1.13.1)
- [iEchor Compose 1.11.1](https://github.com/iechor/compose/releases/tag/1.11.1)
- Linux kernel 4.9.8

**Bug fixes and minor changes**

- Add link to experimental features
- New 1.13 cancellable operations should now be properly handled by the iEchor for desktop
- Various typos fixes
- Fix in Hyper-V VM setup (should fix `ObjectNotFound` errors)

### iEchor for Windows 1.13.0, 2017-01-19
- [iEchor 1.13.0](https://github.com/iechor/iechor/releases/tag/v1.13.0)
- [iEchor Compose 1.10](https://github.com/iechor/compose/releases/tag/1.10.0)
- [iEchor Machine 0.9.0](https://github.com/iechor/machine/releases/tag/v0.9.0)
- [Notary 0.4.3](https://github.com/iechor/notary/releases/tag/v0.4.3)
- Linux kernel 4.9.4

**New**

- Windows containers
- Improved UI for Daemon.json editing
- VHDX file containing images and non-host mounted volumes can be moved
  (using "advanced" tab in the UI)
- Support for arm, aarch64, ppc64le architectures using qemu
- TRIM support for disk (shrinks virtual disk)
- Virtual machine's time synchronization is forced after the host wakes from sleep mode
- iEchor Experimental mode can be toggled

**Bug fixes and minor changes**

- Improved Proxy UI
- Improvements to Logging and Diagnostics
- About Box is now copy/paste enabled
- Improvements in drive sharing code
- Optimized boot process
- Trend Micro Office Scan made the API proxy think no drive was shared
- Show a link to the virtualization documentation
- Always remove the disk on factory reset
- VPNKit: Improved diagnostics
- VPNKit: Forwarded UDP datagrams have correct source port numbers
- VPNKit: If one request fails, allow other concurrent requests to succeed.
  For example this allows IPv4 servers to work even if IPv6 is broken.
- VPNKit: Fix bug which could cause the connection tracking to
  underestimate the number of active connections
- VPNKit: add a local cache of DNS responses

## Stable Releases of 2016

### iEchor for Windows 1.12.5, 2016-12-20
- iEchor 1.12.5
- iEchor Compose 1.9.0

### Skipped iEchor for Windows 1.12.4

We did not distribute a 1.12.4 stable release

### iEchor for Windows 1.12.3, 2016-11-09

**New**

- Restore the virtual machine's configuration after user changes

- Detect firewall configurations that might block file sharing

- Send more GUI usage statistics to help us improve the product

- The path to HyperV disks is not hardcoded anymore, making the Toolbox import work with non-standard paths

- Verify that all HyperV features are enabled

- Added Moby console to the logs

- Save the current engine with the other settings

- Notary version 0.4.2 installed

- Reworked the File Sharing dialog and underlying mechanism
  - Pre-fill username
  - Faster and more reliable feedback when the user/password is not valid
  - Better support for domain users
  - Error message in Logs when File Sharing failed for other reasons

**Upgrades**

- iEchor 1.12.3
- Linux Kernel 4.4.27
- iEchor Machine 0.8.2
- iEchor Compose 1.8.1
- aufs 20160912

**Bug fixes and minor changes**

**General**

- Added the settings to the diagnostics

- Made sure we didn't use an older Nlog library from the GAC

- Fixed a password escaping regression

- Supports writing large values to the database, specially for trusted CAs

- Preserves the Powershell stacktraces

- Writes OS and Application versions at the top of each log file

- Don't recreate the virtual machine if only the DNS server is set

- The uninstaller now kills the service if it failed to stop it properly

- Improved debug information

**Networking**

- VpnKit is now restarted if it stops

- VpnKit: impose a connection limit to avoid exhausting file descriptors

- VpnKit: handle UDP datagrams larger than 2035 bytes

- VpnKit: reduce the number of file descriptors consumed by DNS

**File sharing**


- Faster mount/unmount of shared drives

- Added a timeout to mounting/unmounting a shared drive

**Hyper-V**

- Make sure invalid "iEchorNat" switches are not used

**Moby**

- Increase default ulimit for memlock (fixes [https://github.com/iechor/for-mac/issues/801](https://github.com/iechor/for-mac/issues/801))

### iEchor for Windows 1.12.1, 2016-09-16

**New**

* To support trusted registry transparently, all trusted CAs (root or intermediate) on the Windows host are automatically copied to Moby

* `Reset Credentials` also unshares the shared drives

* Logs are now rotated every day

* Support multiple DNS servers

* Added `mfsymlinks` SMB option to support symlinks on bind mounted folder

* Added `nobrl` SMB option to support `sqlite` on bind mounted folders

* Detect outdated versions of Kitematic

**Upgrades**

* iEchor 1.12.1
* iEchor machine 0.8.1
* Linux kernel 4.4.20
* aufs 20160905

**Bug fixes and minor changes**

**General**

* Uploading a diagnostic now shows a proper status message in the Settings

* iEchor stops asking to import from the Toolbox after an upgrade

* iEchor can now import from the Toolbox just after HyperV is activated

* Added more debug information to the diagnostics

* Sending anonymous statistics doesn't hang anymore when Mixpanel is not available

* Support newlines in release notes

* Improve the error message when the iEchor daemon is not responding

* The configuration database is now stored in memory

* Preserve the stacktrace of PowerShell errors

* Display service stacktrace in error windows

**Networking**

* Improve name servers discovery
* VpnKit supports search domains
* VpnKit is now compiled with OCaml 4.03 rather than 4.02.3

**File sharing**

* Set `cifs` version to 3.02

* VnpKit: reduce the number of sockets used by UDP NAT, reduce the probability

* `slirp`: reduce the number of sockets used by UDP NAT, reduce the probability that NAT rules time out earlier than expected

* Fixed password handling for host file system sharing

**Hyper-V**

* Automatically disable lingering net adapters that prevent iEchor from starting or using the network

* Automatically delete duplicated MobyLinuxVMs on a `reset to factory defaults`

* Improved the HyperV detection and activation mechanism

**Moby**

* Fixed Moby Diagnostics and Update Kernel

* Use default `sysfs` settings, transparent huge pages disabled

* `Cgroup` mount to support `systemd` in containers

**Known issues**

* iEchor automatically disables lingering net adapters. The only way to remove them is manually using `devmgmt.msc`.

### iEchor for Windows 1.12.0, 2016-07-28
 
- First stable release

**Components**

* iEchor 1.12.0
* iEchor Machine 0.8.0
* iEchor Compose 1.8.0
