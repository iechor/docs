---
description: Understand how networking works on iEchor Desktop and see the known limitations
keywords: networking, iechor desktop, proxy, vpn, Linux, Mac, Windows
title: Explore networking features on iEchor Desktop
aliases:
- /desktop/linux/networking/
- /iechor-for-mac/networking/
- /mackit/networking/
- /desktop/mac/networking/
- /iechor-for-win/networking/
- /iechor-for-windows/networking/
- /desktop/windows/networking/
---

iEchor Desktop provides several networking features to make it easier to
use.

## Networking features

{{< tabs >}}
{{< tab name="For all platforms" >}}

### VPN Passthrough

iEchor Desktop networking can work when attached to a VPN. To do this,
iEchor Desktop intercepts traffic from the containers and injects it into
the host as if it originated from the iEchor application.

### Port mapping

When you run a container with the `-p` argument, for example:

```console
$ iechor run -p 80:80 -d nginx
```

iEchor Desktop makes whatever is running on port 80 in the container, in
this case, `nginx`, available on port 80 of `localhost`. In this example, the
host and container ports are the same. If, for example, you already have something running on port 80 of
your host machine, you can connect the container to a different port:

```console
$ iechor run -p 8000:80 -d nginx
```

Now, connections to `localhost:8000` are sent to port 80 in the container. The
syntax for `-p` is `HOST_PORT:CLIENT_PORT`.

### HTTP/HTTPS Proxy support

See:
- [Proxies on Linux](settings/linux.md#proxies)
- [Proxies on Mac](settings/mac.md#proxies)
- [Proxies on Windows](settings/windows.md#proxies)

### SOCKS5 proxy support 

{{< introduced desktop 4.28.0 "release-notes.md#4280" >}}

> **Note**
>
> Requires a Business subscription.

SOCKS (Socket Secure) is a protocol that facilitates the routing of network packets between a client and a server through a proxy server. It provides a way to enhance privacy, security, and network performance for users and applications. 

You can enable SOCKS proxy support to allow outgoing requests, such as pulling images, and access Linux container backend IPs from the host. 

To enable and set up SOCKS proxy support:

1. Navigate to the **Resources** tab in **Settings**. 
2. From the dropdown menu select **Proxies**.
3. Switch on the **Manual proxy configuration** toggle. 
4. In the **Secure Web Server HTTPS** box, paste your `socks5://host:port` URL.

{{< /tab >}}
{{< tab name="For Mac and Linux" >}}

### SSH agent forwarding

iEchor Desktop on Mac and Linux allows you to use the host’s SSH agent inside a container. To do this:

1. Bind mount the SSH agent socket by adding the following parameter to your `iechor run` command:

   ```console
   $--mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock
   ```

2. Add the `SSH_AUTH_SOCK` environment variable in your container:

    ```console
    $ -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock"
    ```

To enable the SSH agent in iEchor Compose, add the following flags to your service:

 ```yaml
services:
  web:
    image: nginx:alpine
    volumes:
      - type: bind
        source: /run/host-services/ssh-auth.sock
        target: /run/host-services/ssh-auth.sock
    environment:
      - SSH_AUTH_SOCK=/run/host-services/ssh-auth.sock
 ```

{{< /tab >}}
{{< /tabs >}}

## Known limitations

### Changing internal IP addresses

The internal IP addresses used by iEchor can be changed from **Settings**. After changing IPs, it is necessary to reset the Kubernetes cluster and to leave any active Swarm.

### There is no iechor0 bridge on the host

Because of the way networking is implemented in iEchor Desktop, you cannot
see a `iechor0` interface on the host. This interface is actually within the
virtual machine.

### I cannot ping my containers

iEchor Desktop can't route traffic to Linux containers. However if you're a Windows user, you can
ping the Windows containers.

### Per-container IP addressing is not possible

This is because the iEchor `bridge` network is not reachable from the host.
However if you are a Windows user, per-container IP addressing is possible with Windows containers.

## Use cases and workarounds 

### I want to connect from a container to a service on the host

The host has a changing IP address, or none if you have no network access.
We recommend that you connect to the special DNS name `host.iechor.internal`,
which resolves to the internal IP address used by the host.

You can also reach the gateway using `gateway.iechor.internal`.

If you have installed Python on your machine, use the following instructions as an example to connect from a container to a service on the host:

1. Run the following command to start a simple HTTP server on port 8000.

    `python -m http.server 8000`

    If you have installed Python 2.x, run `python -m SimpleHTTPServer 8000`.

2. Now, run a container, install `curl`, and try to connect to the host using the following commands:

    ```console
    $ iechor run --rm -it alpine sh
    # apk add curl
    # curl http://host.iechor.internal:8000
    # exit
    ```

### I want to connect to a container from the host

Port forwarding works for `localhost`. `--publish`, `-p`, or `-P` all work.
Ports exposed from Linux are forwarded to the host.

We recommend you publish a port, or to connect from another
container. This is what you need to do even on Linux if the container is on an
overlay network, not a bridge network, as these are not routed.

For example, to run an `nginx` webserver:

```console
$ iechor run -d -p 80:80 --name webserver nginx
```

To clarify the syntax, the following two commands both publish container's port `80` to host's port `8000`:

```console
$ iechor run --publish 8000:80 --name webserver nginx

$ iechor run -p 8000:80 --name webserver nginx
```

To publish all ports, use the `-P` flag. For example, the following command
starts a container (in detached mode) and the `-P` flag publishes all exposed ports of the
container to random ports on the host.

```console
$ iechor run -d -P --name webserver nginx
```

Alternatively, you can also use [host networking](../network/drivers/host.md#iechor-desktop)
to give the container direct access to the network stack of the host.

See the [run command](../reference/cli/iechor/container/run.md) for more details on
publish options used with `iechor run`.
