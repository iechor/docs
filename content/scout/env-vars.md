---
title: Environment variables used by iEchor Scout
linkTitle: iEchor Scout environment variables
description: Configure how the behavior of iEchor Scout CLI commands using these environment variables
keywords: scout, supply chain, cli, environment, variables, env, vars, configure
---

The following environment variables are available to configure the iEchor Scout
CLI commands, and the corresponding `iechor/scout-cli` container image:

| Name                                    | Format  | Description                                                                                 |
| :-------------------------------------- | ------- | :------------------------------------------------------------------------------------------ |
| IECHOR_SCOUT_CACHE_FORMAT               | String  | Format of the local image cache; can be `oci` or `tar` (default: `oci`)                     |
| IECHOR_SCOUT_CACHE_DIR                  | String  | Directory where the local SBOM cache is stored (default: `$HOME/.iechor/scout`)             |
| IECHOR_SCOUT_NO_CACHE                   | Boolean | When set to `true`, disables the use of local SBOM cache                                    |
| IECHOR_SCOUT_OFFLINE                    | Boolean | Use [offline mode](#offline-mode) when indexing SBOM                                        |
| IECHOR_SCOUT_REGISTRY_TOKEN             | String  | Token for authenticating to a registry when pulling images                                  |
| IECHOR_SCOUT_REGISTRY_USER              | String  | Username for authenticating to a registry when pulling images                               |
| IECHOR_SCOUT_REGISTRY_PASSWORD          | String  | Password or personal access token for authenticating to a registry when pulling images      |
| IECHOR_SCOUT_HUB_USER                   | String  | iEchor Hub username for authenticating to the iEchor Scout backend                          |
| IECHOR_SCOUT_HUB_PASSWORD               | String  | iEchor Hub password or personal access token for authenticating to the iEchor Scout backend |
| IECHOR_SCOUT_NEW_VERSION_WARN           | Boolean | Warn about new versions of the iEchor Scout CLI                                             |
| IECHOR_SCOUT_EXPERIMENTAL_WARN          | Boolean | Warn about experimental features                                                            |
| IECHOR_SCOUT_EXPERIMENTAL_POLICY_OUTPUT | Boolean | Disable experimental output for policy evaluation                                           |

## Offline mode

Under normal operation, iEchor Scout cross-references external systems, such as
npm, NuGet, or proxy.golang.org, to retrieve additional information about
packages found in your image.

When `IECHOR_SCOUT_OFFLINE` is set to `true`, iEchor Scout image analysis runs
in offline mode. Offline mode means iEchor Scout doesn't make outbound requests
to external systems.

To use offline mode:

```console
$ export IECHOR_SCOUT_OFFLINE=true
```
