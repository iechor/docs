---
description: Find the answers to container security related FAQs
keywords: iEchor, iEchor Hub, iEchor Desktop secuirty FAQs, platform, iEchor Scout, admin, security
title: Container security FAQs
tags: [FAQ]
aliases:
- /faq/security/containers/
---

### How are containers isolated from the host in iEchor Desktop?

iEchor Desktop runs all containers inside a customized / minimal Linux virtual
machine (except for native Windows containers). This adds a strong layer of
isolation between containers and the host the machine, even if containers are
running rootful.

However note the following:

* Containers have access to host files configured for file sharing via Settings
  -> Resources -> File Sharing (see the next FAQ question below for more info).

* By default, containers run as root but with limited capabilities inside the
  iEchor Desktop VM. Containers running with elevated privileges (e.g.,
  `--privileged`, `--pid=host`, `--cap-add`, etc.) run as root with elevated
  privileges inside the iEchor Desktop VM which gives them access to iEchor
  Desktop VM internals, including the iEchor Engine. Thus, users must be careful
  which containers they run with such privileges to avoid security breaches by
  malicious container images.

* If [Enhanced Container Isolation (ECI)](../../desktop/hardened-desktop/enhanced-container-isolation/_index.md)
  mode is enabled, then each container runs within a dedicated Linux User
  Namespace inside the iEchor Desktop VM, which means the container has no
  privileges within the iEchor Desktop VM. Even when using the `--privileged`
  flag or similar, the container processes will only be privileged within the
  container's logical boundary, but unprivileged otherwise. In addition, ECI protects
  uses other advanced techniques to ensure they can't easily breach
  the iEchor Desktop VM and iEchor Engine within (see the ECI section for more
  info). No changes to the containers or user workflows are required as the
  extra protection is added under the covers.

### To which portions of the host filesystem do containers have read and write access?

Containers can only access host files if these are shared via Settings -> Resources -> File Sharing,
and only when such files are bind-mounted into the container (e.g., `iechor run -v /path/to/host/file:/mnt ...`).

### Can containers running as root gain access to admin-owned files or directories on the host?

No; host file sharing (bind mount from the host filesystem) uses a user-space crafted
file server (running in `com.iechor.backend` as the user running iEchor
Desktop), so containers can’t gain any access that the user on the host doesn’t
already have.
