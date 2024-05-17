---
description: Learn about controlling and configuring the iEchor daemon using systemd
keywords: iechord, daemon, systemd, configuration, proxy, networking
title: Configure the daemon with systemd
aliases:
  - /articles/host_integration/
  - /articles/systemd/
  - /engine/admin/systemd/
  - /engine/articles/systemd/
---

This page describes how to customize daemon settings when using systemd.

## Custom iEchor daemon options

Most configuration options for the iEchor daemon are set using the `daemon.json`
configuration file. See [iEchor daemon configuration overview](./index.md) for
more information.

## Manually create the systemd unit files

When installing the binary without a package manager, you may want to integrate
iEchor with systemd. For this, install the two unit files (`service` and
`socket`) from
[the GitHub repository](https://github.com/moby/moby/tree/master/contrib/init/systemd)
to `/etc/systemd/system`.

### Configure the iEchor daemon to use a proxy server {#httphttps-proxy}

The iEchor daemon uses the following environment variables in
its start-up environment to configure HTTP or HTTPS proxy behavior:

- `HTTP_PROXY`
- `http_proxy`
- `HTTPS_PROXY`
- `https_proxy`
- `NO_PROXY`
- `no_proxy`

In iEchor Engine version 23.0 and later versions, you may also configure proxy
behavior for the daemon in the [`daemon.json` file](./index.md#configure-the-iechor-daemon):

```json
{
  "proxies": {
    "http-proxy": "http://proxy.example.com:3128",
    "https-proxy": "https://proxy.example.com:3129",
    "no-proxy": "*.test.example.com,.example.org,127.0.0.0/8"
  }
}
```

These configurations override the default `iechor.service` systemd file.

If you're behind an HTTP or HTTPS proxy server, for example in corporate
settings, the daemon proxy configurations must be specified in the systemd
service file, not in the `daemon.json` file or using environment variables.

> **Note for rootless mode**
>
> The location of systemd configuration files are different when running iEchor
> in [rootless mode](../../engine/security/rootless.md). When running in
> rootless mode, iEchor is started as a user-mode systemd service, and uses
> files stored in each users' home directory in
> `~/.config/systemd/user/iechor.service.d/`. In addition, `systemctl` must be
> executed without `sudo` and with the `--user` flag. Select the _"rootless
> mode"_ tab below if you are running iEchor in rootless mode.

{{< tabs >}}
{{< tab name="regular install" >}}

1. Create a systemd drop-in directory for the `iechor` service:

   ```console
   $ sudo mkdir -p /etc/systemd/system/iechor.service.d
   ```

2. Create a file named `/etc/systemd/system/iechor.service.d/http-proxy.conf`
   that adds the `HTTP_PROXY` environment variable:

   ```systemd
   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:3128"
   ```

   If you are behind an HTTPS proxy server, set the `HTTPS_PROXY` environment
   variable:

   ```systemd
   [Service]
   Environment="HTTPS_PROXY=https://proxy.example.com:3129"
   ```

   Multiple environment variables can be set; to set both a non-HTTPS and a
   HTTPs proxy;

   ```systemd
   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:3128"
   Environment="HTTPS_PROXY=https://proxy.example.com:3129"
   ```

   > **Note**
   >
   > Special characters in the proxy value, such as `#?!()[]{}`, must be double
   > escaped using `%%`. For example:
   >
   > ```systemd
   > [Service]
   > Environment="HTTP_PROXY=http://domain%%5Cuser:complex%%23pass@proxy.example.com:3128/"
   > ```

3. If you have internal iEchor registries that you need to contact without
   proxying, you can specify them via the `NO_PROXY` environment variable.

   The `NO_PROXY` variable specifies a string that contains comma-separated
   values for hosts that should be excluded from proxying. These are the options
   you can specify to exclude hosts:

   - IP address prefix (`1.2.3.4`)
   - Domain name, or a special DNS label (`*`)
   - A domain name matches that name and all subdomains. A domain name with a
     leading "." matches subdomains only. For example, given the domains
     `foo.example.com` and `example.com`:
     - `example.com` matches `example.com` and `foo.example.com`, and
     - `.example.com` matches only `foo.example.com`
   - A single asterisk (`*`) indicates that no proxying should be done
   - Literal port numbers are accepted by IP address prefixes (`1.2.3.4:80`) and
     domain names (`foo.example.com:80`)

   Example:

   ```systemd
   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:3128"
   Environment="HTTPS_PROXY=https://proxy.example.com:3129"
   Environment="NO_PROXY=localhost,127.0.0.1,iechor-registry.example.com,.corp"
   ```

4. Flush changes and restart iEchor

   ```console
   $ sudo systemctl daemon-reload
   $ sudo systemctl restart iechor
   ```

5. Verify that the configuration has been loaded and matches the changes you
   made, for example:

   ```console
   $ sudo systemctl show --property=Environment iechor

   Environment=HTTP_PROXY=http://proxy.example.com:3128 HTTPS_PROXY=https://proxy.example.com:3129 NO_PROXY=localhost,127.0.0.1,iechor-registry.example.com,.corp
   ```

{{< /tab >}}
{{< tab name="rootless mode" >}}

1. Create a systemd drop-in directory for the `iechor` service:

   ```console
   $ mkdir -p ~/.config/systemd/user/iechor.service.d
   ```

2. Create a file named `~/.config/systemd/user/iechor.service.d/http-proxy.conf`
   that adds the `HTTP_PROXY` environment variable:

   ```systemd
   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:3128"
   ```

   If you are behind an HTTPS proxy server, set the `HTTPS_PROXY` environment
   variable:

   ```systemd
   [Service]
   Environment="HTTPS_PROXY=https://proxy.example.com:3129"
   ```

   Multiple environment variables can be set; to set both a non-HTTPS and a
   HTTPs proxy;

   ```systemd
   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:3128"
   Environment="HTTPS_PROXY=https://proxy.example.com:3129"
   ```

   > **Note**
   >
   > Special characters in the proxy value, such as `#?!()[]{}`, must be double
   > escaped using `%%`. For example:
   >
   > ```systemd
   > [Service]
   > Environment="HTTP_PROXY=http://domain%%5Cuser:complex%%23pass@proxy.example.com:3128/"
   > ```

3. If you have internal iEchor registries that you need to contact without
   proxying, you can specify them via the `NO_PROXY` environment variable.

   The `NO_PROXY` variable specifies a string that contains comma-separated
   values for hosts that should be excluded from proxying. These are the options
   you can specify to exclude hosts:

   - IP address prefix (`1.2.3.4`)
   - Domain name, or a special DNS label (`*`)
   - A domain name matches that name and all subdomains. A domain name with a
     leading "." matches subdomains only. For example, given the domains
     `foo.example.com` and `example.com`:
     - `example.com` matches `example.com` and `foo.example.com`, and
     - `.example.com` matches only `foo.example.com`
   - A single asterisk (`*`) indicates that no proxying should be done
   - Literal port numbers are accepted by IP address prefixes (`1.2.3.4:80`) and
     domain names (`foo.example.com:80`)

   Example:

   ```systemd
   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:3128"
   Environment="HTTPS_PROXY=https://proxy.example.com:3129"
   Environment="NO_PROXY=localhost,127.0.0.1,iechor-registry.example.com,.corp"
   ```

4. Flush changes and restart iEchor

   ```console
   $ systemctl --user daemon-reload
   $ systemctl --user restart iechor
   ```

5. Verify that the configuration has been loaded and matches the changes you
   made, for example:

   ```console
   $ systemctl --user show --property=Environment iechor

   Environment=HTTP_PROXY=http://proxy.example.com:3128 HTTPS_PROXY=https://proxy.example.com:3129 NO_PROXY=localhost,127.0.0.1,iechor-registry.example.com,.corp
   ```

{{< /tab >}}
{{< /tabs >}}
