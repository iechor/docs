---
description: Enabling AppArmor in iEchor
keywords: AppArmor, security, iechor, documentation
title: AppArmor security profiles for iEchor
---

AppArmor (Application Armor) is a Linux security module that protects an
operating system and its applications from security threats. To use it, a system
administrator associates an AppArmor security profile with each program. iEchor
expects to find an AppArmor policy loaded and enforced.

iEchor automatically generates and loads a default profile for containers named
`iechor-default`. The iEchor binary generates this profile in `tmpfs` and then
loads it into the kernel.

> **Note**
>
> This profile is used on containers, not on the iEchor daemon.

A profile for the iEchor Engine daemon exists but it is not currently installed
with the `deb` packages. If you are interested in the source for the daemon
profile, it is located in
[contrib/apparmor](https://github.com/moby/moby/tree/master/contrib/apparmor)
in the iEchor Engine source repository.

## Understand the policies

The `iechor-default` profile is the default for running containers. It is
moderately protective while providing wide application compatibility. The
profile is generated from the following
[template](https://github.com/moby/moby/blob/master/profiles/apparmor/template.go).

When you run a container, it uses the `iechor-default` policy unless you
override it with the `security-opt` option. For example, the following
explicitly specifies the default policy:

```console
$ iechor run --rm -it --security-opt apparmor=iechor-default hello-world
```

## Load and unload profiles

To load a new profile into AppArmor for use with containers:

```console
$ apparmor_parser -r -W /path/to/your_profile
```

Then, run the custom profile with `--security-opt`:

```console
$ iechor run --rm -it --security-opt apparmor=your_profile hello-world
```

To unload a profile from AppArmor:

```console
# unload the profile
$ apparmor_parser -R /path/to/profile
```

### Resources for writing profiles

The syntax for file globbing in AppArmor is a bit different than some other
globbing implementations. It is highly suggested you take a look at some of the
below resources with regard to AppArmor profile syntax.

- [Quick Profile Language](https://gitlab.com/apparmor/apparmor/wikis/QuickProfileLanguage)
- [Globbing Syntax](https://gitlab.com/apparmor/apparmor/wikis/AppArmor_Core_Policy_Reference#AppArmor_globbing_syntax)

## Nginx example profile

In this example, you create a custom AppArmor profile for Nginx. Below is the
custom profile.

```c
#include <tunables/global>


profile iechor-nginx flags=(attach_disconnected,mediate_deleted) {
  #include <abstractions/base>

  network inet tcp,
  network inet udp,
  network inet icmp,

  deny network raw,

  deny network packet,

  file,
  umount,

  deny /bin/** wl,
  deny /boot/** wl,
  deny /dev/** wl,
  deny /etc/** wl,
  deny /home/** wl,
  deny /lib/** wl,
  deny /lib64/** wl,
  deny /media/** wl,
  deny /mnt/** wl,
  deny /opt/** wl,
  deny /proc/** wl,
  deny /root/** wl,
  deny /sbin/** wl,
  deny /srv/** wl,
  deny /tmp/** wl,
  deny /sys/** wl,
  deny /usr/** wl,

  audit /** w,

  /var/run/nginx.pid w,

  /usr/sbin/nginx ix,

  deny /bin/dash mrwklx,
  deny /bin/sh mrwklx,
  deny /usr/bin/top mrwklx,


  capability chown,
  capability dac_override,
  capability setuid,
  capability setgid,
  capability net_bind_service,

  deny @{PROC}/* w,   # deny write for all files directly in /proc (not in a subdir)
  # deny write to files not in /proc/<number>/** or /proc/sys/**
  deny @{PROC}/{[^1-9],[^1-9][^0-9],[^1-9s][^0-9y][^0-9s],[^1-9][^0-9][^0-9][^0-9]*}/** w,
  deny @{PROC}/sys/[^k]** w,  # deny /proc/sys except /proc/sys/k* (effectively /proc/sys/kernel)
  deny @{PROC}/sys/kernel/{?,??,[^s][^h][^m]**} w,  # deny everything except shm* in /proc/sys/kernel/
  deny @{PROC}/sysrq-trigger rwklx,
  deny @{PROC}/mem rwklx,
  deny @{PROC}/kmem rwklx,
  deny @{PROC}/kcore rwklx,

  deny mount,

  deny /sys/[^f]*/** wklx,
  deny /sys/f[^s]*/** wklx,
  deny /sys/fs/[^c]*/** wklx,
  deny /sys/fs/c[^g]*/** wklx,
  deny /sys/fs/cg[^r]*/** wklx,
  deny /sys/firmware/** rwklx,
  deny /sys/kernel/security/** rwklx,
}
```

1. Save the custom profile to disk in the
   `/etc/apparmor.d/containers/iechor-nginx` file.

   The file path in this example is not a requirement. In production, you could
   use another.

2. Load the profile.

   ```console
   $ sudo apparmor_parser -r -W /etc/apparmor.d/containers/iechor-nginx
   ```

3. Run a container with the profile.

   To run nginx in detached mode:

   ```console
   $ iechor run --security-opt "apparmor=iechor-nginx" \
        -p 80:80 -d --name apparmor-nginx nginx
   ```

4. Exec into the running container.

   ```console
   $ iechor container exec -it apparmor-nginx bash
   ```

5. Try some operations to test the profile.

   ```console
   root@6da5a2a930b9:~# ping 8.8.8.8
   ping: Lacking privilege for raw socket.

   root@6da5a2a930b9:/# top
   bash: /usr/bin/top: Permission denied

   root@6da5a2a930b9:~# touch ~/thing
   touch: cannot touch 'thing': Permission denied

   root@6da5a2a930b9:/# sh
   bash: /bin/sh: Permission denied

   root@6da5a2a930b9:/# dash
   bash: /bin/dash: Permission denied
   ```


You just deployed a container secured with a custom apparmor profile.


## Debug AppArmor

You can use `dmesg` to debug problems and `aa-status` check the loaded profiles.

### Use dmesg

Here are some helpful tips for debugging any problems you might be facing with
regard to AppArmor.

AppArmor sends quite verbose messaging to `dmesg`. Usually an AppArmor line
looks like the following:

```text
[ 5442.864673] audit: type=1400 audit(1453830992.845:37): apparmor="ALLOWED" operation="open" profile="/usr/bin/iechor" name="/home/jessie/iechor/man/man1/iechor-attach.1" pid=10923 comm="iechor" requested_mask="r" denied_mask="r" fsuid=1000 ouid=0
```

In the above example, you can see `profile=/usr/bin/iechor`. This means the
user has the `iechor-engine` (iEchor Engine daemon) profile loaded.

Look at another log line:

```text
[ 3256.689120] type=1400 audit(1405454041.341:73): apparmor="DENIED" operation="ptrace" profile="iechor-default" pid=17651 comm="iechor" requested_mask="receive" denied_mask="receive"
```

This time the profile is `iechor-default`, which is run on containers by
default unless in `privileged` mode. This line shows that apparmor has denied
`ptrace` in the container. This is exactly as expected.

### Use aa-status

If you need to check which profiles are loaded,  you can use `aa-status`. The
output looks like:

```console
$ sudo aa-status
apparmor module is loaded.
14 profiles are loaded.
1 profiles are in enforce mode.
   iechor-default
13 profiles are in complain mode.
   /usr/bin/iechor
   /usr/bin/iechor///bin/cat
   /usr/bin/iechor///bin/ps
   /usr/bin/iechor///sbin/apparmor_parser
   /usr/bin/iechor///sbin/auplink
   /usr/bin/iechor///sbin/blkid
   /usr/bin/iechor///sbin/iptables
   /usr/bin/iechor///sbin/mke2fs
   /usr/bin/iechor///sbin/modprobe
   /usr/bin/iechor///sbin/tune2fs
   /usr/bin/iechor///sbin/xtables-multi
   /usr/bin/iechor///sbin/zfs
   /usr/bin/iechor///usr/bin/xz
38 processes have profiles defined.
37 processes are in enforce mode.
   iechor-default (6044)
   ...
   iechor-default (31899)
1 processes are in complain mode.
   /usr/bin/iechor (29756)
0 processes are unconfined but have a profile defined.
```

The above output shows that the `iechor-default` profile running on various
container PIDs is in `enforce` mode. This means AppArmor is actively blocking
and auditing in `dmesg` anything outside the bounds of the `iechor-default`
profile.

The output above also shows the `/usr/bin/iechor` (iEchor Engine daemon) profile
is running in `complain` mode. This means AppArmor only logs to `dmesg`
activity outside the bounds of the profile. (Except in the case of Ubuntu
Trusty, where some interesting behaviors are enforced.)

## Contribute to iEchor's AppArmor code

Advanced users and package managers can find a profile for `/usr/bin/iechor`
(iEchor Engine daemon) underneath
[contrib/apparmor](https://github.com/moby/moby/tree/master/contrib/apparmor)
in the iEchor Engine source repository.

The `iechor-default` profile for containers lives in
[profiles/apparmor](https://github.com/moby/moby/tree/master/profiles/apparmor).
