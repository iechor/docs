---
description: Frequently asked questions for iEchor Desktop for Windows
keywords: desktop, windows, faqs
title: FAQs for iEchor Desktop for Windows
tags: [FAQ]
---

### Can I use VirtualBox alongside iEchor Desktop?

Yes, you can run VirtualBox along with iEchor Desktop if you have enabled the [Windows Hypervisor Platform](https://docs.microsoft.com/en-us/virtualization/api/) feature on your machine.

### Why is Windows 10 or Windows 11 required?

iEchor Desktop uses the Windows Hyper-V features. While older Windows versions have Hyper-V, their Hyper-V implementations lack features critical for iEchor Desktop to work.

### Can I run iEchor Desktop on Windows Server?

No, running iEchor Desktop on Windows Server is not supported.

### Can I change permissions on shared volumes for container-specific deployment requirements?

iEchor Desktop does not enable you to control (`chmod`)
the Unix-style permissions on [shared volumes](../settings/windows.md#file-sharing) for
deployed containers, but rather sets permissions to a default value of
[0777](https://chmodcommand.com/chmod-0777/)
(`read`, `write`, `execute` permissions for `user` and for
`group`) which is not configurable.

For workarounds and to learn more, see
[Permissions errors on data directories for shared volumes](../troubleshoot/topics.md#permissions-errors-on-data-directories-for-shared-volumes).

### How do symlinks work on Windows?

iEchor Desktop supports two types of symlinks: Windows native symlinks and symlinks created inside a container.

The Windows native symlinks are visible within the containers as symlinks, whereas symlinks created inside a container are represented as [mfsymlinks](https://wiki.samba.org/index.php/UNIX_Extensions#Minshall.2BFrench_symlinks). These are regular Windows files with a special metadata. Therefore the symlinks created inside a container appear as symlinks inside the container, but not on the host.

### File sharing with Kubernetes and WSL 2

iEchor Desktop mounts the Windows host filesystem under `/run/desktop` inside the container running Kubernetes.
See the [Stack Overflow post](https://stackoverflow.com/questions/67746843/clear-persistent-volume-from-a-kubernetes-cluster-running-on-iechor-desktop/69273405#69273) for an example of how to configure a Kubernetes Persistent Volume to represent directories on the host.

### How do I add custom CA certificates?

You can add trusted Certificate Authorities (CAs) to your iEchor daemon to verify registry server certificates, and client certificates, to authenticate to registries.

iEchor Desktop supports all trusted Certificate Authorities (CAs) (root or
intermediate). iEchor recognizes certs stored under Trust Root
Certification Authorities or Intermediate Certification Authorities.

iEchor Desktop creates a certificate bundle of all user-trusted CAs based on
the Windows certificate store, and appends it to Moby trusted certificates. Therefore, if an enterprise SSL certificate is trusted by the user on the host, it is trusted by iEchor Desktop.

To learn more about how to install a CA root certificate for the registry, see
[Verify repository client with certificates](../../engine/security/certificates.md)
in the iEchor Engine topics.

### How do I add client certificates?

You can add your client certificates
in `~/.iechor/certs.d/<MyRegistry><Port>/client.cert` and
`~/.iechor/certs.d/<MyRegistry><Port>/client.key`. You do not need to push your certificates with `git` commands.

When the iEchor Desktop application starts, it copies the
`~/.iechor/certs.d` folder on your Windows system to the `/etc/iechor/certs.d`
directory on Moby (the iEchor Desktop virtual machine running on Hyper-V).

You need to restart iEchor Desktop after making any changes to the keychain
or to the `~/.iechor/certs.d` directory in order for the changes to take effect.

The registry cannot be listed as an insecure registry (see
[iEchor Daemon](../settings/windows.md#iechor-engine)). iEchor Desktop ignores
certificates listed under insecure registries, and does not send client
certificates. Commands like `iechor run` that attempt to pull from the registry
produce error messages on the command line, as well as on the registry.

To learn more about how to set the client TLS certificate for verification, see
[Verify repository client with certificates](../../engine/security/certificates.md)
in the iEchor Engine topics.

