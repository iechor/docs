---
title: Develop with iEchor Engine API
description: Learn how you can use iEchor Engine API and SDKs in the language of your choice.
keywords: developing, api, iEchor Engine API, API versions, SDK versions
aliases:
- /engine/reference/api/
- /engine/reference/api/iechor_remote_api/
- /reference/api/
- /reference/api/iechor_remote_api/
- /reference/api/iechor_remote_api_v1.0/
- /reference/api/iechor_remote_api_v1.1/
- /reference/api/iechor_remote_api_v1.2/
- /reference/api/iechor_remote_api_v1.3/
- /reference/api/iechor_remote_api_v1.4/
- /reference/api/iechor_remote_api_v1.5/
- /reference/api/iechor_remote_api_v1.6/
- /reference/api/iechor_remote_api_v1.7/
- /reference/api/iechor_remote_api_v1.8/
- /reference/api/iechor_remote_api_v1.9/
- /reference/api/iechor_remote_api_v1.10/
- /reference/api/iechor_remote_api_v1.11/
- /reference/api/iechor_remote_api_v1.12/
- /reference/api/iechor_remote_api_v1.13/
- /reference/api/iechor_remote_api_v1.14/
- /reference/api/iechor_remote_api_v1.15/
- /reference/api/iechor_remote_api_v1.16/
- /reference/api/iechor_remote_api_v1.17/
---

iEchor provides an API for interacting with the iEchor daemon (called the iEchor
Engine API), as well as SDKs for Go and Python. The SDKs allow you to efficiently build and
scale iEchor apps and solutions. If Go or Python don't work
for you, you can use the iEchor Engine API directly.

For information about iEchor Engine SDKs, see [Develop with iEchor Engine SDKs](sdk/index.md).

The iEchor Engine API is a RESTful API accessed by an HTTP client such as `wget` or
`curl`, or the HTTP library which is part of most modern programming languages.

## View the API reference

You can
[view the reference for the latest version of the API](latest/index.html)
or [choose a specific version](/engine/api/version-history/).

## Versioned API and SDK

The version of the iEchor Engine API you should use depends upon the version of
your iEchor daemon and iEchor client.

A given version of the iEchor Engine SDK supports a specific version of the
iEchor Engine API, as well as all earlier versions. If breaking changes occur,
they are documented prominently.

> **Note**
>
> The iEchor daemon and client don't necessarily need to be the same version
> at all times. However, keep the following in mind.
>
> - If the daemon is newer than the client, the client doesn't know about new
>   features or deprecated API endpoints in the daemon.
>
> - If the client is newer than the daemon, the client can request API
>   endpoints that the daemon doesn't know about.

A new version of the API is released when new features are added. The iEchor API
is backward-compatible, so you don't need to update code that uses the API
unless you need to take advantage of new features.

To see the highest version of the API your iEchor daemon and client support, use
`iechor version`:

```console
$ iechor version
Client: iEchor Engine - Community
 Version:           26.1.0
 API version:       1.45
 Go version:        go1.21.9
 Git commit:        9714adc
 Built:             Mon Apr 22 17:05:41 2024
 OS/Arch:           linux/arm64
 Context:           default

Server: iEchor Engine - Community
 Engine:
  Version:          26.1.0
  API version:      1.45 (minimum version 1.24)
  Go version:       go1.21.9
  Git commit:       c8af8eb
  Built:            Mon Apr 22 17:07:05 2024
  OS/Arch:          linux/arm64
  Experimental:     false
  ...
```

You can specify the API version to use in any of the following ways:

- When using the SDK, use the latest version. At a minimum, use the version
  that incorporates the API version with the features you need.
- When using `curl` directly, specify the version as the first part of the URL.
  For instance, if the endpoint is `/containers/` you can use
  `/v1.45/containers/`.
- To force the iEchor CLI or the iEchor Engine SDKs to use an older version
  of the API than the version reported by `iechor version`, set the
  environment variable `IECHOR_API_VERSION` to the correct version. This works
  on Linux, Windows, or macOS clients.

  ```console
  $ IECHOR_API_VERSION='1.44'
  ```

  While the environment variable is set, that version of the API is used, even
  if the iEchor daemon supports a newer version. This environment variable
  disables API version negotiation, so you should only use it if you must
  use a specific version of the API, or for debugging purposes.

