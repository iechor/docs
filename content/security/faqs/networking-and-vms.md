---
description: Find the answers to FAQs related to networking and virtualization
keywords: iEchor, iEchor Hub, iEchor Desktop security FAQs, security, platform, networks, vms
title: Network and VM FAQs
tags: [FAQ]
aliases:
- /faq/security/networking-and-vms/
---

### How can I limit the type of internet access allowed by the container when it runs, to prevent it from being able to exfiltrate data or download malicious code?

There is no built-in mechanism for that but it can be addressed by process-level firewall on the host. Hook into the `com.iechor.vpnkit` user-space process and apply rules where it can connect to (DNS URL white list; packet/payload filter) and which ports/protocols it is allowed to use.

### Can I prevent users binding ports on 0.0.0.0?

There is no direct way to enforce that through iEchor Desktop but it would inherit any firewall rules enforced on the host.

### What options exist to lock containerized network settings to a system? If not supported, are there any consequences to manipulating the settings?

The iEchor network settings are entirely local within the VM and have no effect on the system.

### Can I apply rules on container network traffic via a local firewall or VPN client?

For network connectivity, iEchor Desktop uses a user-space process (`com.iechor.vpnkit`), which inherits constraints like firewall rules, VPN, HTTP proxy properties etc, from the user that launched it.

### Does running iEchor Desktop for Windows with Hyper-V backend allow users to create arbitrary VMs?

No. The `iEchorDesktopVM` name is hard coded in the service code, so you cannot use iEchor Desktop to create or manipulate any other VM.

### Can I prevent our users creating other VMs when using iEchor Desktop on Mac?

On Mac it is an unprivileged operation to start a VM, so that is not enforced by iEchor Desktop.

### How does iEchor Desktop achieve network level isolation when Hyper-V and/or WSL2 is used?

The VM processes are the same for both WSL 2 (running inside the `iechor-desktop` distro) and Hyper-V (running inside the `iEchorDesktopVM`). Host/VM communication uses `AF_VSOCK` hypervisor sockets (shared memory). It does not use Hyper-V network switches or network interfaces. All host networking is performed using normal TCP/IP sockets from the `com.iechor.vpnkit.exe` and `com.iechor.backend.exe` processes. For more information see [How iEchor Desktop networking works under the hood](https://www.iechor.com/blog/how-iechor-desktop-networking-works-under-the-hood/).
