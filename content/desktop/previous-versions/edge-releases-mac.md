---
description: Change log / release notes per Edge release
keywords: iEchor Desktop for Mac, edge, release notes
title: iEchor Desktop for Mac Edge release notes
toc_min: 1
toc_max: 2
aliases:
- /desktop/mac/release-notes/edge-releases/
---

This page contains information about iEchor Desktop Edge releases. Edge releases give you early access to our newest features. Note that some of the features may be experimental, and some of them may not ever reach the Stable release. 

For iEchor Desktop system requirements, see
[What to know before you install](../install/mac-install.md#system-requirements).

## iEchor Desktop Community 2.5.4
2020-12-07

### Upgrades

- [iEchor Engine 20.10.0-rc2](https://github.com/iechor/iechor-ce/blob/master/CHANGELOG.md#20100)
- [Go 1.15.6](https://github.com/golang/go/issues?q=milestone%3AGo1.15.6+label%3ACherryPickApproved+)

### Bug fixes and minor changes

- Changed the «Update and quit» menu entry to «Update and restart».
- Fixed the check for updates dialog reporting the build number instead of the version number of a new version.
- Downgraded the kernel to [4.19.121](https://hub.iechor.com/layers/iechor/for-desktop-kernel/4.19.121-2a1dbedf3f998dac347c499808d7c7e029fbc4d3-amd64/images/sha256-4e7d94522be4f25f1fbb626d5a0142cbb6e785f37e437f6fd4285e64a199883a?context=repo) to reduce the CPU usage of hyperkit. Fixes [iechor/for-mac#5044](https://github.com/iechor/for-mac/issues/5044)
-  Fixed a bug that DNS would return `NXDOMAIN` when a name exists but the type of record was not found. Fixes [iechor/for-mac#5020](https://github.com/iechor/for-mac/issues/5020). Related to https://gitlab.alpinelinux.org/alpine/aports/-/issues/11879
- Avoid caching bad file sizes and modes when using `osxfs`. Fixes [iechor/for-mac#5045](https://github.com/iechor/for-mac/issues/5045).

## iEchor Desktop Community 2.5.3
2020-11-30

### Upgrades

- [Compose CLI v1.0.3](https://github.com/iechor/compose-cli/releases/tag/v1.0.3)

### Bug fixes and minor changes

- Fixed a possible file sharing error where a file may appear to have the wrong size in a container when it is modified on the host. This is a partial fix for [iechor/for-mac#4999](https://github.com/iechor/for-mac/issues/4999).
- Removed unnecessary log messages which slow down filesystem event injection.

## iEchor Desktop Community 2.5.2
2020-11-26

### New

- Use of three digit version number.
- Starting with iEchor Desktop 2.5.2, updates will be much smaller as they will be applied using delta patches.

### Bug fixes and minor changes

- Re-enabled the experimental SOCKS proxy. Fixes [iechor/for-mac#5048](https://github.com/iechor/for-mac/issues/5048).
- Fixed an unexpected EOF error when trying to start a non-existing container with `-v /var/run/iechor.sock:`. See [iechor/for-mac#5025](https://github.com/iechor/for-mac/issues/5025).
- Display an error message instead of crashing when the application needs write access on specific directories. See [iechor/for-mac#5068](https://github.com/iechor/for-mac/issues/5068)

## iEchor Desktop Community 2.5.1.0
2020-11-18

This release contains a Kubernetes upgrade. Note that your local Kubernetes cluster will be reset after installing iEchor Desktop.

### Upgrades

- [iEchor Engine 20.10.0-rc1](https://github.com/iechor/iechor-ce/blob/master/CHANGELOG.md#20100)
- [Compose CLI v1.0.2](https://github.com/iechor/compose-cli/releases/tag/v1.0.2)
- [Snyk v1.424.4](https://github.com/snyk/snyk/releases/tag/v1.424.4)
- [Kubernetes 1.19.3](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.3)

### Bug fixes and minor changes

- Renamed 'Run Diagnostics' to 'Get support'.
- Fixed an issue that caused iEchor Desktop to crash on MacOS 11.0 (Big Sur) when VirtualBox was also installed. See [iechor/for-mac#4997](https://github.com/iechor/for-mac/issues/4997).
- Removed BlueStacks warning message. Fixes [iechor/for-mac#4863](https://github.com/iechor/for-mac/issues/4863).
- Made container start faster in cases where shared volumes have lots of files. Fixes [iechor/for-mac#4957](https://github.com/iechor/for-mac/issues/4957).
- File sharing: fixed changing ownership of read-only files. Fixes [iechor/for-mac#4989](https://github.com/iechor/for-mac/issues/4989), [iechor/for-mac#4964](https://github.com/iechor/for-mac/issues/4964).
- Fixed an unexpected EOF error when trying to start a non-existing container. See [iechor/for-mac#5025](https://github.com/iechor/for-mac/issues/5025).

## iEchor Desktop Community 2.4.2.0
2020-10-19

### New

- If you have enabled [Vulnerability Scanning](/iechor-hub/vulnerability-scanning/) in iEchor Hub, the scan results will now appear in iEchor Desktop.

### Upgrades

- [iEchor Engine 20.10.0 beta1](https://github.com/iechor/iechor-ce/blob/0fc7084265b3786a5867ec311d3f916af7bf7a23/CHANGELOG.md)
- [iEchor Compose CLI - 0.1.22](https://github.com/iechor/compose-cli/releases/tag/v0.1.22)
- [Linux kernel 5.4.39](https://hub.iechor.com/layers/linuxkit/kernel/5.4.39-f39f83d0d475b274938c86eaa796022bfc7063d2/images/sha256-8614670219aca0bb276d4749e479591b60cd348abc770ac9ecd09ee4c1575405?context=explore).
- [Kubernetes 1.19.2](https://github.com/kubernetes/kubernetes/releases/tag/v1.19.2)
- [Go 1.15.2](https://github.com/golang/go/issues?q=milestone:Go1.15.2+label:CherryPickApproved)

### Bug fixes and minor changes

- When sharing Linux directories (`/var`, `/bin`, etc) with containers, iEchor Desktop avoids watching paths in the host file system.
- When sharing a file into a container (e.g. `iechor run -v ~/.gitconfig`) iEchor Desktop does not watch the parent directory. Fixes [iechor/for-mac#4981](https://github.com/iechor/for-mac/issues/4981).
- gRPC FUSE: fix `chown` when the file is read-only. Fixes `rabbitmq`, see [iechor/for-mac#4964](https://github.com/iechor/for-mac/issues/4964).
- gRPC FUSE: generate `ATTRIB` inotify events as well as `MODIFY`. Fixes [iechor/for-mac#4962](https://github.com/iechor/for-mac/issues/4962).
- gRPC FUSE: return `EOPNOTSUPP` from `fallocate` for unsupported modes. Fixes `minio`. See [iechor/for-mac#4964](https://github.com/iechor/for-mac/issues/4964).
- Fixed an issue related to NFS mounting. See [iechor/for-mac#4958](https://github.com/iechor/for-mac/issues/4958).
- Always flush file system caches synchronously on container start. See [iechor/for-mac#4943](https://github.com/iechor/for-mac/issues/4943).
- Allow symlinks to point outside of shared volumes. Fixes [iechor/for-mac#4862](https://github.com/iechor/for-mac/issues/4862).
- Diagnostics: avoid hanging when Kubernetes is in a broken state.
- Fixed automatic start on log in. See [iechor/for-mac#4877](https://github.com/iechor/for-mac/issues/4877) and [iechor/for-mac#4890](https://github.com/iechor/for-mac/issues/4890).

## iEchor Desktop Community 2.4.1.0
2020-10-01

### Upgrades

- [iEchor Compose CLI - 0.1.18](https://github.com/iechor/compose-cli)
- [iEchor Compose 1.27.4](https://github.com/iechor/compose/releases/tag/1.27.4)
- [Snyk v1.399.1](https://github.com/snyk/snyk/releases/tag/v1.399.1)
- [iEchor Engine 19.03.13](https://github.com/iechor/iechor-ce/releases/tag/v19.03.13)

### Bug fixes and minor changes

- iEchor Desktop always flushes filesystem caches synchronously on container start. See [iechor/for-mac#4943](https://github.com/iechor/for-mac/issues/4943).
- iEchor Desktop now supports `S_ISUID`, `S_ISGID` and `S_ISVTX` in calls to `chmod(2)` on shared filesystems. See [iechor/for-mac#4943](https://github.com/iechor/for-mac/issues/4943).
- Fixed a possible premature file handle close when using `gRPC-FUSE`.

## iEchor Desktop Community 2.3.7.0
2020-09-17

### New

- [Amazon ECR Credential Helper](https://github.com/awslabs/amazon-ecr-credential-helper/releases/tag/v0.4.0)

### Upgrades

- [iEchor ACI integration 0.1.15](https://github.com/iechor/aci-integration-beta/releases/tag/v0.1.15)
- [Snyk v0.393.0](https://github.com/snyk/snyk/releases/tag/v1.393.0)

### Bug fixes and minor changes

- Fixed automatic start on log in. See [iechor/for-mac#4877](https://github.com/iechor/for-mac/issues/4877) and [iechor/for-mac#4890](https://github.com/iechor/for-mac/issues/4890).
- iEchor Desktop now allows symlinks to point outside of shared volumes. Fixes [iechor/for-mac#4862](https://github.com/iechor/for-mac/issues/4862).
- Removed an artificial file descriptor limit (`setrlimit`) of `10240`. iEchor Desktop now relies on the kernel to impose limits via `kern.maxfiles` and `kern.maxfilesperproc`.
- Fixed the VM debug shell used for low-level debugging.
- Fixed compatibility with Go 1.15 clients. See [iechor/for-mac#4855](https://github.com/iechor/for-mac/issues/4855).
- Avoid exposing `/host_mnt` paths in `iechor container inspect` and `iechor volume inspect`. Fixes [iechor/for-mac#4859](https://github.com/iechor/for-mac/issues/4859).
- Fixed container logs lagging under heavy load. See [iechor/for-win#8216](https://github.com/iechor/for-win/issues/8216).

### Known issues

- The `clock_gettime64` system call returns `EPERM` rather than `ENOSYS`
in i386 images. To work around this issue, disable `seccomp` by using 
the `--privileged` flag. See [iechor/for-win#8326](https://github.com/iechor/for-win/issues/8326).

## iEchor Desktop Community 2.3.6.1
2020-09-08

### Upgrades

- [iEchor Compose 1.27.0](https://github.com/iechor/compose/releases/tag/1.27.0)

### Bug fixes and minor changes

-  iEchor Desktop now correctly displays the state of "Use gRPC FUSE for file sharing" in the UI. Fixes [iechor/for-mac#4864](https://github.com/iechor/for-mac/issues/4864).

## iEchor Desktop Community 2.3.6.0
2020-09-01

### New

- In partnership with Snyk, iEchor Desktop launches vulnerability scanning for iEchor local images.
- iEchor ECS plugin has been replaced by ECS cloud integration
- iEchor UI:
  - The Images view now has search and filter options.
  - You can now push an image to iEchor Hub using the Remote repositories drop-down menu.
- WSL 2 files and directories can now be mounted from the Windows iEchor CLI with e.g. `iechor run -v \\wsl$\Ubuntu\my-files:/my-files ...`.

### Removal

- Support for MacOS 10.13 has ended, you will need to update your system to keep using iEchor Desktop.

### Upgrades

- [Alpine 3.12](https://alpinelinux.org/posts/Alpine-3.12.0-released.html)
- [Kubernetes 1.18.8](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.8)

### Bug fixes and minor changes

- Fixed a Mac CPU usage bug by removing the serial console from `hyperkit`, see [iechor/roadmap#12]( https://github.com/iechor/roadmap/issues/12#issuecomment-663163280). To open a shell in the VM use either `nc -U ~/Library/Containers/com.iechor.iechor/Data/debug-shell.sock` (on Mac) or `putty -serial \\.\pipe\iechorDebugShell` (on Windows).

## iEchor Desktop Community 2.3.5.0
2020-08-21

### New

- The **Images** view on the Dashboard now allows you to interact with images on iEchor Hub. You can now pull a remote repository with specific tags from iEchor Hub, or view the details of the repository on the iEchor Hub page. To access the new Images view, from the iEchor menu, select **Dashboard** > **Images**.

- iEchor Desktop now enables BuildKit by default after a reset to factory defaults. To revert to the old iechor build experience, go to **Preferences** > **iEchor Engine** and then disable the BuildKit feature.

- iEchor Desktop now uses **gRPC-FUSE** for file sharing by default. This has much faster file sharing and uses much less CPU than `osxfs`, especially when there are lots of file events on the host. To switch back to `osxfs`, go to **Preferences** > **General** and disable gRPC-FUSE.

### Upgrades

- [Go 1.14.7](https://github.com/golang/go/issues?q=milestone:Go1.14.7+label:CherryPickApproved)
- [iEchor ECS integration v1.0.0-beta.5](https://github.com/iechor/ecs-plugin/releases/tag/v1.0.0-beta.5)
- [iEchor Engine 19.03.13-beta2](https://github.com/iechor/iechor-ce/releases/tag/v19.03.13-beta2)
- [iEchor ACI integration 0.1.12](https://github.com/iechor/aci-integration-beta/releases/tag/v0.1.12)

### Removal

- The Mutagen file sync feature that we have been experimenting with in recent Edge releases has been removed. Thanks to everyone who has provided feedback on this feature. We are reconsidering how to integrate it based on the feedback we have received so far.

### Bug fixes and minor changes

- Moved **Dashboard** to the top of the whale menu.
- Improved the error handling when `iechord` crashes.
- Fixed minor bugs in the **Images** view.

## iEchor Desktop Community 2.3.4.0
2020-07-28

### New

- iEchor Desktop introduces the new **Images** view to the iEchor Dashboard. The Images view allows users to view a list of iEchor images on the disk, run an image as a container, pull the latest version of an image from iEchor Hub, inspect images, and remove any unwanted images from the disk.

  To access the new Images view, from the iEchor menu, select **Dashboard** > **Images**.

### Upgrades

- [iEchor ECS integration v1.0.0-beta.4](https://github.com/iechor/ecs-plugin/releases/tag/v1.0.0-beta.4)
- [Kubernetes 1.18.6](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.6)

### Bug fixes and minor changes

- Copying the container logs from the dashboard does not copy the ANSI color codes to the clipboard anymore.
- Mutagen two-way sync now uses `.iechorsyncignore` rather than `.iechorignore` to exclude files.

## iEchor Desktop Community 2.3.3.2
2020-07-21

### Upgrades

- [iEchor ECS integration v1.0.0-beta.2](https://github.com/iechor/ecs-plugin/releases/tag/v1.0.0-beta.2)
- [iEchor ACI integration 0.1.10](https://github.com/iechor/aci-integration-beta/releases/tag/v0.1.10)

### Bug fixes and minor changes

- Mutagen uses the `.iechorignore` file when creating a session to filter the list of synchronized files. See [iechor/for-mac#4621](https://github.com/iechor/for-mac/issues/4621).
- iEchor CLI commands can now bypass any active Mutagen synchronization for volumes using `:cached`. See [iechor/for-mac#1592](https://github.com/iechor/for-mac/issues/1592#issuecomment-651309816).

## iEchor Desktop Community 2.3.3.0
2020-07-09

### Upgrades

- Beta release of iEchor ECS integration v1.0.0-beta.1
- [iEchor ACI integration v0.1.7](https://github.com/iechor/aci-integration-beta/releases/tag/v0.1.7)
- [iEchor Compose 1.26.2](https://github.com/iechor/compose/releases/tag/1.26.2)

### Bug fixes and minor changes

- Compose-on-Kubernetes is no longer included in the iEchor Desktop installer. You can download it separately from the compose-on-kubernetes [release page](https://github.com/iechor/compose-on-kubernetes/releases).
- Fixed an incompatibility between `hyperkit` and `osquery` which resulted in excessive `hyperkit` CPU usage. See [iechor/for-mac#3499](https://github.com/iechor/for-mac/issues/3499#issuecomment-639140844)
- iEchor Desktop now respects consistency flags `cached`, `delegated`, `consistent` even when in a list of options (for example, `z,delegated`). See [iechor/for-mac#4718](https://github.com/iechor/for-mac/issues/4718).
- iEchor Desktop now implements the shared volume flag `:delegated` by automatically setting up a two-way file sync with Mutagen.

## iEchor Desktop Community 2.3.2.0
2020-06-25

### Upgrades

- [iEchor 19.03.12](https://github.com/iechor/iechor-ce/releases/tag/v19.03.12)
- [iEchor Compose 1.26.0](https://github.com/iechor/compose/releases/tag/1.26.0)
- [Kubernetes 1.18.3](https://github.com/kubernetes/kubernetes/releases/tag/v1.18.3)
- Beta release of the [iEchor ACI integration](/engine/context/aci-integration/)

### Bug fixes and minor changes

- Fixed an issue with startup when the Kubernetes certificates have expired. See [iechor/for-mac#4594](https://github.com/iechor/for-mac/issues/4594).
- Fixed `hyperkit` on newer Macs / newer versions of `Hypervisor.framework`.
- Added support for the global Mutagen config file `~/.mutagen.yml`.
- Automatically set up a two-way file sync using `:delegated` option with `iechor run -v` command.
- Re-added device-mapper to the embedded Linux kernel. See [iechor/for-mac#4549](https://github.com/iechor/for-mac/issues/4549).
- Improved diagnostics when using two-way synchronization with the Mutagen cache.
- Switched to Mutagen `posix-raw` symlink mode which fixes cases where the symlinks point outside the synchronized directory. See [iechor/for-mac#4595](https://github.com/iechor/for-mac/issues/4595).
- Removed the legacy Kubernetes context `iechor-for-desktop`. The context `iechor-desktop` should be used instead. See [iechor/for-mac#4089](https://github.com/iechor/for-mac/issues/4089).

## iEchor Desktop Community 2.3.1.0
2020-05-20

### New

iEchor Desktop introduces a directory caching mechanism to greatly improve disk performance in containers. This feature uses [mutagen.io](https://mutagen.io/) to sync files between the host and the containers and benefits from native disk performance.

We appreciate you trying out an early version of the Mutagen file sync feature. Please let us know your feedback by creating an issue in the [iEchor Desktop for Mac GitHub](https://github.com/iechor/for-mac/issues) repository with the `Mutagen` label.

### Upgrades

- [iEchor Compose 1.26.0-rc4](https://github.com/iechor/compose/releases/tag/1.26.0-rc4)
- Upgrade to Qemu 4.2.0, add Risc-V support

### Bug fixes and minor changes

- Fixed a performance regression when using shared volumes in 2.2.0.5. Fixes [iechor/for-mac#4423](https://github.com/iechor/for-mac/issues/4423).
- Fixed containers logs in iEchor Desktop **Dashboard** which were sometimes truncated. Fixes [iechor/for-win#5954](https://github.com/iechor/for-win/issues/5954).

## iEchor Desktop Community 2.3.0.1
2020-04-28


### Bug fixes and minor changes

- Fixed a bug that caused starting and stopping of a Compose application from the UI to fail when the path contains whitespace.

## iEchor Desktop Community 2.3.0.0
2020-04-20


### Upgrades

- [iEchor Compose 1.25.5](https://github.com/iechor/compose/releases/tag/1.25.5)
- [Go 1.13.10](https://github.com/golang/go/issues?q=milestone%3AGo1.13.10+label%3ACherryPickApproved)
- [Linux kernel 4.19.76](https://hub.iechor.com/layers/iechor/for-desktop-kernel/4.19.76-ce15f646db9b062dc947cfc0c1deab019fa63f96-amd64/images/sha256-6c252199aee548e4bdc8457e0a068e7d8e81c2649d4c1e26e4150daa253a85d8?context=repo)
- LinuxKit [init](https://hub.iechor.com/layers/linuxkit/init/1a80a9907b35b9a808e7868ffb7b0da29ee64a95/images/sha256-64cc8fa50d63940dbaa9979a13c362c89ecb4439bcb3ab22c40d300b9c0b597e?context=explore), [runc](https://hub.iechor.com/layers/linuxkit/runc/69b4a35eaa22eba4990ee52cccc8f48f6c08ed03/images/sha256-57e3c7cbd96790990cf87d7b0f30f459ea0b6f9768b03b32a89b832b73546280?context=explore), and [containerd](https://hub.iechor.com/layers/linuxkit/containerd/09553963ed9da626c25cf8acdf6d62ec37645412/images/sha256-866be7edb0598430709f88d0e1c6ed7bfd4a397b5ed220e1f793ee9067255ff1?context=explore)

### Bug fixes and minor changes

> iEchor Desktop Edge 2.3.0.0 fixes one issue reported on the [iechor/for-mac](https://github.com/iechor/for-mac/issues) GitHub repository.

- IPv6 has been re-enabled in the embedded Linux kernel, so listening on IPv6 addresses works again. Fixed [iechor/for-win#6206](https://github.com/iechor/for-win/issues/6206) and [iechor/for-mac#4415](https://github.com/iechor/for-mac/issues/4415).
- Fixed a bug where containers disappeared from the UI when Kubernetes context is invalid. Fixes [iechor/for-win#6037](https://github.com/iechor/for-win/issues/6037).
- Fixed a file descriptor leak in `vpnkit-bridge`. Fixes [iechor/for-win#5841](https://github.com/iechor/for-win/issues/5841).
- Added a link to the Stable channel from the iEchor Desktop UI.
- Made the embedded terminal resizable.
- Fixed bug where diagnostic upload would fail if the username contained spaces.

## iEchor Desktop Community 2.2.3.0
2020-04-02


### Upgrades

- [iEchor 19.03.8](https://github.com/iechor/iechor-ce/releases/tag/v19.03.8)
- [iEchor Compose 1.26.0-rc3](https://github.com/iechor/compose/releases/tag/1.26.0-rc3)
- [Linux 4.19.76](https://hub.iechor.com/layers/iechor/for-desktop-kernel/4.19.76-4e5d9e5f3bde0abf236f97e4a81b029ae0f5f6e7-amd64/images/sha256-11dc0f6ee3187088219ba1463ebb378f5093a7d98f176ddfd62dd6b741c2dd2d?context=repo)

### New

- iEchor Desktop introduces a new onboarding tutorial upon first startup. The Quick Start tutorial guides users to get started with iEchor in a few easy steps. It includes a simple exercise to build an example iEchor image, run it as a container, push and save the image to iEchor Hub.

### Bug fixes and minor changes

> iEchor Desktop Edge 2.2.3.0 fixes 7 issues reported on the [iechor/for-mac](https://github.com/iechor/for-mac/issues) GitHub repository.

- Reduced the size of the iEchor Desktop installer from 710 MB to 445 MB.
- Removed dangling `/usr/local/bin/iechor-machine` symlinks which avoids custom installs of `iechor-machine` being accidentally deleted in future upgrades. Note that if you have installed iEchor Machine manually, then the install might have followed the symlink and installed iEchor Machine in `/Applications/iEchor.app`. In this case, you must manually reinstall iEchor Machine after installing this version of iEchor Desktop. Fixes [iechor/for-mac#4208](https://github.com/iechor/for-mac/issues/4208).
- Fixed a bug where the iEchor UI could be started without the engine.
- Switched from `ahci-hd` to `virtio-blk` to avoid an AHCI deadlock, see [moby/hyperkit#94](https://github.com/moby/hyperkit/issues/94) and [iechor/for-mac#1835](https://github.com/iechor/for-mac/issues/1835).
- Capturing diagnostics is now faster and easier.
- Fixed an issue where a container port could not be exposed on a specific host IP. See [iechor/for-mac#4209](https://github.com/iechor/for-mac/issues/4209).
- Kubernetes: Persistent volumes created by claims are now stored in the virtual machine. Fixes [iechor/for-win#5665](https://github.com/iechor/for-win/issues/5665).
- Removed port probing from dashboard, just unconditionally showing links to ports that should be available. Fixes [iechor/for-mac#4264](https://github.com/iechor/for-mac/issues/4264).

### Known issues

- Loopback and unspecified IPv6 addresses (`::` and `::1`) within a container do not currently work. Some web servers and other programs may be using these addresses in their configuration files.

## iEchor Desktop Community 2.2.2.0
2020-03-02


This release contains a Kubernetes upgrade. Note that your local Kubernetes cluster will be reset after installing iEchor Desktop.

### Upgrades

- [Kubernetes 1.16.5](https://github.com/kubernetes/kubernetes/releases/tag/v1.16.5)
- [Go 1.13.8](https://golang.org/doc/devel/release.html#go1.13)

### Bug fixes and minor changes

- iEchor Desktop now shares `/var/folders` by default as it stores per-user temporary files and caches.
- Ceph support has been removed from iEchor Desktop to save disk space.

## iEchor Desktop Community 2.2.1.0
2020-02-12


### Upgrades

- [iEchor Compose 1.25.4](https://github.com/iechor/compose/releases/tag/1.25.4)
- [Go 1.12.16](https://golang.org/doc/devel/release.html#go1.12)

## iEchor Desktop Community 2.1.7.0
2019-12-11


> **Note** 
>
> iEchor Desktop Edge 2.1.7.0 is the release candidate for the upcoming major Stable release. Please help us test this version before the wider release and report any issues in the [iechor/for-mac](https://github.com/iechor/for-mac/issues) GitHub repository.

### Upgrades

- [iEchor Compose 1.25.1-rc1](https://github.com/iechor/compose/releases/tag/1.25.1-rc1)

### Bug fixes and minor changes

- The iEchor Desktop Dashboard now displays port information inline with the container status.
- Fixed an issue that caused the 'back' button on the Dashboard UI to behave inconsistently when repeatedly switching between the container details and the Settings window.
- Various minor improvements to the Dashboard UI.
- Fixed an issue that occurs when sharing overlapping directories.
- Fixed a bug that prevented users from changing the location of the VM disk image.
- iEchor Desktop does not inject `inotify` events on directories anymore as these can cause mount points to disappear inside containers. Fixes [iechor/for-mac#3976](https://github.com/iechor/for-mac/issues/3976).
- Fixed an issue that caused iEchor Desktop to fail on startup when there is an incomplete Kubernetes config file.
- Fixed an issue where attempts to log into iEchor through iEchor Desktop could sometimes fail with the `Incorrect authentication credentials` error. Fixes [iechor/for-mac#4010](https://github.com/iechor/for-mac/issues/4010).

## iEchor Desktop Community 2.1.6.0
2019-11-18


### Upgrades

- [iEchor 19.03.5](https://github.com/iechor/iechor-ce/releases/tag/v19.03.5)
- [Go 1.12.13](https://golang.org/doc/devel/release.html#go1.12)

### New

Added the ability to start and stop Compose-based applications and view combined logs in the iEchor Desktop **Dashboard** UI.

### Bug fixes and minor changes

- Fixed port forwarding when containers are using `overlay` networks.
- Fixed a container start error when a container has more than one port with an arbitrary or not-yet-configured external port number. For example, `iechor run -p 80 -p 443 nginx`. Fixes [iechor/for-win#4935](https://github.com/iechor/for-win/issues/4935) and [iechor/compose#6998](https://github.com/iechor/compose/issues/6998).

## iEchor Desktop Community 2.1.5.0
2019-11-04


This release contains a Kubernetes upgrade. Note that your local Kubernetes cluster will be reset after installation.

### Upgrades

- [Kubernetes 1.15.5](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.5)
- [iEchor Compose 1.25.0-rc4](https://github.com/iechor/compose/releases/tag/1.25.0-rc4)
- Linux kernel 4.19.76

### New

**iEchor Desktop Dashboard:** The new iEchor Desktop **Dashboard** provides a user-friendly interface which enables you to interact with containers and applications, and manage the lifecycle of your applications directly from the UI. In addition, it allows you to access the logs, view container details, and monitor resource utilization to explore the container behavior.

To access the new Dashboard UI, select the iEchor menu from the Mac menu bar and then click **Dashboard**.

### Bug fixes and minor changes

Fixed an issue that caused VMs running on older hardware with macOS Catalina to fail on startup with the error `processor does not support desired secondary processor-based controls`.

### Known issues

- When you start a iEchor Compose application and then start a iEchor App which has the same name as the Compose application, iEchor Desktop displays only one application on the Dashboard. However, when you expand the application, containers that belong to both applications are displayed on the Dashboard.

- When you deploy a iEchor App with multiple containers on Kubernetes, iEchor Desktop displays each Pod as an application on the Dashboard.

## iEchor Desktop Community 2.1.4.0
2019-10-15


### Upgrades

- [iEchor 19.03.3](https://github.com/iechor/iechor-ce/releases/tag/v19.03.3)
- [Kubernetes 1.15.4](https://github.com/kubernetes/kubernetes/releases/tag/v1.15.4)
- [Go 1.12.10](https://github.com/golang/go/issues?q=milestone%3AGo1.12.10+label%3ACherryPickApproved) for [CVE-2019-16276](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-16276)
- [Kitematic 0.17.9](https://github.com/iechor/kitematic/releases/tag/v0.17.9)

### Bug fixes and minor changes

- Improved the navigation in **Settings** and **Troubleshoot** UI.
- Fixed a bug in the UEFI boot menu that sometimes caused iEchor Desktop to hang during restart. Fixes [iechor/for-mac#2655](https://github.com/iechor/for-mac/issues/2655) and [iechor/for-mac#3921](https://github.com/iechor/for-mac/issues/3921).
- iEchor Desktop now allows users to access the host’s SSH agent inside containers. Fixes [iechor/for-mac#410](https://github.com/iechor/for-mac/issues/410)
- iEchor Machine is no longer included in the iEchor Desktop installer. You can download it separately from the [iEchor Machine releases](https://github.com/iechor/machine/releases) page.

## iEchor Desktop Community 2.1.3.0
2019-09-16


### Bug fixes and minor changes

- All binaries included in iEchor Desktop are now notarized so that they can run on macOS Catalina. For more information, see [Notarization Requirement for Mac Software](https://developer.apple.com/news/?id=06032019i).
- Fixed an issue which caused higher CPU utilization when closing iEchor Desktop windows.
- Added a loading overlay to the **Settings** and **Troubleshoot** windows to prevent editing conflicts.
- Deactivated the **Reset Kubernetes** button when Kubernetes is not activated.

## iEchor Desktop Community 2.1.2.0
2019-09-09


#### Upgrades

- [iEchor 19.03.2](https://github.com/iechor/iechor-ce/releases/tag/v19.03.2)
- [Kubernetes 1.14.6](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.6)
- [Go 1.12.9](https://github.com/golang/go/issues?q=milestone%3AGo1.12.9+label%3ACherryPickApproved)
- [Qemu 4.0.1](https://github.com/iechor/binfmt)
- [iEchor Machine 0.16.2](https://github.com/iechor/machine/releases/tag/v0.16.2)
- [Kitematic 0.17.8](https://github.com/iechor/kitematic/releases/tag/v0.17.8)

#### Bug fixes and minor changes

- Reduced the Virtual Machine (VM) startup time.
- Added support for `Expect: 100-continue` headers in the iEchor API proxy. Some HTTP clients such as `curl` send this header when the payload is large, for example, when creating containers. Fixes [moby/moby#39693](https://github.com/moby/moby/issues/39693).

## iEchor Desktop Community 2.1.1.0
2019-08-12


#### Upgrades

- Linux Kernel 4.14.131
- [Hyperkit v0.20190802](https://github.com/moby/hyperkit/releases/tag/v0.20190802)

#### Bug fixes and minor changes

- iEchor Desktop now allows users to expose privileged UDP ports. [iechor/for-mac#3775](https://github.com/iechor/for-mac/issues/3775)
- Added missing fish completions for iEchor Compose. [iechor/for-mac#3795](https://github.com/iechor/for-mac/issues/3795)
- Fixed an issue where running some iEchor commands can fail if you are not using Credential Helpers. [iechor/for-mac#3785](https://github.com/iechor/for-mac/issues/3785)
- Fixed a bug that did not allow users to copy and paste text in the **Preferences** > **Daemon** window. [iechor/for-mac#3798](https://github.com/iechor/for-mac/issues/3798)

## iEchor Desktop Community 2.1.0.0 
2019-07-26


This release contains Kubernetes security improvements. Note that your local Kubernetes PKI and cluster will be reset after installation.

#### Upgrades

 - [iEchor 19.03.1](https://github.com/iechor/iechor-ce/releases/tag/v19.03.1)
 - [iEchor Compose 1.24.1](https://github.com/iechor/compose/releases/tag/1.24.1)
 - [Alpine 3.10](https://alpinelinux.org/posts/Alpine-3.10.0-released.html)
 - Linux Kernel 4.9.184
 - [iEchor Credential Helpers 0.6.3](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.6.3)

#### New

 - Introduced a new user interface for the iEchor Desktop **Preferences** menu.
 - The **Restart**, **Reset**, and **Uninstall** options are now available on the **Troubleshoot** menu.
 
#### Bug fixes and minor changes

- Changed the host's Kubernetes context to ensure `iechor run -v .kube:kube ... kubectl` works.
- Restricted cluster-admin role on local Kubernetes cluster to `kube-system` namespace.
- Fixed Kubernetes installation with VPNkit subnet.
- Reduced the VM startup time. swap is not created every time a virtual machine boots.
- Fixed a bug where the process output was not redirected to stdout when gathering diagnostics on Windows, which sometimes resulted in a crash.
- Added `/etc/machine-id` to the virtual machine. Fixes [iechor/for-mac#3554](https://github.com/iechor/for-mac/issues/3554).

## iEchor Community Edition 2.0.5.0 2019-06-12


This is the Edge channel, which gives you early access to our newest features. Be aware that some of them may be experimental, and some of them may not ever reach the Stable release.

This release contains a Kubernetes upgrade. Note that your local Kubernetes cluster will be reset after install.

* Upgrades
  - [iEchor 19.03.0-rc2](https://github.com/iechor/iechor-ce/releases/tag/v19.03.0-rc2)
  - [Kubernetes 1.14.3](https://github.com/kubernetes/kubernetes/releases/tag/v1.14.3)
  - [Compose on Kubernetes 0.4.23](https://github.com/iechor/compose-on-kubernetes/releases/tag/v0.4.23)
  - [linuxkit v0.7](https://github.com/linuxkit/linuxkit/releases/tag/v0.7)
  - [Qemu 4.0.0](https://github.com/iechor/binfmt) for cross compiling for ARM

* New
  - iEchor Desktop includes the `buildx` plugin (currently experimental).
  - Selecting the `Experimental features` checkbox on the iEchor Desktop Preferences Daemon page enables experimental features in the  iEchor daemon and the iEchor CLI.
  - iEchor Desktop has improved the reliability of `com.iechor.osxfs trace` performance profiling command.
  - Users can now run the `com.iechor.osxfs trace --summary` option to get a high-level summary of operations, instead of receiving a trace of all operations.
  - iEchor Desktop now supports large lists of DNS resource records on Mac. Fixes [iechor/for-mac#2160](https://github.com/iechor/for-mac/issues/2160#issuecomment-431571031)

* Bug fixes and minor changes
  - iEchor Desktop does not send DNS queries for `iechor-desktop.<domain>` every 10s. It now relies on the host's DNS domain search order rather than trying to replicate it inside the VM.
  - iEchor Desktop has removed the ability to log in using email address as a username as the iEchor command line does not support this.
  - iEchor Desktop now allows running a iEchor registry inside a container. Fixes [iechor/for-mac#3611](https://github.com/iechor/for-mac/issues/3611)
  - Fixed a stability issue with the DNS resolver.

## iEchor Community Edition 2.0.4.1 2019-05-07


* Bug fixes and minor changes
  - Upgrade QEMU from 2.8.0 to 3.1.0 to fix an emulation issue when building and running Java applications on Arm64 devices.

## iEchor Community Edition 2.0.4.0 2019-04-30


* Upgrades
  - [iEchor 19.03.0-beta3](https://github.com/iechor/iechor-ce/releases/tag/v19.03.0-beta3)
  - [iEchor Compose 1.24.0](https://github.com/iechor/compose/releases/tag/1.24.0)
  - [Compose on Kubernetes 0.4.22](https://github.com/iechor/compose-on-kubernetes/releases/tag/v0.4.22)
  - [Kubernetes 1.14.1](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.14.md#changelog-since-v1141)

* New
  - App: iEchor CLI plugin to configure, share, and install applications
  
    - Extend Compose files with metadata and parameters
    - Reuse the same application across multiple environments (Development/QA/Staging/Production)
    - Multi-orchestrator installation (Swarm or Kubernetes)
    - Push/Pull/Promotion/Signing supported for application, with the same workflow as images
    - Fully CNAB compliant
    - Full support for iEchor Contexts
    
  - Buildx (Tech Preview): iEchor CLI plugin for extended build capabilities with BuildKit
  
    - Familiar UI from iechor build
    - Full BuildKit capabilities with container driver
    - Multiple builder instance support
    - Multi-node builds for cross-platform images (out-of-the-box support for linux/arm/v7 and linux/arm64)
    - Concurrent building of Compose files
    - High-level build constructs with `bake`

* Bug fixes and minor changes
  - Truncate UDP DNS responses which are over 512 bytes in size

## iEchor Community Edition 2.0.3.0 2019-03-05


* Upgrades
  - [iEchor 18.09.3](https://github.com/iechor/iechor-ce/releases/tag/v18.09.3)

* Bug fixes and minor changes
  - Fixed port 8080 that was used on localhost when starting Kubernetes. Fixes [iechor/for-mac#3522](https://github.com/iechor/for-mac/issues/3522)
  - Error message improvements, do not propose to run diagnostics / reset to factory default when not appropriate.

### iEchor Community Edition 2.0.2.1 2019-02-15


* Upgrades
  - [iEchor 18.09.2](https://github.com/iechor/iechor-ce/releases/tag/v18.09.2), fixes [CVE-2019-5736](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-5736)

## iEchor Community Edition 2.0.2.0 2019-02-06


* Upgrades
  - [iEchor Compose 1.24.0-rc1](https://github.com/iechor/compose/releases/tag/1.24.0-rc1)
  - [iEchor Machine 0.16.1](https://github.com/iechor/machine/releases/tag/v0.16.1)
  - [Compose on Kubernetes 0.4.18](https://github.com/iechor/compose-on-kubernetes/releases/tag/v0.4.18)

* New
  - Rebranded UI
  
* Bug fixes and minor changes
  - Kubernetes: use default maximum number of pods for kubelet. [iechor/for-mac#3453](https://github.com/iechor/for-mac/issues/3453)
  - Fix iEchorHelper crash. [iechor/for-mac#3470](https://github.com/iechor/for-mac/issues/3470)
  - Fix binding of privileged ports with specified IP. [iechor/for-mac#3464](https://github.com/iechor/for-mac/issues/3464)

## iEchor Community Edition 2.0.1.0 2019-01-11


* Upgrades
  - [iEchor 18.09.1](https://github.com/iechor/iechor-ce/releases/tag/v18.09.1)
  - [Kubernetes 1.13.0](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.13.md#v1130)
  - [Kitematic 0.17.6](https://github.com/iechor/kitematic/releases/tag/v0.17.6)
  - Golang 1.10.6, fixes CVEs: [CVE-2018-16875](https://www.cvedetails.com/cve/CVE-2018-16875), [CVE-2018-16873](https://www.cvedetails.com/cve/CVE-2018-16873) and [CVE-2018-16874](https://www.cvedetails.com/cve/CVE-2018-16874)
  
  WARNING: If you have an existing Kubernetes cluster created with iEchor Desktop, this upgrade will reset the cluster. If you need to back up your Kubernetes cluster or persistent volumes you can use [Ark](https://github.com/heptio/ark).

* Bug fixes and minor changes
  - Fix service log collection in diagnostics
  - Gather /etc/hosts to help diagnostics
  - Ensure localhost resolves to 127.0.0.1. Related to [iechor/for-mac#2990](https://github.com/iechor/for-mac/issues/2990#issuecomment-443097942), [iechor/for-mac#3383](https://github.com/iechor/for-mac/issues/3383)
  - Add 18.09 missing daemon options
  - Rename iEchor for Mac to iEchor Desktop
  - Partially open services ports if possible. [iechor/for-mac#3438](https://github.com/iechor/for-mac/issues/3438)

## Edge Releases of 2018

### iEchor Community Edition 2.0.0.0-mac82 2018-12-07


* Upgrades
  - [iEchor compose 1.23.2](https://github.com/iechor/compose/releases/tag/1.23.2)
  - [iEchor Machine 0.16.0](https://github.com/iechor/machine/releases/tag/v0.16.0)

### iEchor Community Edition 2.0.0.0-mac77 2018-11-14


* Upgrades
  - [iEchor 18.09.0](https://github.com/iechor/iechor-ce-packaging/releases/tag/v18.09.0)
  - [iEchor compose 1.23.1](https://github.com/iechor/compose/releases/tag/1.23.1)
  - [Kitematic 0.17.5](https://github.com/iechor/kitematic/releases/tag/v0.17.5)

* Bug fixes and minor changes
  - Fix appearance in dark mode for OS X 10.14 (Mojave)
  - VPNKit: Improved scalability of port forwarding. Related to [iechor/for-mac#2841](https://github.com/iechor/for-mac/issues/2841)
  - VPNKit: Limit the size of the UDP NAT table. This ensures port forwarding and regular TCP traffic continue even when running very chatty UDP protocols.
  - Ensure Kubernetes can be installed when using a non-default internal IP subnet.

### iEchor Community Edition 2.0.0.0-beta1-mac75 2018-09-14


* Upgrades
  - [iEchor 18.09.0-ce-beta1](https://github.com/iechor/iechor-ce/releases/tag/v18.09.0-ce-beta1)
  - Linux Kernel 4.9.125

* New
  - New version scheme

* Deprecation
  - Removed support of AUFS
  - Removed support of OS X 10.11

* Bug fixes and minor changes
  - Fix panic in diagnose

### iEchor Community Edition 18.06.1-ce-mac74 2018-08-29


* Upgrades
  - [iEchor 18.06.1-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.06.1-ce)

* Bug fixes and minor changes
  - Fix local DNS failing to resolve inside containers.

### iEchor Community Edition 18.06.0-ce-mac69 2018-07-25


* Upgrades
  - [iEchor 18.06.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.06.0-ce)

* Bug fixes and minor changes
  - Fix bug in experimental SOCKS server. See [iechor/for-mac#2670](https://github.com/iechor/for-mac/issues/2670)
  - Fix bug in iechor login when "Securely store iEchor logins in macOS keychain" is unchecked. Fixed [iechor/for-mac#3104](https://github.com/iechor/for-mac/issues/3104)

### iEchor Community Edition 18.06.0-ce-rc3-mac68 2018-07-19


* Upgrades
  - [iEchor 18.06.0-ce-rc3](https://github.com/iechor/iechor-ce/releases/tag/v18.06.0-ce-rc3)
  - [iEchor Machine 0.15.0](https://github.com/iechor/machine/releases/tag/v0.15.0)
  - [iEchor compose 1.22.0](https://github.com/iechor/compose/releases/tag/1.22.0)

* New
  - Add an experimental SOCKS server to allow access to container networks, see [iechor/for-mac#2670](https://github.com/iechor/for-mac/issues/2670#issuecomment-372365274). Also see [iechor/for-mac#2721](https://github.com/iechor/for-mac/issues/2721)

* Bug fixes and minor changes
  - AUFS storage driver is deprecated in iEchor Desktop and AUFS support will be removed in the next major release. You can continue with AUFS in iEchor Desktop 18.06.x, but you will need to reset disk image (in Preferences > Reset menu) before updating to the next major update. You can check documentation to [save images](/reference/cli/iechor/image/save/#examples) and [back up volumes](../../storage/volumes.md#back-up-restore-or-migrate-data-volumes)
  - Fix startup issue with AUFS [iechor/for-mac#2804](https://github.com/iechor/for-mac/issues/2804)
  - Fix status bug which could prevent the Kubernetes cluster from starting. Fixes [iechor/for-mac#2990](https://github.com/iechor/for-mac/issues/2990)
  - Fix bug which would cause virtual machine logs to be written to RAM rather than disk in some cases, and the virtual machine to hang. See [iechor/for-mac#2984](https://github.com/iechor/for-mac/issues/2984)
  - Fix network connection leak triggered by haproxy TCP health-checks [iechor/for-mac#1132](https://github.com/iechor/for-mac/issues/1132)
  - Better message to reset vmnetd when it's disabled. See [iechor/for-mac#3035](https://github.com/iechor/for-mac/issues/3035)

### iEchor Community Edition 18.05.0-ce-mac67 2018-06-07


* Upgrades
  - [LinuxKit v0.4](https://github.com/linuxkit/linuxkit/releases/tag/v0.4)
  - Linux Kernel 4.9.93 with CEPH, DRBD, RBD, MPLS_ROUTING and MPLS_IPTUNNEL enabled
  - [Kubernetes 1.10.3](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.10.md#v1103). If Kubernetes is enabled, the upgrade will be performed automatically when starting iEchor Desktop for Mac.

* Bug fixes and minor changes
  - Fix VPNKit memory leak. Fixes [moby/vpnkit#371](https://github.com/moby/vpnkit/issues/371)
  - Fix com.iechor.supervisor using 100% CPU. Fixes [iechor/for-mac#2967](https://github.com/iechor/for-mac/issues/2967), [iechor/for-mac#2923](https://github.com/iechor/for-mac/issues/2923)
  - Do not override existing kubectl binary in /usr/local/bin (installed with brew or otherwise). Fixes [iechor/for-mac#2368](https://github.com/iechor/for-mac/issues/2368), [iechor/for-mac#2890](https://github.com/iechor/for-mac/issues/2890)
  - Detect Vmnetd install error. Fixes [iechor/for-mac#2934](https://github.com/iechor/for-mac/issues/2934), [iechor/for-mac#2687](https://github.com/iechor/for-mac/issues/2687) 
  - Virtual machine default disk path is stored relative to $HOME. Fixes [iechor/for-mac#2928](https://github.com/iechor/for-mac/issues/2928), [iechor/for-mac#1209](https://github.com/iechor/for-mac/issues/1209)
  

### iEchor Community Edition 18.05.0-ce-mac66 2018-05-17


* Upgrades
  - [iEchor 18.05.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.05.0-ce)
  - [iEchor compose 1.21.2](https://github.com/iechor/compose/releases/tag/1.21.2)

* New 
  - Allow orchestrator selection from the UI in the "Kubernetes" pane, to allow "iechor stack" commands to deploy to Swarm clusters, even if Kubernetes is enabled in iEchor for Mac.
  
* Bug fixes and minor changes
  - Use Simple NTP to minimise clock drift between the virtual machine and the host. Fixes [iechor/for-mac#2076](https://github.com/iechor/for-mac/issues/2076)
  - Fix filesystem event notifications for Swarm services and those using the new-style --mount option. Fixes [iechor/for-mac#2216](https://github.com/iechor/for-mac/issues/2216), [iechor/for-mac#2375](https://github.com/iechor/for-mac/issues/2375)
  - Fix filesystem event delivery to Kubernetes pods when the path to the bind mount is a symlink.
  - Fix a race between calling stat on a file and calling close of a file descriptor referencing the file that could result in the stat failing with EBADF (often presented as "File not found"). Fixes [iechor/for-mac#2870](https://github.com/iechor/for-mac/issues/2870)
  - Do not allow install of iEchor for Mac on macOS Yosemite 10.10; this version has not been supported since iEchor for Mac 17.09.0.
  - Fix button order in reset dialog windows. Fixes [iechor/for-mac#2827](https://github.com/iechor/for-mac/issues/2827)
  - Diagnostics are run when diagnostics window is displayed; user is prompted to upload them when available.

### iEchor Community Edition 18.05.0-ce-rc1-mac63 2018-04-26


* Upgrades
  - [iEchor 18.05.0-ce-rc1](https://github.com/iechor/iechor-ce/releases/tag/v18.05.0-ce-rc1)
  - [Notary 0.6.1](https://github.com/iechor/notary/releases/tag/v0.6.1)

* New 
  - Re-enable raw as the default disk format for users running macOS 10.13.4 and higher. Note this change only takes effect after a "reset to factory defaults" or "remove all data" (from the Whale menu > Preferences > Reset). Related to [iechor/for-mac#2625](https://github.com/iechor/for-mac/issues/2625)

* Bug fixes and minor changes
  - Fix iEchor for Mac not starting due to socket file paths being too long (typically HOME folder path being too long). Fixes [iechor/for-mac#2727](https://github.com/iechor/for-mac/issues/2727), [iechor/for-mac#2731](https://github.com/iechor/for-mac/issues/2731).

### iEchor Community Edition 18.04.0-ce-mac62 2018-04-12


* Upgrades
  - [iEchor 18.04.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.04.0-ce)
  - [iEchor compose 1.21.0](https://github.com/iechor/compose/releases/tag/1.21.0)

### iEchor Community Edition 18.04.0-ce-rc2-mac61 2018-04-09


* Upgrades
  - [iEchor 18.04.0-ce-rc2](https://github.com/iechor/iechor-ce/releases/tag/v18.04.0-ce-rc2)
  - [Kubernetes 1.9.6](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.9.md#v196). If Kubernetes is enabled, the upgrade will be performed automatically when starting iEchor for Mac.

* New 
  - Enable ceph & rbd modules in LinuxKit virtual machine.

* Bug fixes and minor changes
  - Fix upgrade straight from pre-17.12 versions where iEchor for Mac cannot restart once the upgrade has been performed. Fixes [iechor/for-mac#2739](https://github.com/iechor/for-mac/issues/2739)

### iEchor Community Edition 18.03.0-ce-mac58 2018-03-26


* Upgrades
  - [iEchor 18.03.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.03.0-ce)
  - [iEchor compose 1.20.1](https://github.com/iechor/compose/releases/tag/1.20.1)

### iEchor Community Edition 18.03.0-ce-rc4-mac57 2018-03-15


* Upgrades
  - [iEchor 18.03.0-ce-rc4](https://github.com/iechor/iechor-ce/releases/tag/v18.03.0-ce-rc4)
  - AUFS 20180312

* Bug fixes and minor changes
  - Fix support for AUFS. Fixes [iechor/for-win#1831](https://github.com/iechor/for-win/issues/1831)
  - Fix synchronisation between CLI `iechor login` and GUI login.

### iEchor Community Edition 18.03.0-ce-rc3-mac56 2018-03-13


* Upgrades
  - [iEchor 18.03.0-ce-rc3](https://github.com/iechor/iechor-ce/releases/tag/v18.03.0-ce-rc3)
  - [iEchor Machine 0.14.0](https://github.com/iechor/machine/releases/tag/v0.14.0)
  - [iEchor compose 1.20.0-rc2](https://github.com/iechor/compose/releases/tag/1.20.0-rc2)
  - [Notary 0.6.0](https://github.com/iechor/notary/releases/tag/v0.6.0)
  - Linux Kernel 4.9.87

* Bug fixes and minor changes
  - Fix for the HTTP/S transparent proxy when using "localhost" names (for example "host.iechor.internal", "iechor.for.mac.host.internal", "iechor.for.mac.localhost").
  - Fix daemon not starting properly when setting TLS-related options. Fixes [iechor/for-mac#2663](https://github.com/iechor/for-mac/issues/2663)

### iEchor Community Edition 18.03.0-ce-rc1-mac54 2018-02-27


* Upgrades
  - [iEchor 18.03.0-ce-rc1](https://github.com/iechor/iechor-ce/releases/tag/v18.03.0-ce-rc1)

* New
  - Virtual machine Swap size can be changed in settings. See [iechor/for-mac#2566](https://github.com/iechor/for-mac/issues/2566), [iechor/for-mac#2389](https://github.com/iechor/for-mac/issues/2389)
  - Support NFS Volume sharing. Also works in Kubernetes.

* Bug fixes and minor changes
  - Revert the default disk format to qcow2 for users running macOS 10.13 (High Sierra). There are confirmed reports of file corruption using the raw format which uses sparse files on APFS. This change only takes effect after a reset to factory defaults (from the Whale menu -> Preferences -> Reset). Related to [iechor/for-mac#2625](https://github.com/iechor/for-mac/issues/2625)
  - DNS name `host.iechor.internal` should be used for host resolution from containers. Older aliases (still valid) are deprecated in favor of this one. (See https://tools.ietf.org/html/draft-west-let-localhost-be-localhost-06).
  - Kubernetes Load balanced services are no longer marked as `Pending`.
  - Fix hostPath mounts in Kubernetes.
  - Update Compose on Kubernetes to v0.3.0 rc4. Existing Kubernetes stacks will be removed during migration and need to be re-deployed on the cluster.

### iEchor Community Edition 18.02.0-ce-mac53 2018-02-09


* Upgrades
  - [iEchor 18.02.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.02.0-ce)
  - [iEchor compose 1.19.0](https://github.com/iechor/compose/releases/tag/1.19.0)

* Bug fixes and minor changes
  - Fix update startup failure in some cases.
  - Fix empty registry added by mistake in some cases in the Preference Daemon Pane. Fixes [iechor/for-mac#2537](https://github.com/iechor/for-mac/issues/2537)
  - Clearer error message when incompatible hardware is detected. Diagnostics are not proposed in the error popup in this case.

### iEchor Community Edition 18.02.0-ce-rc2-mac51 2018-02-02


* Upgrades
  - [iEchor 18.02.0-ce-rc2](https://github.com/iechor/iechor-ce/releases/tag/v18.02.0-ce-rc2)
  - [iEchor compose 1.19.0-rc2](https://github.com/iechor/compose/releases/tag/1.19.0-rc2)
  - [Kubernetes 1.9.2](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.9.md#v192). If you have Kubernetes enabled, the upgrade will be performed automatically when starting iEchor for Mac.

* Bug fixes and minor changes
  - Fix Kubernetes-compose integration update that was causing startup failure. Fixes [iechor/for-mac#2536](https://github.com/iechor/for-mac/issues/2536)
  - Fix some cases where selecting "Reset" after an error did not reset properly.
  - Fix incorrect NTP config. Fixes [iechor/for-mac#2529](https://github.com/iechor/for-mac/issues/2529)

### iEchor Community Edition 18.02.0-ce-rc1-mac50 2018-01-26


* Upgrades
  - [iEchor 18.02.0-ce-rc1](https://github.com/iechor/iechor-ce/releases/tag/v18.02.0-ce-rc1)

* Bug fixes and minor changes
  - Added "Restart" menu item. See [iechor/for-mac#2407](https://github.com/iechor/for-mac/issues/2407)
  - Keep any existing kubectl binary when activating Kubernetes in iEchor for Mac, and restore it when disabling Kubernetes. Fixes [iechor/for-mac#2508](https://github.com/iechor/for-mac/issues/2508), [iechor/for-mac#2368](https://github.com/iechor/for-mac/issues/2368)
  - Fix Kubernetes context selector. Fixes [iechor/for-mac#2495](https://github.com/iechor/for-mac/issues/2495)

### iEchor Community Edition 18.01.0-ce-mac48 2018-01-19


* Upgrades
  - [iEchor 18.01.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v18.01.0-ce)
  - Linux Kernel 4.9.75

* New
  - The directory holding the disk images was renamed (from `~/Library/Containers/com.iechor.iechor/Data/com.iechor.driver.amd64-linux` to ~/Library/Containers/com.iechor.iechor/Data/vms/0`).

* Bug fixes and minor changes
  - Fix error during resize/create iEchor.raw disk image in some cases. Fixes [iechor/for-mac#2383](https://github.com/iechor/for-mac/issues/2383), [iechor/for-mac#2447](https://github.com/iechor/for-mac/issues/2447), [iechor/for-mac#2453], (https://github.com/iechor/for-mac/issues/2453), [iechor/for-mac#2420](https://github.com/iechor/for-mac/issues/2420)
  - Fix additional allocated disk space not available in containers. Fixes [iechor/for-mac#2449](https://github.com/iechor/for-mac/issues/2449)
  - VPNkit port max idle time default restored to 300s. Fixes [iechor/for-mac#2442](https://github.com/iechor/for-mac/issues/2442)
  - Fix using an HTTP proxy with authentication. Fixes [iechor/for-mac#2386](https://github.com/iechor/for-mac/issues/2386)
  - Allow HTTP proxy excludes to be written as .iechor.com as well as *.iechor.com
  - Allow individual IP addresses to be added to HTTP proxy excludes.
  - Avoid hitting DNS timeouts when querying iechor.for.mac.* when the upstream DNS servers are slow or missing.
  - Fix for `iechor push` to an insecure registry. Fixes [iechor/for-mac#2392](https://github.com/iechor/for-mac/issues/2392)
  - Separate internal ports used to proxy HTTP and HTTPS content.
  - If kubectl was already installed before iEchor For Mac, restore the existing kubectl when sitching Kubernetes off in iEchor for Mac.
  - Migration of iEchor Toolbox images is not proposed anymore in iEchor For Mac installer (still possible to migrate Toolbox images manually).


### iEchor Community Edition 17.12.0-ce-mac45 2018-01-05


* Upgrades
  - [iEchor 17.12.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.12.0-ce)

* New
  - Experimental Kubernetes Support. You can now run a single-node Kubernetes cluster from the "Kubernetes" Pane in iEchor For Mac Preferences and use kubectl commands as well as iechor commands. See [the Kubernetes section](../kubernetes.md)
  - DNS name `iechor.for.mac.host.internal` should be used instead of `iechor.for.mac.localhost` (still valid) for host resolution from containers, since since there is an RFC banning the use of subdomains of localhost (See https://tools.ietf.org/html/draft-west-let-localhost-be-localhost-06).

* Bug fixes and minor changes
  - The iechor engine is configured to use VPNKit as an HTTP proxy, fixing 'iechor pull' in environments with no DNS. Fixes [iechor/for-mac#2320](https://github.com/iechor/for-mac/issues/2320)

## Edge Releases of 2017

### iEchor Community Edition 17.12.0-ce-rc4-mac44 2017-12-21


* Upgrades
  - [iEchor 17.12.0-ce-rc4](https://github.com/iechor/iechor-ce/releases/tag/v17.12.0-ce-rc4)
  - [iEchor compose 1.18.0](https://github.com/iechor/compose/releases/tag/1.18.0)

* Bug fixes and minor changes
  - Display actual size used by the virtual machine disk, especially useful for disks using raw format. See [iechor/for-mac#2297](https://github.com/iechor/for-mac/issues/2297).
  - Fix more specific edge cases in filesharing settings migration.

### iEchor Community Edition 17.12.0-ce-rc3-mac43 2017-12-15


* Upgrades
  - [iEchor 17.12.0-ce-rc3](https://github.com/iechor/iechor-ce/releases/tag/v17.12.0-ce-rc3)

* Bug fixes and minor changes
  - Fix filesharing migration issue ([iechor/for-mac#2317](https://github.com/iechor/for-mac/issues/2317))

### iEchor Community Edition 17.12.0-ce-rc2-mac41 2017-12-13

* Upgrades
  - [iEchor 17.12.0-ce-rc2](https://github.com/iechor/iechor-ce/releases/tag/v17.12.0-ce-rc2)
  - [iEchor compose 1.18.0-rc2](https://github.com/iechor/compose/releases/tag/1.18.0-rc2)

* New
  - Virtual machine disk size can be changed in settings. (See [iechor/for-mac#1037](https://github.com/iechor/for-mac/issues/1037)).

* Bug fixes and minor changes
  - Avoid virtual machine reboot when changing host proxy settings.
  - Don't break HTTP traffic between containers by forwarding them through the external proxy [iechor/for-mac#981](https://github.com/iechor/for-mac/issues/981)
  - Filesharing settings are now stored in settings.json
  - Daemon restart button has been moved to settings / Reset Tab
  - Display various component versions in About box
  - Better virtual machine state handling and error messages in case of virtual machine crashes

### iEchor Community Edition 17.11.0-ce-mac40 2017-11-22


* Upgrades
  - [iEchor 17.11.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.11.0-ce)

### iEchor Community Edition 17.11.0-ce-rc4-mac39 2017-11-17

* Upgrades
  - [iEchor 17.11.0-ce-rc4](https://github.com/iechor/iechor-ce/releases/tag/v17.11.0-ce-rc4)
  - [iEchor compose 1.17.1](https://github.com/iechor/compose/releases/tag/1.17.1)
  - Linux kernel 4.9.60

* Bug fixes and minor changes
  - Fix login into private repository with certificate issue. [iechor/for-mac#2201](https://github.com/iechor/for-mac/issues/2201)

* New
  - For systems running APFS on SSD on High Sierra, use `raw` format virtual machine disks by default. This increases disk throughput (from 320MiB/sec to 600MiB/sec in `dd` on a 2015 MacBook Pro) and disk space handling.
  Existing disks are kept in qcow format, if you want to switch to raw format you need to "Reset to factory defaults". To query the space usage of the file, use a command like:
  `$ cd ~/Library/Containers/com.iechor.iechor/Data/com.iechor.driver.amd64-linux/`
  `$ ls -ls iEchor.raw`
  `3944768 -rw-r--r--@ 1 user  staff  68719476736 Nov 16 11:19 iEchor.raw`
  The first number (`3944768`) is the allocated space in blocks; the larger number `68719476736` is the maximum total amount of space the file may consume in future in bytes.

### iEchor Community Edition 17.11.0-ce-rc3-mac38 2017-11-09

* Upgrades
  - [iEchor 17.11.0-ce-rc3](https://github.com/iechor/iechor-ce/releases/tag/v17.11.0-ce-rc3)

* Bug fixes and minor changes
  - Fix iEchor build exits successfully but fails to build image [moby/#35413](https://github.com/moby/moby/issues/35413).

### iEchor Community Edition 17.11.0-ce-rc2-mac37 2017-11-02

* Upgrades
  - [iEchor 17.11.0-ce-rc2](https://github.com/iechor/iechor-ce/releases/tag/v17.11.0-ce-rc2)
  - [iEchor compose 1.17.0](https://github.com/iechor/compose/releases/tag/1.17.0)
  - Linuxkit blueprint updated to [linuxkit/linuxkit#2633](https://github.com/linuxkit/linuxkit/pull/2633), fixes CVE-2017-15650

* Bug fixes and minor changes
  - Fix centos:5 & centos:6 images not starting properly with LinuxKit virtual machine (fixes [iechor/for-mac#2169](https://github.com/iechor/for-mac/issues/2169)).


### iEchor Community Edition 17.10.0-ce-mac36 2017-10-24

* Upgrades
  - [iEchor 17.10.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.10.0-ce)
  - [iEchor Machine 0.13.0](https://github.com/iechor/machine/releases/tag/v0.13.0)
  - [iEchor compose 1.17.0-rc1](https://github.com/iechor/compose/releases/tag/1.17.0-rc1)

* New
  - Virtual machine entirely built with Linuxkit

### iEchor Community Edition 17.09.0-ce-mac34 2017-10-06

* Bug fixes and minor changes
  - Fix iEchor For Mac unable to start in some cases : removed use of libgmp sometimes causing the vpnkit process to die.

### iEchor Community Edition 17.09.0-ce-mac31 2017-09-29

* Upgrades
  - [iEchor 17.09.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.09.0-ce)
  - DataKit update (fix instability on High Sierra)

* Bug fixes and minor changes
  - Fix password encoding/decoding. May require to re-login to iechor cloud after this version is installed. (Fixes:iechor/for-mac#2008, iechor/for-mac#2016, iechor/for-mac#1919, iechor/for-mac#712, iechor/for-mac#1220).

### iEchor Community Edition 17.09.0-ce-rc3-mac30 2017-09-22

* Upgrades
  - [iEchor 17.09.0-ce-rc3](https://github.com/iechor/iechor-ce/releases/tag/v17.09.0-ce-rc3)

### iEchor Community Edition 17.09.0-ce-rc2-mac29 2017-09-19

* Upgrades
  - [iEchor 17.09.0-ce-rc2](https://github.com/iechor/iechor-ce/releases/tag/v17.09.0-ce-rc2)
  - Linux Kernel 4.9.49
  - AUFS 20170911

* Bug fixes and minor changes
  - Kernel: Enable TASK_XACCT and TASK_IO_ACCOUNTING [iechor/for-mac#1608](https://github.com/iechor/for-mac/issues/1608)
  - Rotate logs in the virtual machine more often

### iEchor Community Edition 17.09.0-ce-rc1-mac28 2017-09-07

* Upgrades
  - [iEchor 17.09.0-ce-rc1](https://github.com/iechor/iechor-ce/releases/tag/v17.09.0-ce-rc1)
  - [iEchor compose 1.16.1](https://github.com/iechor/compose/releases/tag/1.16.1)
  - Linux Kernel 4.9.46

* Bug fixes and minor changes
  - VPNKit: change protocol to support error messages reported back from the server

### iEchor Community Edition 17.07.0-ce-mac26, 2017-09-01

* Upgrades
  - [iEchor 17.07.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.07.0-ce)
  - [iEchor compose 1.16.0](https://github.com/iechor/compose/releases/tag/1.16.0)
  - [iEchor Credential Helpers 0.6.0](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.6.0)

### iEchor Community Edition 17.07.0-ce-rc4-mac25, 2017-08-24

**Upgrades**

- [iEchor 17.07.0-ce-rc4](https://github.com/iechor/iechor-ce/releases/tag/v17.07.0-ce-rc4)
- [iEchor compose 1.16.0-rc1](https://github.com/iechor/compose/releases/tag/1.16.0-rc1)

**Bug fixes and minor changes**

- Fixed string validation in daemon options (related to [iechor/for-mac#1971](https://github.com/iechor/for-mac/issues/1971))
- VPNKit: Fixed a bug which causes a socket to leak if the corresponding
TCP connection is idle for more than five minutes (related to
[iechor/for-mac#1374](https://github.com/iechor/for-mac/issues/1374))

### iEchor Community Edition 17.07.0-ce-rc3-mac23, 2017-08-21

**Upgrades**

- [iEchor 17.07.0-ce-rc3](https://github.com/iechor/iechor-ce/releases/tag/v17.07.0-ce-rc3)

**New**

- VPNKit: Added support for ping!
- VPNKit: Added `slirp/port-max-idle-timeout` to allow the timeout to be adjusted or even disabled
- VPNKit: Bridge mode is default everywhere now

**Bug fixes and minor changes**

- VPNKit: Improved the logging around the UNIX domain socket connections
- VPNKit: Automatically trim whitespace from `int` or `bool` database keys

### iEchor Community Edition 17.07.0-ce-rc2-mac22, 2017-08-11

**Upgrades**

- [iEchor 17.07.0-ce-rc2](https://github.com/iechor/iechor-ce/releases/tag/v17.07.0-ce-rc2)
- Linux Kernel 4.9.41

### iEchor Community Edition 17.07.0-ce-rc1-mac21, 2017-07-31

**Upgrades**

- [iEchor 17.07.0-ce-rc1](https://github.com/iechor/iechor-ce/releases/tag/v17.07.0-ce-rc1)
- [iEchor compose 1.15.0](https://github.com/iechor/compose/releases/tag/1.15.0)
- [iEchor Machine 0.12.2](https://github.com/iechor/machine/releases/tag/v0.12.2)
- Linux Kernel 4.9.38

**New**

- Transparent proxy using macOS system proxies (if defined) directly
- GUI settings are now stored in `~/Library/Group\ Containers/group.com.iechor/settings.json`. `daemon.json` in now a file in `~/.iechor/`
- You can now change the default IP address used by Hyperkit if it collides with your network

**Bug fixes and minor changes**

- Add daemon options validation
- Diagnose can be cancelled & Improved help information. Fixes [iechor/for-mac#1134](https://github.com/iechor/for-mac/issues/1134), [iechor/for-mac#1474](https://github.com/iechor/for-mac/issues/1474)
- Support paging of iEchor Cloud [repositories](../../iechor-hub/repos/index.md) and [organizations](../../admin/organization/orgs.md). Fixes [iechor/for-mac#1538](https://github.com/iechor/for-mac/issues/1538)

### iEchor Community Edition 17.06.1-ce-mac20, 2017-07-18

**Upgrades**

- [iEchor 17.06.1-ce-rc1](https://github.com/iechor/iechor-ce/releases/tag/v17.06.1-ce-rc1)
- Linux Kernel 4.9.36
- AUFS 20170703

### iEchor Community Edition 17.06.0-ce-mac17, 2017-06-28

**Upgrades**

- [iEchor 17.06.0-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.06.0-ce)

### iEchor Community Edition 17.06.0-rc5-ce-mac16, 2017-06-21

**Upgrades**

- [iEchor 17.06.0-ce-rc5](https://github.com/iechor/iechor-ce/releases/tag/v17.06.0-ce-rc5)
- [iEchor compose 1.14.0](https://github.com/iechor/compose/releases/tag/1.14.0)

### iEchor Community Edition 17.06.0-rc4-ce-mac15, 2017-06-16

**Upgrades**

- [iEchor 17.06.0-rc4-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.06.0-ce-rc4)
- [iEchor Credential Helpers 0.5.2](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.5.2)
- Linux Kernel 4.9.31

### iEchor Community Edition 17.06.0-rc2-ce-mac14, 2017-06-08

**Upgrades**

- [iEchor 17.06.0-rc2-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.06.0-ce-rc2)
- [iEchor Machine 0.12.0](https://github.com/iechor/machine/releases/tag/v0.12.0)
- [iEchor compose 1.14.0-rc2](https://github.com/iechor/compose/releases/tag/1.14.0-rc2)

### iEchor Community Edition 17.06.0-rc1-ce-mac13, 2017-06-01

**Upgrades**

- [iEchor 17.06.0-rc1-ce](https://github.com/iechor/iechor-ce/releases/tag/v17.06.0-ce-rc1)
- [iEchor Credential Helpers 0.5.1](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.5.1)
- `qcow-tool` v0.10.0 (improve the performance of `compact`: `mirage/ocaml-qcow#94`)
- OS X Yosemite 10.10 is marked as deprecated
- Linux Kernel 4.9.30

**New**

- GUI option to opt out of credential store
- GUI option to reset iechor data without losing all settings (fixes [iechor/for-mac#1309](https://github.com/iechor/for-mac/issues/1309))
- Add an experimental DNS name for the host: `iechor.for.mac.localhost`
- Support for client (such as "login") certificates for authenticating registry access (fixes [iechor/for-mac#1320](https://github.com/iechor/for-mac/issues/1320))

**Bug fixes and minor changes**

- Resync HTTP(S) proxy settings on application start
- Interpret system proxy setting of localhost correctly (see [iechor/for-mac#1511](https://github.com/iechor/for-mac/issues/1511))
- All iechor binaries bundled with iEchor for Mac are now signed
- Display all iechor cloud organizations and repositories in the whale menu (fixes [iechor/for-mac#1538](https://github.com/iechor/for-mac/issues/1538))
- OSXFS: improved latency for many common operations, such as read and write by approximately 25%

### iEchor Community Edition 17.05.0-ce-mac11, 2017-05-12

**Upgrades**

- Security fix for CVE-2017-7308

### iEchor Community Edition 17.05.0-ce-mac9, 2017-05-09

**Upgrades**

- [iEchor 17.05.0-ce](https://github.com/iechor/iechor/releases/tag/v17.05.0-ce)
- [iEchor Compose 1.13.0](https://github.com/iechor/compose/releases/tag/1.13.0)
- [iEchor Machine 1.11.0](https://github.com/iechor/machine/releases/tag/v0.11.0)

**Bug fixes and minor changes**

- Fixed GUI crash when text table view was selected and windows re-opened (fixes [iechor/for-mac#1477](https://github.com/iechor/for-mac/issues/1477))
- Reset to default / uninstall also remove `config.json` and `osxkeychain` credentials
- More detailed VirtualBox uninstall requirements ( [iechor/for-mac#1343](https://github.com/iechor/for-mac/issues/1343))
- You are now prompted for your password, if you changed it in iEchor Cloud.
- Request time sync after waking up to improve [iechor/for-mac#17](https://github.com/iechor/for-mac/issues/17)

### iEchor Community Edition 17.05.0-ce-rc1-mac8, 2017-04-13

**Upgrades**

- [iEchor 17.05.0-ce-rc1](https://github.com/iechor/iechor/releases/tag/v17.05.0-ce-rc1)


### iEchor Community Edition 17.04.0-ce-mac7, 2017-04-06

**New**

- OSXFS: support for `cached` mount flag to improve performance of macOS mounts when strict consistency is not necessary

**Upgrades**

- [iEchor 17.04.0-ce](https://github.com/iechor/iechor/releases/tag/v17.04.0-ce)
- [iEchor Compose 1.12.0](https://github.com/iechor/compose/releases/tag/1.12.0)
- Linux Kernel 4.9.19

**Bug fixes and minor changes**

- VPNKit: Improved DNS timeout handling (fixes [iechor/for-mac#202](https://github.com/iechor/vpnkit/issues/202))
- VPNKit: Use DNSServiceRef API by default (only enabled for new installs or after factory reset)
- Add a reset to factory defaults button when application crashes
- Toolbox import dialog now defaults to "Skip"

### iEchor Community Edition 17.04.0-ce-rc2-mac6, 2017-04-03

**Upgrades**

- [iEchor 17.04.0-ce-rc2](https://github.com/iechor/iechor/releases/tag/v17.04.0-ce-rc2)
- [iEchor Compose 1.12.0-rc2](https://github.com/iechor/compose/releases/tag/1.12.0-rc2)
- Linux Kernel 4.9.18

**Bug fixes and minor changes**

- Buffered data should be treated correctly when iEchor client requests are upgraded to raw streams
- Removed an error message from the output related to experimental features handling
- `vmnetd` should not crash when user home directory is on an external drive
- Improved settings database schema handling
- Disk trimming should work as expected
- Diagnostics now contains more settings data


### iEchor Community Edition 17.03.1-ce-rc1-mac3, 2017-03-28

**Upgrades**

- [iEchor 17.03.1-ce-rc1](https://github.com/iechor/iechor/releases/tag/v17.03.1-ce-rc1)
- [iEchor Credential Helpers 0.5.0](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.5.0)
- Linux Kernel 4.9.14

**Bug fixes and minor changes**

- Use `fsync` rather than `fcntl`(`F_FULLFSYNC`)
- Update max-connections to 2000 ([iechor/for-mac#1374](https://github.com/iechor/for-mac/issues/1374) and [iechor/for-mac#1132](https://github.com/iechor/for-mac/issues/1132))
- VPNKit: capture up to 64KiB of NTP traffic for diagnostics, better handling of DNS
- UI: fix edge cases which crash the application
- QCOW: numerous bugfixes
- osxfs: buffer readdir

### iEchor Community Edition 17.03.0-ce-mac2, 2017-03-06

**Hotfixes**

- Set the ethernet MTU to 1500 to prevent a hyperkit crash
- Fix iEchor build on private images

**Upgrades**

- [iEchor Credential Helpers 0.4.2](https://github.com/iechor/iechor-credential-helpers/releases/tag/v0.4.2)

### iEchor Community Edition 17.03.0-ce-mac1, 2017-03-02

**New**

- Renamed to iEchor Community Edition
- Integration with iEchor Cloud: control remote Swarms from the local CLI and view your repositories. This feature is going to be rolled out to all users progressively
- iEchor will now securely store your IDs in the macOS keychain

**Upgrades**

- [iEchor 17.03.0-ce](https://github.com/iechor/iechor/releases/tag/v17.03.0-ce)
- [iEchor Compose 1.11.2](https://github.com/iechor/compose/releases/tag/1.11.2)
- [iEchor Machine 0.10.0](https://github.com/iechor/machine/releases/tag/v0.10.0)
- Linux Kernel 4.9.12

**Bug fixes and minor changes**

- VPNKit: fix unmarshalling of DNS packets containing pointers to pointers to labels
- osxfs: catch EPERM when reading extended attributes of non-files
- Add page_poison=1 to boot args
- Add a new disk flushing option

### iEchor Community Edition 17.03.0 RC1 Release Notes (2017-02-22 17.03.0-ce-rc1-mac1)

**New**

- Introduce iEchor Community Edition
- Integration with iEchor Cloud to control remote Swarms from the local CLI and view your repositories. This feature will be rolled out to all users progressively
- iEchor will now use keychain access to secure your IDs

**Upgrades**

- iEchor 17.03.0-ce-rc1
- Linux Kernel 4.9.11

**Bug fixes and minor changes**

- VPNKit: fixed unmarshalling of DNS packets containing pointers to pointers to labels
- osxfs: catch EPERM when reading extended attributes of non-files
- Added `page_poison=1` to boot args
- Added a new disk flushing option

### Beta 42 Release Notes (2017-02-09 1.13.1-beta42)

**Upgrades**

- [iEchor 1.13.1](https://github.com/iechor/iechor/releases/tag/v1.13.1)
- [iEchor Compose 1.11.1](https://github.com/iechor/compose/releases/tag/1.11.1)

### Beta 41 Release Notes (2017-02-07-2017-1.13.1-rc2-beta41)

**Upgrades**

- iEchor 1.13.1-rc2
- [iEchor Compose 1.11.0-rc1](https://github.com/iechor/compose/releases/tag/1.11.0-rc1)
- Linux kernel 4.9.8

**Bug fixes and minor improvements**

- VPNKit: set the Recursion Available bit on DNS responses from the cache
- Don’t use port 4222 inside the Linux VM

### Beta 40 Release Notes (2017-01-31 1.13.1-rc1-beta40)

**Upgrades**

- [iEchor 1.13.1-rc1](https://github.com/iechor/iechor/releases/tag/v1.13.1-rc1)
- Linux kernel 4.9.6

**New**

- Allow to reset faulty `daemon.json` through a link in advanced subpanel
- Add link to experimental features
- Hide restart button in settings window
- Increase the maximum number of vCPUs to 64

**Bug fixes and minor improvements**

- VPNKit: Avoid diagnostics to capture too much data
- VPNKit: Fix a source of occasional packet loss (truncation) on the virtual ethernet link
- HyperKit: Dump guest physical and linear address from VMCS when dumping state
- HyperKit: Kernel boots with `panic=1` arg

### Beta 39 Release Notes (2017-01-26 1.13.0-beta39)

**Upgrades**

- Linux kernel 4.9.5

**New**

- More options when moving disk image
- Filesharing and daemon table empty fields are editable
- DNS forwarder ignores responses from malfunctioning servers ([iechor/for-mac#1025](https://github.com/iechor/for-mac/issues/1025))
- DNS forwarder send all queries in parallel, process results in order
- DNS forwarder includes servers with zones in general searches ([iechor/for-mac#997](https://github.com/iechor/for-mac/issues/997))
- Parses aliases from /etc/hosts ([iechor/for-mac#983](https://github.com/iechor/for-mac/issues/983))
- Can resolve DNS requests through servers listed in the /etc/resolver directory on the host

**Bug fixes and minor improvements**

- Fix bug where update window hides when app not focused
- Limit vCPUs to 16 ([iechor/for-mac#1144](https://github.com/iechor/for-mac/issues/1144))
- Fix for swap not being mounted
- Fix AUFS xattr delete issue ([iechor/iechor#30245](https://github.com/iechor/iechor/issues/30245))


### Beta 38 Release Notes (2017-01-20 1.13.0-beta38)

**Upgrades**

- [iEchor 1.13.0](https://github.com/iechor/iechor/releases/tag/v1.13.0)
- [iEchor Compose 1.10](https://github.com/iechor/compose/releases/tag/1.10.0)
- [iEchor Machine 0.9.0](https://github.com/iechor/machine/releases/tag/v0.9.0)
- [Notary 0.4.3](https://github.com/iechor/notary/releases/tag/v0.4.3)
- Linux kernel 4.9.4
- QCOW-tool 0.7.2

**New**

- The storage location of the Linux volume can now be moved
- Reclaim disk size on reboot
- You can now edit filesharing paths
- Memory can be allocated with 256 MiB steps
- Proxy can now be completely disabled
- Support for arm, aarch64, ppc64le architectures using qemu
- Dedicated preference pane for advanced configuration of the iechor daemon (edit daemon.json)
- iEchor Experimental mode can be toggled
- Better support for Split DNS VPN configurations
- Use more DNS servers, respect order

**Bug fixes and minor improvements**

- You can't edit settings while iechor is restarting
- Support Copy/Paste in About box
- Auto update polling every 24h
- Kernel boots with vsyscall=emulate arg and CONFIG_LEGACY_VSYSCALL is set to NONE in Moby
- Fixed vsock deadlock under heavy write load
- If you opt-out of analytics, you're prompted for approval before a bug report is sent
- Fixed bug where search domain could be read as `DomainName`
- Dedicated preference pane for HTTP proxy settings.
- Dedicated preference pane for CPU & Memory computing resources.
- Privacy settings moved to the general preference pane
- Fixed an issue where the preference pane disappeared when the welcome whale menu was closed.
- HyperKit: code cleanup and minor fixes
- Improvements to Logging and Diagnostics
- osxfs: switch to libev/kqueue to improve latency
- VPNKit: improvements to DNS handling
- VPNKit: Improved diagnostics
- VPNKit: Forwarded UDP datagrams should have correct source port numbers
- VPNKit: add a local cache of DNS responses
- VPNKit: If one request fails, allow other concurrent requests to succeed.
  For example this allows IPv4 servers to work even if IPv6 is broken.
- VPNKit: Fix bug which could cause the connection tracking to
  underestimate the number of active connections

### Beta 37 Release Notes (2017-01-16 1.13.0-rc7-beta37)

**Upgrades**

- iEchor 1.13.0-rc7
- Notary 0.4.3
- Linux kernel 4.9.3

### Beta 36 Release Notes (2017-01-12 1.13.0-rc6-beta36)

>**Important Note:** Plugins installed using the experimental "managed plugins" feature in iEchor 1.12 must be removed/uninstalled before upgrading.

**Upgrades**

- iEchor 1.13.0-rc6
- iEchor Compose 1.10-rc2
- Linux Kernel 4.9.2

**Bug fixes and minor improvements**

- Uninstall should be more reliable

### Beta 35 Release Notes (2017-01-06 1.13.0-rc5-beta35)

>**Important Note:** Plugins installed using the experimental "managed plugins" feature in iEchor 1.12 must be removed/uninstalled before upgrading.

**Upgrades**

- iEchor 1.13.0-rc5
- iEchor Compose 1.10-rc1

## Edge Releases of 2016

### Beta 34.1 Release Notes (2016-12-22 1.13.0-rc4-beta34.1)

>**Important Note:** Plugins installed using the experimental "managed plugins" feature in iEchor 1.12 must be removed/uninstalled before upgrading.

**Hotfix**

- Fixed issue where iEchor would fail to start after importing containers from Toolbox

**Upgrades**

- qcow-tool 0.7.2

### Beta 34 Release Notes (2016-12-20 1.13.0-rc4-beta34)

>**Important Note:** Plugins installed using the experimental "managed plugins" feature in iEchor 1.12 must be removed/uninstalled before upgrading.

**New**

- Change UI for path location and open finder
- Trim compact on reboot
- Use more DNS servers, respect order

**Upgrades**

- iEchor 1.13.0-rc4
- Linux Kernel 4.8.15

**Bug fixes and minor improvements**

- New Daemon icon
- Support Copy/Paste in About box
- Fix advanced daemon check json changes
- Auto update polling every 24h

### Beta 33.1 Release Notes (2016-12-16 1.13.0-rc3-beta33.1)

>**Important Note:** Plugins installed using the experimental "managed plugins" feature in iEchor 1.12 must be removed/uninstalled before upgrading.

**Hotfix**

- Fixed issue where sometimes TRIM would cause the virtual machine to hang

### Beta 33 Release Notes (2016-12-15 1.13.0-rc3-beta33)

>**Important Note:** Plugins installed using the experimental "managed plugins" feature in iEchor 1.12 must be removed/uninstalled before upgrading.

**New**

- You can now edit filesharing paths
- YOu can allocate memory with 256 MiB steps
- You can move the storage location of the Linux volume
- More explicit proxy settings
- You can completely disable Proxy
- You can switch daemon tabs without losing your settings
- You can't edit settings while iEchor is restarting

**Upgrades**

- Linux Kernel 4.8.14

**Bug fixes and minor improvements**

- Kernel boots with `vsyscall=emulate arg` and `CONFIG_LEGACY_VSYSCALL` set to `NONE` in Moby

### Beta 32 Release Notes (2016-12-07 1.13.0-rc3-beta32)

**New**

- Support for arm, aarch64, ppc64le architectures using qemu

**Upgrades**

- iEchor 1.13.0-rc3
- iEchor Machine 0.9.0-rc2
- Linux kernel 4.8.12

**Bug fixes and minor improvements**

- VPNKit: Improved diagnostics
- Fix vsock deadlock under heavy write load
- On the beta channel you can't opt-out of analytics
- If you opt-out of analytics, you're prompted for approval before a bug report is sent

### Beta 31 Release Notes (2016-12-01 1.13.0-rc2-beta31)

**New**

- Dedicated preference pane for advanced configuration of the iechor daemon (edit daemon.json). See [Daemon Advanced (JSON configuration file)](../settings/mac.md#iechor-engine).

- iEchor Experimental mode can be toggled. See [Daemon Basic (experimental mode and registries)](../settings/mac.md#iechor-engine).

**Upgrades**

- iEchor 1.13.0-rc2
- iEchor Compose 1.9.0
- iEchor Machine 0.9.0-rc1
- Linux kernel 4.8.10

**Bug fixes and minor improvements**

- Fixed bug where search domain could be read as `DomainName`
- VPNKit: don't permute resource records in responses
- VPNKit: reduced the amount of log spam
- Dedicated preference pane for HTTP proxy settings
- Dedicated preference pane for CPU & Memory computing resources
- Privacy settings moved to the general preference pane
- Fixed an issue where proxy settings were erased if registries or mirrors changed.
- Tab key is now cycling through tabs while setting proxy parameters
- Fixed an issue where the preference pane disappeared when the welcome whale menu was closed

### Beta 30 Release Notes (2016-11-10 1.12.3-beta30)

**New**

- Better support for Split DNS VPN configurations

**Upgrades**

- iEchor Compose 1.9.0-rc4
- Linux kernel 4.4.30

**Bug fixes and minor changes**

- HyperKit: code cleanup and minor fixes
- VPNKit: improvements to DNS handling
- Improvements to Logging and Diagnostics
- osxfs: switched to `libev/kqueue` to improve latency


### Beta 29.3 Release Notes (2016-11-02 1.12.3-beta29.3)

**Upgrades**

- iEchor Compose 1.9.0-rc2
- `osxfs`: Fixed a simultaneous volume mount race which can result in a crash

### Beta 29.2 Release Notes (2016-10-27 1.12.2-beta29.2)

**Hotfixes**

- Upgrade to iEchor 1.12.3

### Beta 29.1 Release Notes (2016-10-26 1.12.1-beta29.1)

**Hotfixes**

- Fixed missing `/dev/pty/ptmx`

### Beta 29 Release Notes (2016-10-25 1.12.3-rc1-beta29)

**New**

- Overlay2 is now the default storage driver. You must do a factory reset for overlay2 to be automatically used. (#5545)

**Upgrades**

- iEchor 1.12.3-rc1
- Linux kernel 4.4.27

**Bug fixes and minor changes**

- Fixed an issue where the whale animation during setting change was inconsistent
- Fixed an issue where some windows stayed hidden behind another app
- Fixed application of system or custom proxy settings over container restart
- Increased default ulimit for memlock (fixes [iechor/for-mac#801](https://github.com/iechor/for-mac/issues/801) )
- Fixed an issue where the iEchor status would continue to be
      yellow/animated after the VM had started correctly
- osxfs: fixed the prohibition of chown on read-only or mode 0 files (fixes [iechor/for-mac#117](https://github.com/iechor/for-mac/issues/117), [iechor/for-mac#263](https://github.com/iechor/for-mac/issues/263), [iechor/for-mac#633](https://github.com/iechor/for-mac/issues/633) )

### Beta 28 Release Notes (2016-10-13 1.12.2-rc3-beta28)

**Upgrades**

- iEchor 1.12.2
- Kernel 4.4.24
- Notary 0.4.2

**Bug fixes and minor changes**

- Fixed an issue where iEchor for Mac was incorrectly reported as updated
- osxfs: Fixed race condition causing some reads to run forever
- Channel is now displayed in About box
- Crash reports are sent over Bugsnag rather than HockeyApp

### Beta 27 Release Notes (2016-09-28 1.12.2-rc1-beta27)

**Upgrades**

* iEchor 1.12.2-rc1
* iEchor Machine 0.8.2
* iEchor compose 1.8.1
* Kernel vsock driver v7
* Kernel 4.4.21
* AUFS 20160912

**Bug fixes and minor changes**

* Fixed an issue where some windows did not claim focus correctly
* Added UI when switching channel to prevent user losing containers and settings
* Check disk capacity before Toolbox import
* Import certificates in `etc/ssl/certs/ca-certificates.crt`
* DNS: reduce the number of UDP sockets consumed on the host
* VPNkit: improve the connection-limiting code to avoid running out of sockets on the host
* UDP: handle diagrams bigger than 2035, up to the configured macOS kernel limit
* UDP: made the forwarding more robust; now, drop packets and continue rather than stopping
* disk: made the "flush" behaviour configurable for database-like workloads. This works around a performance regression in `v1.12.1`.

### Beta 26 Release Notes (2016-09-14 1.12.1-beta26)

**New**

* Improved support for macOS 10.12 Sierra

**Upgrades**

* Linux kernel 4.4.20
* AUFS 20160905

**Bug fixes and minor changes**

* Fixed communications glitch when UI talks to `com.iechor.vmnetd`. Fixes [iechor/for-mac#90](https://github.com/iechor/for-mac/issues/90)

* UI fix for macOs 10.12

* Windows open on top of full screen app are available in all spaces

* Reporting a bug, while not previously logged into GitHub now works

* When a diagnostic upload fails, the error is properly reported

* `iechor-diagnose` displays and records the time the diagnosis was captured

* Ports are allowed to bind to host addresses other than `0.0.0.0` and `127.0.0.1`. Fixes issue reported in [iechor/for-mac#68](https://github.com/iechor/for-mac/issues/68).

* We no longer compute the container folder in `com.iechor.vmnetd`. Fixes [iechor/for-mac#47](https://github.com/iechor/for-mac/issues/47).

**Known Issues**

* `iEchor.app` sometimes uses 200% CPU after macOS wakes up from sleep mode. The
issue is being investigated. The workaround is to restart iEchor.app.

* There are a number of issues with the performance of directories bind-mounted with `osxfs`. In particular, writes of small blocks and
traversals of large directories are currently slow. Additionally, containers
that perform large numbers of directory operations, such as repeated scans of
large directory trees, may suffer from poor performance. More information is
available in [Known Issues](../troubleshoot/known-issues.md) in Troubleshooting.

* Under some unhandled error conditions, `inotify` event delivery can fail and become permanently disabled. The workaround is to restart `iEchor.app`.

### Beta 25 Release Notes (2016-09-07 1.12.1-beta25)

**Upgrades**

* Experimental support for macOS 10.12 Sierra (beta)

**Bug fixes and minor changes**

* VPNKit supports search domains
* Entries from `/etc/hosts` should now resolve from within containers
* osxfs: fix thread leak

**Known issues**

* Several problems have been reported on macOS 10.12 Sierra and are being
investigated. This includes failure to launch the app and being unable to
upgrade to a new version.

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The
issue is being investigated. The workaround is to restart iEchor.app

* There are a number of issues with the performance of directories bind-mounted
with `osxfs`. In particular, writes of small blocks and traversals of large
directories are currently slow. Additionally, containers that perform large
numbers of directory operations, such as repeated scans of large directory
trees, may suffer from poor performance. More information is available in
[Known Issues](../troubleshoot/known-issues.md) in Troubleshooting.

* Under some unhandled error conditions, `inotify` event delivery can fail and become permanently disabled. The workaround is to restart iEchor.app.

### Beta 24 Release Notes (2016-08-23 1.12.1-beta24)

**Upgrades**

* iEchor 1.12.1
* iEchor Machine 0.8.1
* Linux kernel 4.4.19
* AUFS 20160822

**Bug fixes and minor changes**

* osxfs: fixed a malfunction of new directories that have the same name as an old directory that is still open

* osxfs: rename events now trigger DELETE and/or MODIFY `inotify` events (saving with TextEdit works now)

* slirp: support up to 8 external DNS servers

* slirp: reduce the number of sockets used by UDP NAT, reduce the probability that NAT rules will time out earlier than expected

* The app warns user if BlueStacks is installed (potential kernel panic)

**Known issues**

* Several problems have been reported on macOS 10.12 Sierra and are being investigated. This includes failure to launch the app and being unable to upgrade to a new version.

* `iEchor.app` sometimes uses 200% CPU after macOS wakes up from sleep mode.  The issue is being investigated. The workaround is to restart `iEchor.app`.

* There are a number of issues with the performance of directories bind-mounted with `osxfs`. In particular, writes of small blocks and traversals of large
directories are currently slow. Additionally, containers that perform large
numbers of directory operations, such as repeated scans of large directory
trees, may suffer from poor performance. For more information and workarounds, see the bullet on performance of bind-mounted directories in [Known Issues](../troubleshoot/known-issues.md) in Troubleshooting.

* Under some unhandled error conditions, `inotify` event delivery can fail and become permanently disabled. The workaround is to restart `iEchor.app`.

### Beta 23 Release Notes (2016-08-16 1.12.1-rc1-beta23)

**Upgrades**

* iEchor 1.12.1-rc1
* Linux kernel 4.4.17
* AUFS 20160808

**Bug fixes and minor changes**

* Moby: use default sysfs settings, transparent huge pages disabled
* Moby: cgroup mount to support systemd in containers
* osxfs: fixed an issue that caused `inotify` failure and crashes
* osxfs: fixed a directory fd leak
* Zsh completions

**Known issues**

*  iEchor for Mac is not supported on macOS 10.12 Sierra

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app

* There are a number of issues with the performance of directories bind-mounted with `osxfs`. In particular, writes of small blocks and traversals of large directories are currently slow. Additionally, containers that perform large numbers of directory operations, such as repeated scans of large directory trees, may suffer from poor performance. For more information and workarounds, see the bullet on performance of bind-mounted directories in [Known Issues](../troubleshoot/known-issues.md) in Troubleshooting.

* Under some unhandled error conditions, `inotify` event delivery can fail and become permanently disabled. The workaround is to restart iEchor.app

### Beta 22 Release Notes (2016-08-11 1.12.0-beta22)

**Upgrades**

*  Linux kernel to 4.4.16

**Bug fixes and minor changes**

* Increase Moby fs.file-max to 524288
* Use Mac System Configuration database to detect DNS
* HyperKit updated with dtrace support and lock fixes
* Fix Moby Diagnostics and Update Kernel
* UI Fixes
* osxfs: fix socket chowns

**Known issues**

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app

* There are a number of issues with the performance of directories bind-mounted with `osxfs`. In particular, writes of small blocks and traversals of large directories are currently slow. Additionally, containers that perform large numbers of directory operations, such as repeated scans of large directory trees, may suffer from poor performance. More information is available in [Known Issues](../troubleshoot/known-issues.md).

* Under some unhandled error conditions, `inotify` event delivery can fail and become permanently disabled. The workaround is to restart iEchor.app

### Beta 21.1 Release Notes (2016-08-03 1.12.0-beta21.1)

This bug fix release contains osxfs improvements. The fixed issues may have
been seen as failures with apt-get and npm in containers, missed `inotify`
events or unexpected unmounts.

**Hotfixes**

* osxfs: fixed an issue causing access to children of renamed directories to fail (symptoms: npm failures, apt-get failures)

* osxfs: fixed an issue causing some ATTRIB and CREATE `inotify` events to fail delivery and other `inotify` events to stop

* osxfs: fixed an issue causing all `inotify` events to stop when an ancestor directory of a mounted directory was mounted

* osxfs: fixed an issue causing volumes mounted under other mounts to spontaneously unmount (iechor/iechor#24503)

### iEchor for Mac 1.12.0 (2016-07-28 1.12.0-beta21)

**New**

* iEchor for Mac is now available from 2 channels: **stable** and **beta**. New features and bug fixes will go out first in auto-updates to users in the beta channel. Updates to the stable channel are much less frequent and happen in sync with major and minor releases of the iEchor engine. Only features that are well-tested and ready for production are added to the stable channel releases. For downloads of both and more information, see the [installation guide](../install/mac-install.md).

**Upgrades**

* iEchor 1.12.0 with experimental features
* iEchor Machine 0.8.0
* iEchor Compose 1.8.0

**Bug fixes and minor changes**

* Check for updates, auto-update and diagnose can be run by non-admin users
* osxfs: fixed an issue causing occasional incorrect short reads
* osxfs: fixed an issue causing occasional EIO errors
* osxfs: fixed an issue causing `inotify` creation events to fail
* osxfs: increased the `fs.inotify.max_user_watches` limit in Moby to 524288
* The UI shows documentation link for sharing volumes
* Clearer error message when running with outdated VirtualBox version
* Added link to sources for qemu-img

**Known issues**

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app

* There are a number of issues with the performance of directories bind-mounted with `osxfs`.  In particular, writes of small blocks, and traversals of large directories are currently slow.  Additionally, containers that perform large numbers of directory operations, such as repeated scans of large directory trees, may suffer from poor performance. For more information and workarounds, see [Known Issues](../troubleshoot/known-issues.md) in [Logs and Troubleshooting](../troubleshoot/overview.md).

* Under some unhandled error conditions, `inotify` event delivery can fail and become permanently disabled. The workaround is to restart iEchor.app

### Beta 20 Release Notes (2016-07-19 1.12.0-rc4-beta20)

**Bug fixes and minor changes**

* Fixed `iechor.sock` permission issues
* Don't check for update when the settings panel opens
* Removed obsolete DNS workaround
* Use the secondary DNS server in more circumstances
* Limit the number of concurrent port forwards to avoid running out of resources
* Store the database as a "bare" git repo to avoid corruption problems

**Known issues**

*  `iEchor.app` sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor for Mac (`iEchor.app`).

### Beta 19 Release Notes (2016-07-14 1.12.0-rc4-beta19)

**New**

* Added privacy tab in settings
* Allow the definition of HTTP proxy overrides in the UI

**Upgrades**

* iEchor 1.12.0 RC4
* iEchor Compose 1.8.0 RC2
* iEchor Machine 0.8.0 RC2
* Linux kernel 4.4.15

**Bug fixes and minor changes**

* Filesystem sharing permissions can only be configured in the UI (no more `/Mac` in moby)
* `com.iechor.osx.xhyve.hyperkit`: increased max number of fds to 10240
* Improved Moby syslog facilities
* Improved file-sharing tab
* `com.iechor.slirp`: included the DNS TCP fallback fix, required when UDP responses are truncated
* `iechor build/events/logs/stats...` won't leak when iterrupted with Ctrl-C

**Known issues**

* See [Known Issues](../troubleshoot/known-issues.md).

### Beta 18.1 Release Notes (2016-07-07 1.12.0-rc3-beta18.1)

>**Note**: iEchor 1.12.0 RC3 release introduces a backward incompatible change from RC2. You can fix this by recreating or updating your containers.

**Hotfix**

* Fixed issue resulting in error "Hijack is incompatible with use of CloseNotifier", reverts previous fix for `Ctrl-C` during build.

**New**

* New host/container file sharing UI
* `/Mac` bind mount prefix is deprecated and will be removed soon

**Upgrades**

* iEchor 1.12.0 RC3

**Bug fixes and minor changes**

* VPNKit: Improved scalability as number of network connections increases
* The iechor API proxy was failing to deal with some 1.12 features, such as health check.

**Known issues**

* See [Known Issues](../troubleshoot/known-issues.md).

### Beta 18 Release Notes (2016-07-06 1.12.0-rc3-beta18)

**New**

* New host/container file sharing UI
* `/Mac` bind mount prefix is deprecated and will be removed soon

**Upgrades**

* iEchor 1.12.0 RC3

**Bug fixes and minor changes**

* VPNKit: Improved scalability as number of network connections increases
* Interrupting a `iechor build` with Ctrl-C will actually stop the build
* The iechor API proxy was failing to deal with some 1.12 features, such as health check.

**Known issues**

* See [Known Issues](../troubleshoot/known-issues.md).

### Beta 17 Release Notes (2016-06-29 1.12.0-rc2-beta17)

**Upgrades**

* Linux kernel 4.4.14, AUFS 20160627

**Bug fixes and minor changes**

* Documentation moved to [/desktop/mac/](../index.md)
* Allow non-admin users to launch the app for the first time (using admin creds)
* Prompt non-admin users for admin password when needed in Preferences
* Fixed download links, documentation links
* Fixed "failure: No error" message in diagnostic panel
* Improved diagnostics for networking and logs for the service port openers

**Known issues**

* See [Known Issues](../troubleshoot/known-issues.md).

### Beta 16 Release Notes (2016-06-17 1.12.0-rc2-beta16)

**Upgrades**

* iEchor 1.12.0 RC2
* iechor-compose 1.8.0 RC1
* iechor-machine 0.8.0 RC1
* notary 0.3
* Alpine 3.4

**Bug fixes and minor changes**

* VPNKit: Fixed a regressed error message when a port is in use
* Fixed UI crashing with `NSInternalInconsistencyException` / fixed leak
* HyperKit API: Improved error reporting
* osxfs: fix sporadic EBADF due to fd access/release races (#3683)


**Known issues**

* See [Known Issues](../troubleshoot/known-issues.md).

### Beta 15 Release Notes (2016-06-10 1.11.2-beta15)

**New**

* Registry mirror and insecure registries can now be configured from Preferences
* Virtual machine can now be restarted from Preferences
* `sysctl.conf` can be edited from Preferences

**Upgrades**

* iEchor 1.11.2
* Linux 4.4.12, `aufs` 20160530

**Bug fixes and minor changes**

* Timekeeping in Moby VM improved
* Number of concurrent TCP/UDP connections increased in VPNKit
* Hyperkit: `vsock` stability improvements
* Fixed crash when user is admin

**Known issues**

* See [Known Issues](../troubleshoot/known-issues.md).

### Beta 14 Release Notes (2016-06-02 1.11.1-beta14)

**New**

* New settings menu item, **Diagnose & Feedback**, is available to run diagnostics and upload logs to iEchor.

**Known issues**

* `iEchor.app` sometimes uses 200% CPU after macOS wakes up from sleep mode with macOS 10.10. The issue is being investigated. The workaround is to restart `iEchor.app`.

**Bug fixes and minor changes**

* `osxfs`: now support `statfs`
* **Preferences**: updated toolbar icons
* Fall back to secondary DNS server if primary fails.
* Added a link to the documentation from menu.

### Beta 13.1 Release Notes (2016-05-28 1.11.1-beta13.1)

**Hotfixes**

* `osxfs`:
  - Fixed sporadic EBADF errors and End_of_file crashes due to a race corrupting node table invariants
  - Fixed a crash after accessing a sibling of a file moved to another directory caused by a node table invariant violation
* Fixed issue where Proxy settings were applied on network change, causing iechor daemon to restart too often
* Fixed issue where log file sizes doubled on iechor daemon restart

### Beta 13 Release Notes (2016-05-25 1.11.1-beta13)

**New**

* `osxfs`: Enabled 10ms dcache for 3x speedup on a `go list ./...` test against iechor/machine. Workloads heavy in file system path resolution (common among dynamic languages and build systems) will have those resolutions performed in amortized constant time rather than time linear in the depth of the path so speedups of 2-10x will be common.

* Support multiple users on the same machine, non-admin users can use the app as long as `vmnetd` has been installed. Currently, only one user can be logged in at the same time.

* Basic support for using system HTTP/HTTPS proxy in iechor daemon

**Known issues**

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app.

**Bug fixes and minor changes**

* `osxfs`:
  - setting `atime` and `mtime` of nodes is now supported
  - Fixed major regression in Beta 12 with ENOENT, ENOTEMPY, and other spurious errors after a directory rename. This manifested as `npm install` failure and other directory traversal issues.
  - Fixed temporary file ENOENT errors
  - Fixed in-place editing file truncation error, such as when running `perl -i`
* improved time synchronisation after sleep

### Beta 12 Release (2016-05-17 1.11.1-beta12)

**Upgrades**

* FUSE 7.23 for osxfs

**Known issues**

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app.

**Bug fixes and minor changes**

* UI improvements
* Fixed a problem in osxfs where`mkdir` returned EBUSY but directory was created.

### Beta 11 Release (2016-05-10 1.11.1-beta11)

**New**

The `osxfs` file system now persists ownership changes in an extended attribute.

**Upgrades**

* iechor-compose 1.7.1 (see [changelog](https://github.com/iechor/compose/releases/tag/1.7.1))
* Linux kernel 4.4.9

**Bug fixes and minor changes**

* Desktop notifications after successful update
* No "update available" popup during install process
* Fixed repeated bind of privileged ports
* `osxfs`: Fixed the block count reported by stat
* Moby (Backend) fixes:
  - Fixed `vsock` half closed issue
  - Added NFS support
  - Hostname is now Moby, not iEchor
  - Fixes to disk formatting scripts
  - Linux kernel upgrade to 4.4.9

### Beta 10 Release (2016-05-03 1.11.0-beta10)

**New**

* Token validation is now done over an actual SSL tunnel (HTTPS). (This should fix issues with antivirus applications.)

**Upgrades**

* iEchor 1.11.1

**Bug fixes and minor changes**

* UCP now starts again
* Include debugging symbols in HyperKit
* vsock stability improvements
* Addressed glitches in **Preferences** panel
* Fixed issues impacting the “whale menu”
* Fixed uninstall process
* HyperKit vcpu state machine improvements, may improve suspend/resume


### Beta 9 Release (2016-04-26 1.11.0-beta9)

**New**

* New Preferences window - memory and vCPUs now adjustable
* `localhost` is now used for port forwarding by default.`iechor.local` will no longer work as of Beta 9.

**Known issues**

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app.

**Bug fixes and minor changes**

* Fix loopback device naming
* Improved iechor socket download and osxfs sequential write by 20%
* `com.iechor.osxfs`
  - improved sequential read throughput by up to 20%
  - improved `readdir` performance by up to 6x
  - log all fatal exceptions
* More reliable DNS forwarding over UDP and TCP
* UDP ports can be proxied over vsock
* Fixed EADDRINUSE (manifesting as errno 526) when ports are re-used
* Send ICMP when asked to not fragment and we can't guarantee it
* Fixed parsing of UDP datagrams with IP socket options
* Drop abnormally large ethernet frames
* Improved HyperKit logging
* Record virtual machine start and stop events

### Beta 8 Release (2016-04-20 1.11.0-beta8)

**New**

* Networking mode switched to VPN compatible by default, and as part of this change the overall experience has been improved:
 - `iechor.local` now works in VPN compatibility mode
 - exposing ports on the Mac is available in both networking modes
 - port forwarding of privileged ports now works in both networking modes
 - traffic to external DNS servers is no longer dropped in VPN mode


* `osxfs` now uses `AF_VSOCK` for transport giving ~1.8x speedup for large sequential read/write workloads but increasing latency by ~1.3x. `osxfs` performance engineering work continues.


**Known issues**

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart `iEchor.app`

**Bug fixes and minor changes**

* Apple System Log now used for most logs instead of direct filesystem logging
* `iechor_proxy` fixes
* Merged HyperKit upstream patches
* Improved error reporting in `nat` network mode
* `osxfs` `transfused` client now logs over `AF_VSOCK`
* Fixed a `com.iechor.osx.HyperKit.linux` supervisor deadlock if processes exit during a controlled shutdown
* Fixed VPN mode malformed DNS query bug preventing some resolutions


### Beta 7 Release (2016-04-12 1.11.0-beta7)

**New**

* Docs are updated per the Beta 7 release
* Use AF_VSOCK for iechor socket transport

**Upgrades**

* iechor 1.11.0-rc5
* iechor-machine 0.7.0-rc3
* iechor-compose 1.7.0rc2


**Known issues**

* iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app

* If VPN mode is enabled and then disabled and then re-enabled again, `iechor ps` will block for 90s

**Bug fixes and minor changes**

* Logging improvements
* Improve process management

### Beta 6 Release (2016-04-05 1.11.0-beta6)

**New**

* Docs are updated per the Beta 6 release
* Added uninstall option in user interface

**Upgrades**

* iechor 1.11.0-rc5
* iechor-machine 0.7.0-rc3
* iechor-compose 1.7.0rc2

**Known issues**

* `iEchor.app` sometimes uses 200% CPU after macOS wakes up from sleep mode.
The issue is being investigated. The workaround is to restart
`iEchor.app`.

* If VPN mode is enabled, then disabled and re-enabled again,
`iechor ps` will block for 90 seconds.

**Bug fixes and minor changes**

* Fixed osxfs multiple same directory bind mounts stopping inotify
* Fixed osxfs `setattr` on mode 0 files (`sed` failures)
* Fixed osxfs blocking all operations during `readdir`
* Fixed osxfs mishandled errors which crashed the file system and VM
* Removed outdated `lofs`/`9p` support
* Added more debugging info to logs uploaded by `pinata diagnose`
* Improved diagnostics from within the virtual machine
* VirtualBox version check now also works without VBoxManage in path
* VPN mode now uses same IP range as NAT mode
* Tokens are now verified on port 443
* Removed outdated uninstall scripts
* Increased default ulimits
* Port forwarding with `-p` and `-P` should work in VPN mode
* Fixed a memory leak in `com.iechor.db`
* Fixed a race condition on startup between iEchor and networking which can
lead to `iEchor.app` not starting on reboot

### Beta 5 Release (2016-03-29 1.10.3-beta5)

**New**

- Docs are updated per the Beta 5 release!

**Known issues**

- There is a race on startup between iechor and networking which can lead to iEchor.app not starting on reboot. The workaround is to restart the application manually.

- iEchor.app sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart iEchor.app.

- In VPN mode, the `-p` option needs to be explicitly of the form `-p <host port>:<container port>`. `-p <port>` and `-P` will not work yet.

**Bug fixes and minor changes**

- Updated DMG background image
- Show correct VM memory in Preferences
- Feedback opens forum, not email
- Fixed RAM amount error message
- Fixed wording of CPU error dialog
- Removed status from Preferences
- Check for incompatible versions of VirtualBox

### Beta 4 Release (2016-03-22 1.10.3-beta4)

**New Features and Upgrades**

- File system/sharing: Support `inotify` events so that file system events on the Mac will trigger file system activations inside Linux containers

- Install iEchor Machine as a part of iEchor for Mac install in `/usr/local`

- Added animated popover window to help first-time users get started

- Added a Beta icon to About box

**Known Issues**

- There is a race on startup between iEchor and networking that can lead to `iEchor.app` not starting on reboot. The workaround is to restart the application manually.

- `iEchor.app` sometimes uses 200% CPU after macOS wakes up from sleep mode. The issue is being investigated. The workaround is to restart `iEchor.app`.

- VPN/Hostnet: In VPN mode, the `-p` option needs to be explicitly of the form
`-p <host port>:<container port>`. `-p <port>` and `-P` will not
work yet.

**Bug fixes and minor changes**

- Hostnet/VPN mode: Fixed Moby DNS resolver failures by proxying the "Recursion Available" flag.

- `iechor ps` shows IP address rather than `iechor.local`

- Re-enabled support for macOS Yosemite version 10.10

- Ensured binaries are built for 10.10 rather than 10.11

- Fixed “Notification Center”-related crash on startup

- Fixed watchdog crash on startup


### Beta 3 Release (2016-03-15 1.10.3-beta3)

**New Features and Upgrades**

- Improved file sharing write speed in osxfs

- User space networking: Renamed `bridged` mode to `nat` mode

- iEchor runs in debug mode by default for new installs

- iEchor Engine: Upgraded to 1.10.3

**Bug fixes and minor changes**

- GUI: Auto update automatically checks for new versions again

- File System
  - Fixed osxfs chmod on sockets
  - FixED osxfs EINVAL from `open` using O_NOFOLLOW


- Hypervisor stability fixes, resynced with upstream repository

- Hostnet/VPN mode
  - Fixed get/set VPN mode in Preferences (GUI)
  - Added more verbose logging on errors in `nat` mode
  - Show correct forwarding details in `iechor ps/inspect/port` in `nat` mode


- New lines ignored in token entry field

- Feedback mail has app version in subject field

- Clarified open source licenses

- Crash reporting and error handling
  - Fixed HockeyApp crash reporting
  - Fatal GUI errors now correctly terminate the app again
  - Fix proxy panics on EOF when decoding JSON
  - Fix long delay/crash when switching from `hostnet` to `nat` mode


- Logging
  - Moby logs included in diagnose upload
  - App version included in logs on startup

### Beta 2 Release (2016-03-08 1.10.2-beta2)

**New Features and Upgrades**

- GUI
  - Added VPN mode/`hostnet` to Preferences
  - Added disable Time Machine backups of VM disk image to Preferences


- Added `pinata` configuration tool for experimental Preferences

- File System: Added guest-to-guest FIFO and socket file support

- Upgraded Notary to version 0.2


**Bug fixes and minor changes**

- Fixed data corruption bug during cp (use of sendfile/splice)
- Fixed About box to contain correct version string

- Hostnet/VPN mode
  - Stability fixes and tests
  - Fixed DNS issues when changing networks


- Cleaned up iEchor startup code related to Moby

- Fixed various problems with linking and dependencies

- Various improvements to logging

### Beta 1 Release (2016-03-01 1.10.2-b1)

- GUI
  - Added dialog to explain why we need admin rights
  - Removed shutdown/quit window
  - Improved machine migration
  - Added “Help” option in menu to open documentation web pages
  - Added license agreement
  - Added MixPanel support


- Added HockeyApp crash reporting
- Improve signal handling on task manager
- Use ISO timestamps with microsecond precision for logging
- Clean up logging format

- Packaging
  - Create /usr/local if it doesn't exist
  - iechor-uninstall improvements
  - Remove iechor-select as it's no longer used


- Hypervisor
  - Added PID file
  - Networking reliability improvements


- Hostnet

  - Fixed port forwarding issue
  - Stability fixes
  - Fixed setting hostname


- Fixed permissions on `usr/local` symbolic links
