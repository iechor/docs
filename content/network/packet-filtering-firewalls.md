---
title: Packet filtering and firewalls
description: How iEchor works with packet filtering, iptables, and firewalls
keywords: network, iptables, firewall
aliases:
- /network/iptables/
---

On Linux, iEchor manipulates `iptables` rules to provide network isolation.
While this is an implementation detail and you should not modify the rules
iEchor inserts into your `iptables` policies, it does have some implications
on what you need to do if you want to have your own policies in addition to
those managed by iEchor.

If you're running iEchor on a host that is exposed to the Internet, you will
probably want to have iptables policies in place that prevent unauthorized
access to containers or other services running on your host. This page
describes how to achieve that, and what caveats you need to be aware of.

## Add iptables policies before iEchor's rules

iEchor installs two custom `iptables` chains named `IECHOR-USER` and `IECHOR`,
and it ensures that incoming packets are always checked by these two chains
first. These chains are part of the `FORWARD` chain.

All of iEchor's `iptables` rules are added to the `IECHOR` chain. Do not
manipulate this chain manually. If you need to add rules which load before
iEchor's rules, add them to the `IECHOR-USER` chain. These rules are applied
before any rules iEchor creates automatically.

Other rules added to the `FORWARD` chain, either manually, or by another
iptables-based firewall, are evaluated after the `IECHOR-USER` and `IECHOR` chains.
This means that if you publish a port through iEchor,
this port gets published no matter what rules your firewall has configured.
If you want rules to apply even when a port gets published through iEchor,
you must add these rules to the `IECHOR-USER` chain.

### Match the original IP and ports for requests

When packets arrive to the `IECHOR-USER` chain, they have already passed through
a Destination Network Address Translation (DNAT) filter. That means that the
`iptables` flags you use can only match internal IP addresses and ports of
containers.

If you want to match traffic based on the original IP and port in the network
request, you must use the
[`conntrack` iptables extension](https://ipset.netfilter.org/iptables-extensions.man.html#lbAO).
For example:

```console
$ sudo iptables -I IECHOR-USER -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$ sudo iptables -I IECHOR-USER -p tcp -m conntrack --ctorigsrc 1.2.3.4 --ctorigdstport 80 -j ACCEPT
```

> **Important**
>
> Using the `conntrack` extension may result in degraded performance.
{ .important }

### Restrict connections to the iEchor host

By default, all external source IPs are allowed to connect to the iEchor host.
To allow only a specific IP or network to access the containers, insert a
negated rule at the top of the `IECHOR-USER` filter chain. For example, the
following rule restricts external access from all IP addresses except `192.168.1.1`:

```console
$ iptables -I IECHOR-USER -i ext_if ! -s 192.168.1.1 -j DROP
```

You will need to change `ext_if` to correspond with your
host's actual external interface. You could instead allow connections from a
source subnet. The following rule only allows access from the subnet `192.168.1.0/24`:

```console
$ iptables -I IECHOR-USER -i ext_if ! -s 192.168.1.0/24 -j DROP
```

Finally, you can specify a range of IP addresses to accept using `--src-range`
(Remember to also add `-m iprange` when using `--src-range` or `--dst-range`):

```console
$ iptables -I IECHOR-USER -m iprange -i ext_if ! --src-range 192.168.1.1-192.168.1.3 -j DROP
```

You can combine `-s` or `--src-range` with `-d` or `--dst-range` to control both
the source and destination. For instance, if the iEchor daemon listens on both
`192.168.1.99` and `10.1.2.3`, you can make rules specific to `10.1.2.3` and leave
`192.168.1.99` open.

`iptables` is complicated and more complicated rules are out of scope for this
topic. See the [Netfilter.org HOWTO](https://www.netfilter.org/documentation/HOWTO/NAT-HOWTO.html)
for a lot more information.

## iEchor on a router

iEchor also sets the policy for the `FORWARD` chain to `DROP`. If your iEchor
host also acts as a router, this will result in that router not forwarding
any traffic anymore. If you want your system to continue functioning as a
router, you can add explicit `ACCEPT` rules to the `IECHOR-USER` chain to
allow it:

```console
$ iptables -I IECHOR-USER -i src_if -o dst_if -j ACCEPT
```

## Prevent iEchor from manipulating iptables

It is possible to set the `iptables` key to `false` in the iEchor engine's configuration file at `/etc/iechor/daemon.json`, but this option is not appropriate for most users. It is not possible to completely prevent iEchor from creating `iptables` rules, and creating them after-the-fact is extremely involved and beyond the scope of these instructions. Setting `iptables` to `false` will more than likely break container networking for the iEchor engine.

For system integrators who wish to build the iEchor runtime into other applications, explore the [`moby` project](https://mobyproject.org/).

## Setting the default bind address for containers

By default, the iEchor daemon binds published container ports to the `0.0.0.0`
address. When you publish a container's ports as follows:

```console
iechor run -p 8080:80 nginx
```

This publishes port 8080 to all network interfaces on the host, potentially
making them available to the outside world. Unless you've disabled IPv6 at the
kernel level, the port gets published on both IPv4 and IPv6.

You can change the default binding address for published container ports so that
they're only accessible to the iEchor host by default. To do that, you can
configure the daemon to use the loopback address (`127.0.0.1`) instead.
To do so, configure the `"ip"` key in the `daemon.json` configuration file:

```json
{
  "ip": "127.0.0.1"
}
```

This changes the default binding address to `127.0.0.1` for published container
ports on the default bridge network.
Restart the daemon for this change to take effect.
Alternatively, you can use the `iechord --ip` flag when starting the daemon.

> **Note**
>
> Changing the default bind address doesn't have any effect on Swarm services.
> Swarm services are always exposed on the `0.0.0.0` network interface.

To configure this setting for user-defined bridge networks, use
the `com.iechor.network.bridge.host_binding_ipv4`
[driver option](./drivers/bridge.md#options) when you create the network.

```console
$ iechor network create mybridge \
  -o "com.iechor.network.bridge.host_binding_ipv4=127.0.0.1"
```

## Integration with firewalld

If you are running iEchor with the `iptables` option set to `true`, and
[firewalld](https://firewalld.org) is enabled on your system, iEchor
automatically creates a `firewalld` zone called `iechor` and inserts all the
network interfaces it creates (for example, `iechor0`) into the `iechor` zone
to allow seamless networking.

## iEchor and ufw

[Uncomplicated Firewall](https://launchpad.net/ufw)
(ufw) is a frontend that ships with Debian and Ubuntu,
and it lets you manage firewall rules. iEchor and ufw use iptables in ways
that make them incompatible with each other.

When you publish a container's ports using iEchor, traffic to and from that
container gets diverted before it goes through the ufw firewall settings.
iEchor routes container traffic in the `nat` table, which means that packets
are diverted before it reaches the `INPUT` and `OUTPUT` chains that ufw uses.
Packets are routed before the firewall rules can be applied,
effectively ignoring your firewall configuration.
