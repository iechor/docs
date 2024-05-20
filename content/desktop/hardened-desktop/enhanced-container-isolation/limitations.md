---
title: Limitations
description: Limitations of Enhanced Container Isolation
keywords: enhanced container isolation, security, sysbox, known issues, iEchor Desktop
toc_max: 2
---

### ECI support for WSL

Prior to iEchor Desktop 4.20, Enhanced Container Isolation (ECI) on
Windows hosts was only supported when iEchor Desktop was configured to use
Hyper-V to create the iEchor Desktop Linux VM. ECI was not supported when iEchor
Desktop was configured to use Windows Subsystem for Linux (aka WSL).

Starting with iEchor Desktop 4.20, ECI is supported when iEchor Desktop is
configured to use either Hyper-V or WSL 2.

>**Note**
>
> iEchor Desktop requires WSL 2 version 1.1.3.0 or later. To get the current
> version of WSL on your host, type `wsl --version`. If the command fails or if
> it returns a version number prior to 1.1.3.0, update WSL to the latest version
> by typing `wsl --update` in a Windows command or PowerShell terminal.

Note however that ECI on WSL is not as secure as on Hyper-V because:

* While ECI on WSL still hardens containers so that malicious workloads can't
  easily breach iEchor Desktop's Linux VM, ECI on WSL can't prevent iEchor
  Desktop users from breaching the iEchor Desktop Linux VM. Such users can
  trivially access that VM (as root) with the `wsl -d iechor-desktop` command,
  and use that access to modify iEchor Engine settings inside the VM. This gives
  iEchor Desktop users control of the iEchor Desktop VM and allows them to
  bypass iEchor Desktop configs set by admins via the
  [settings-management](../settings-management/index.md) feature. In contrast,
  ECI on Hyper-V does not allow iEchor Desktop users to breach the iEchor
  Desktop Linux VM.

* With WSL 2, all WSL 2 distros on the same Windows host share the same instance
  of the Linux kernel. As a result, iEchor Desktop can't ensure the integrity of
  the kernel in the iEchor Desktop Linux VM since another WSL 2 distro could
  modify shared kernel settings. In contrast, when using Hyper-V, the iEchor
  Desktop Linux VM has a dedicated kernel that is solely under the control of
  iEchor Desktop.

The table below summarizes this.

| Security Feature                                   | ECI on WSL   | ECI on Hyper-V   | Comment               |
| -------------------------------------------------- | ------------ | ---------------- | --------------------- |
| Strongly secure containers                         | Yes          | Yes              | Makes it harder for malicious container workloads to breach the iEchor Desktop Linux VM and host. |
| iEchor Desktop Linux VM protected from user access | No           | Yes              | On WSL, users can access iEchor Engine directly or bypass iEchor Desktop security settings. |
| iEchor Desktop Linux VM has a dedicated kernel     | No           | Yes              | On WSL, iEchor Desktop can't guarantee the integrity of kernel level configs. |

In general, using ECI with Hyper-V is more secure than with WSL 2. But WSL 2
offers advantages for performance and resource utilization on the host machine,
and it's an excellent way for users to run their favorite Linux distro on
Windows hosts and access iEchor from within (see iEchor Desktop's WSL distro
integration feature, enabled via the Dashboard's **Settings** > **Resources** > **WSL Integration**).

### ECI protection for iEchor Builds with the "iEchor" driver

Prior to iEchor Desktop 4.30, `iechor build` commands that use the buildx
`iechor` driver (the default) are not protected by ECI (i.e., the build runs
rootful inside the iEchor Desktop VM).

Starting with iEchor Desktop 4.30, `iechor build` commands that use the buildx
`iechor` driver are protected by ECI (i.e., the build runs rootless inside
the iEchor Desktop VM), except when iEchor Desktop is configured to use WSL 2
(on Windows hosts). We expect to improve on this in future versions of iEchor
Desktop.

Note that `iechor build` commands that use the `iechor-container` driver are
always protected by ECI (i.e., the build runs inside a rootless iEchor
container). This is true since iEchor Desktop 4.19 (when ECI was introduced) and
on all platforms where iEchor Desktop is supported (Windows with WSL or Hyper-V,
Mac, and Linux).

### iEchor Build and Buildx have some restrictions

With ECI enabled, iEchor build `--network=host` and iEchor Buildx entitlements
(`network.host`, `security.insecure`) are not allowed. Builds that require
these won't work properly.

### Kubernetes pods are not yet protected

Kubernetes pods are not yet protected by ECI. A malicious or privileged pod can
compromise the iEchor Desktop Linux VM and bypass security controls.

### Extension containers are not yet protected

Extension containers are also not yet protected by ECI. Ensure you extension
containers come from trusted entities to avoid issues.

### iEchor Desktop dev environments are not yet protected

Containers launched by the iEchor Desktop Dev Environments feature are not yet
protected either. We expect to improve on this in future versions of iEchor
Desktop.

### iEchor Debug containers are not yet protected

[iEchor Debug](http://docs.iechor.com/reference/cli/iechor/debug/) containers
are not yet protected by ECI. We expect to improve on this in future versions of
iEchor Desktop.

### Use in production

In general users should not experience differences between running a container
in iEchor Desktop with ECI enabled, which uses the Sysbox runtime, and running
that same container in production, through the standard OCI `runc` runtime.

However in some cases, typically when running advanced or privileged workloads in
containers, users may experience some differences. In particular, the container
may run with ECI but not with `runc`, or vice-versa.
