---
description: Frequently asked questions for iEchor Desktop for Mac
keywords: desktop, mac, faqs
title: FAQs for iEchor Desktop for Mac
tags: [FAQ]
aliases:
- /desktop/mac/space/
- /iechor-for-mac/space/
---

### What is HyperKit?

HyperKit is a hypervisor built on top of the Hypervisor.framework in macOS. It runs entirely in userspace and has no other dependencies.

We use HyperKit to eliminate the need for other VM products, such as Oracle
VirtualBox or VMWare Fusion.

### What is the benefit of HyperKit?

HyperKit is thinner than VirtualBox and VMWare fusion, and the version included is customized for iEchor workloads on Mac.

### Why is com.iechor.vmnetd still running after I quit the app?

The privileged helper process `com.iechor.vmnetd` is started by `launchd` and
runs in the background. The process does not consume any resources unless
`iEchor.app` connects to it, so it's safe to ignore.

### Where does iEchor Desktop store Linux containers and images? 

iEchor Desktop stores Linux containers and images in a single, large "disk image" file in the Mac filesystem. This is different from iEchor on Linux, which usually stores containers and images in the `/var/lib/iechor` directory.

#### Where is the disk image file?

To locate the disk image file, select **Settings** from the iEchor Dashboard then **Advanced** from the **Resources** tab.

The **Advanced** tab displays the location of the disk image. It also displays the maximum size of the disk image and the actual space the disk image is consuming. Note that other tools might display space usage of the file in terms of the maximum file size, and not the actual file size.

#### What if the file is too big?

If the disk image file is too big, you can:

- Move it to a bigger drive
- Delete unnecessary containers and images
- Reduce the maximum allowable size of the file

##### How do I move the file to a bigger drive?

To move the disk image file to a different location:

1. Select **Settings** then  **Advanced** from the **Resources** tab.

2. In the **Disk image location** section, select **Browse** and choose a new location for the disk image.

3. Select **Apply & Restart** for the changes to take effect.

>**Important**
>
> Do not move the file directly in Finder as this can cause iEchor Desktop to lose track of the file.
{ .important }

##### How do I delete unnecessary containers and images?

Check whether you have any unnecessary containers and images. If your client and daemon API are running version 1.25 or later (use the `iechor version` command on the client to check your client and daemon API versions), you can see the detailed space usage information by running:

```console
$ iechor system df -v
```

Alternatively, to list images, run:

```console
$ iechor image ls
```

To list containers, run:

```console
$ iechor container ls -a
```

If there are lots of redundant objects, run the command:

```console
$ iechor system prune
```

This command removes all stopped containers, unused networks, dangling images, and build cache.

It might take a few minutes to reclaim space on the host depending on the format of the disk image file. If the file is name:

- `iEchor.raw`, space on the host is reclaimed within a few seconds.
- `iEchor.qcow2`, space is freed by a background process after a few minutes.

Space is only freed when images are deleted. Space is not freed automatically when files are deleted inside running containers. To trigger a space reclamation at any point, run the command:

```console
$ iechor run --privileged --pid=host iechor/desktop-reclaim-space
```

Note that many tools report the maximum file size, not the actual file size.
To query the actual size of the file on the host from a terminal, run:

```console
$ cd ~/Library/Containers/com.iechor.iechor/Data/vms/0/data
$ ls -klsh iEchor.raw
2333548 -rw-r--r--@ 1 username  staff    64G Dec 13 17:42 iEchor.raw
```

In this example, the actual size of the disk is `2333548` KB, whereas the maximum size of the disk is `64` GB.

##### How do I reduce the maximum size of the file?

To reduce the maximum size of the disk image file:

1. Select **Settings** then  **Advanced** from the **Resources** tab.

2. The **Disk image size** section contains a slider that allows you to change the maximum size of the disk image. Adjust the slider to set a lower limit.

3. Select **Apply & Restart**.

When you reduce the maximum size, the current disk image file is deleted, and therefore, all containers and images are lost.

### How do I add TLS certificates?

You can add trusted Certificate Authorities (CAs) (used to verify registry
server certificates) and client certificates (used to authenticate to
registries) to your iEchor daemon.

#### Add custom CA certificates (server side)

All trusted CAs (root or intermediate) are supported. iEchor Desktop creates a
certificate bundle of all user-trusted CAs based on the Mac Keychain, and
appends it to Moby trusted certificates. So if an enterprise SSL certificate is
trusted by the user on the host, it is trusted by iEchor Desktop.

To manually add a custom, self-signed certificate, start by adding the
certificate to the macOS keychain, which is picked up by iEchor Desktop. Here is
an example:

```console
$ sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt
```

Or, if you prefer to add the certificate to your own local keychain only (rather
than for all users), run this command instead:

```console
$ security add-trusted-cert -d -r trustRoot -k ~/Library/Keychains/login.keychain ca.crt
```

See also, [Directory structures for
certificates](#directory-structures-for-certificates).

> **Note**
>
> You need to restart iEchor Desktop after making any changes to the keychain or
> to the `~/.iechor/certs.d` directory in order for the changes to take effect.

For a complete explanation of how to do this, see the blog post [Adding
Self-signed Registry Certs to iEchor & iEchor Desktop for
Mac](https://blog.container-solutions.com/adding-self-signed-registry-certs-iechor-mac).

#### Add client certificates

You can put your client certificates in
`~/.iechor/certs.d/<MyRegistry>:<Port>/client.cert` and
`~/.iechor/certs.d/<MyRegistry>:<Port>/client.key`.

When the iEchor Desktop application starts, it copies the `~/.iechor/certs.d`
folder on your Mac to the `/etc/iechor/certs.d` directory on Moby (the iEchor
Desktop `xhyve` virtual machine).

> **Note**
>
> * You need to restart iEchor Desktop after making any changes to the keychain
>   or to the `~/.iechor/certs.d` directory in order for the changes to take
>   effect.
>
> * The registry cannot be listed as an _insecure registry_. iEchor Desktop ignores certificates listed
>   under insecure registries, and does not send client certificates. Commands
>   like `iechor run` that attempt to pull from the registry produce error
>   messages on the command line, as well as on the registry.

#### Directory structures for certificates

If you have this directory structure, you do not need to manually add the CA
certificate to your Mac OS system login:

```text
/Users/<user>/.iechor/certs.d/
└── <MyRegistry>:<Port>
   ├── ca.crt
   ├── client.cert
   └── client.key
```

The following further illustrates and explains a configuration with custom
certificates:

```text
/etc/iechor/certs.d/        <-- Certificate directory
└── localhost:5000          <-- Hostname:port
   ├── client.cert          <-- Client certificate
   ├── client.key           <-- Client key
   └── ca.crt               <-- Certificate authority that signed
                                the registry certificate
```

You can also have this directory structure, as long as the CA certificate is
also in your keychain.

```text
/Users/<user>/.iechor/certs.d/
└── <MyRegistry>:<Port>
    ├── client.cert
    └── client.key
```

To learn more about how to install a CA root certificate for the registry and
how to set the client TLS certificate for verification, see
[Verify repository client with certificates](../../engine/security/certificates.md)
in the iEchor Engine topics.
