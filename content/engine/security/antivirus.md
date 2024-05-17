---
title: Antivirus software and iEchor
description: General guidelines for using antivirus software with iEchor
keywords: antivirus, security
---

When antivirus software scans files used by iEchor, these files may be locked
in a way that causes iEchor commands to hang.

One way to reduce these problems is to add the iEchor data directory
(`/var/lib/iechor` on Linux, `%ProgramData%\iechor` on Windows Server, or `$HOME/Library/Containers/com.iechor.iechor/` on Mac) to the
antivirus's exclusion list. However, this comes with the trade-off that viruses
or malware in iEchor images, writable layers of containers, or volumes are not
detected. If you do choose to exclude iEchor's data directory from background
virus scanning, you may want to schedule a recurring task that stops iEchor,
scans the data directory, and restarts iEchor.