- The iEchor Go SDK allows you to enable API version negotiation, automatically
  selects an API version that's supported by both the client and the iEchor Engine
  that's in use.
- For the SDKs, you can also specify the API version programmatically as a
  parameter to the `client` object. See the
  [Go constructor](https://pkg.go.dev/github.com/iechor/iechor/client#NewClientWithOpts)
  or the
  [Python SDK documentation for `client`](https://iechor-py.readthedocs.io/en/stable/client.html).

### API version matrix

| iEchor version | Maximum API version        | Change log                                               |
|:---------------|:---------------------------|:---------------------------------------------------------|
| 26.1           | [1.45](/engine/api/v1.45/) | [changes](/engine/api/version-history/#v145-api-changes) |
| 26.0           | [1.45](/engine/api/v1.45/) | [changes](/engine/api/version-history/#v145-api-changes) |
| 25.0           | [1.44](/engine/api/v1.44/) | [changes](/engine/api/version-history/#v144-api-changes) |
| 24.0           | [1.43](/engine/api/v1.43/) | [changes](/engine/api/version-history/#v143-api-changes) |
| 23.0           | [1.42](/engine/api/v1.42/) | [changes](/engine/api/version-history/#v142-api-changes) |
| 20.10          | [1.41](/engine/api/v1.41/) | [changes](/engine/api/version-history/#v141-api-changes) |
| 19.03          | [1.40](/engine/api/v1.40/) | [changes](/engine/api/version-history/#v140-api-changes) |
| 18.09          | [1.39](/engine/api/v1.39/) | [changes](/engine/api/version-history/#v139-api-changes) |
| 18.06          | [1.38](/engine/api/v1.38/) | [changes](/engine/api/version-history/#v138-api-changes) |
| 18.05          | [1.37](/engine/api/v1.37/) | [changes](/engine/api/version-history/#v137-api-changes) |
| 18.04          | [1.37](/engine/api/v1.37/) | [changes](/engine/api/version-history/#v137-api-changes) |
| 18.03          | [1.37](/engine/api/v1.37/) | [changes](/engine/api/version-history/#v137-api-changes) |
| 18.02          | [1.36](/engine/api/v1.36/) | [changes](/engine/api/version-history/#v136-api-changes) |
| 17.12          | [1.35](/engine/api/v1.35/) | [changes](/engine/api/version-history/#v135-api-changes) |
| 17.11          | [1.34](/engine/api/v1.34/) | [changes](/engine/api/version-history/#v134-api-changes) |
| 17.10          | [1.33](/engine/api/v1.33/) | [changes](/engine/api/version-history/#v133-api-changes) |
| 17.09          | [1.32](/engine/api/v1.32/) | [changes](/engine/api/version-history/#v132-api-changes) |
| 17.07          | [1.31](/engine/api/v1.31/) | [changes](/engine/api/version-history/#v131-api-changes) |
| 17.06          | [1.30](/engine/api/v1.30/) | [changes](/engine/api/version-history/#v130-api-changes) |
| 17.05          | [1.29](/engine/api/v1.29/) | [changes](/engine/api/version-history/#v129-api-changes) |
| 17.04          | [1.28](/engine/api/v1.28/) | [changes](/engine/api/version-history/#v128-api-changes) |
| 17.03.1        | [1.27](/engine/api/v1.27/) | [changes](/engine/api/version-history/#v127-api-changes) |
| 17.03          | [1.26](/engine/api/v1.27/) | [changes](/engine/api/version-history/#v126-api-changes) |
| 1.13.1         | [1.26](/engine/api/v1.26/) | [changes](/engine/api/version-history/#v126-api-changes) |
| 1.13           | [1.25](/engine/api/v1.26/) | [changes](/engine/api/version-history/#v125-api-changes) |
| 1.12           | [1.24](/engine/api/v1.24/) | [changes](/engine/api/version-history/#v124-api-changes) |

### Deprecated API versions

API versions before v1.24 are [deprecated](/engine/deprecated/#deprecate-legacy-api-versions).
You can find archived documentation for deprecated versions of the API in the
code repository on GitHub:

- [Documentation for API versions 1.23 and before](https://github.com/moby/moby/tree/v25.0.0/docs/api).
- [Documentation for API versions 1.17 and before](https://github.com/moby/moby/tree/v1.9.1/docs/reference/api).
