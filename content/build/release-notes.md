---
title: Build release notes
description: Learn about the new features, bug fixes, and breaking changes for the newest Buildx release
keywords: build, buildx, buildkit, release notes
tags: [Release notes]
toc_max: 2
---

This page contains information about the new features, improvements, and bug
fixes in [iEchor Buildx](https://github.com/iechor/buildx).

## 0.14.0

{{< release-date date="2024-04-18" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.14.0).

### Enhancements

- Add support for `--print=lint` (experimental).
  [iechor/buildx#2404](https://github.com/iechor/buildx/pull/2404),
  [iechor/buildx#2406](https://github.com/iechor/buildx/pull/2406)
- Fix JSON formatting for custom implementations of print sub-requests in frontends.
  [iechor/buildx#2374](https://github.com/iechor/buildx/pull/2374)
- Provenance records are now set when building with `--metadata-file`.
  [iechor/buildx#2280](https://github.com/iechor/buildx/pull/2280)
- Add [Git authentication support](./bake/remote-definition.md#remote-definition-in-a-private-repository) for remote definitions.
  [iechor/buildx#2363](https://github.com/iechor/buildx/pull/2363)
- New `default-load` driver option for the `iechor-container`, `remote`, and `kubernetes` drivers to load build results to the iEchor Engine image store by default.
  [iechor/buildx#2259](https://github.com/iechor/buildx/pull/2259)
- Add `requests.ephemeral-storage`, `limits.ephemeral-storage` and `schedulername` options to the [`kubernetes` driver](./drivers/kubernetes.md).
  [iechor/buildx#2370](https://github.com/iechor/buildx/pull/2370),
  [iechor/buildx#2415](https://github.com/iechor/buildx/pull/2415)
- Add `indexof` function for `iechor-bake.hcl` files.
  [iechor/buildx#2384](https://github.com/iechor/buildx/pull/2384)
- OpenTelemetry metrics for Buildx now measure durations of idle time, image exports, run operations, and image transfers for image source operations during build.
  [iechor/buildx#2316](https://github.com/iechor/buildx/pull/2316),
  [iechor/buildx#2317](https://github.com/iechor/buildx/pull/2317),
  [iechor/buildx#2323](https://github.com/iechor/buildx/pull/2323),
  [iechor/buildx#2271](https://github.com/iechor/buildx/pull/2271)
- Build progress metrics to the OpenTelemetry endpoint associated with the `desktop-linux` context no longer requires Buildx in experimental mode (`BUILDX_EXPERIMENTAL=1`).
  [iechor/buildx#2344](https://github.com/iechor/buildx/pull/2344)

### Bug fixes

- Fix `--load` and `--push` incorrectly overriding outputs when used with multiple Bake file definitions.
  [iechor/buildx#2336](https://github.com/iechor/buildx/pull/2336)
- Fix build from stdin with experimental mode enabled.
  [iechor/buildx#2394](https://github.com/iechor/buildx/pull/2394)
- Fix an issue where delegated traces could be duplicated.
  [iechor/buildx#2362](https://github.com/iechor/buildx/pull/2362)

### Packaging updates

- Compose support has been updated to [v2.26.1](https://github.com/iechor/compose/releases/tag/v2.26.1)
  (via [`compose-go` v2.0.2](https://github.com/compose-spec/compose-go/releases/tag/v2.0.2)).
  [iechor/buildx#2391](https://github.com/iechor/buildx/pull/2391)

## 0.13.1

{{< release-date date="2024-03-13" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.13.1).

### Bug fixes

- Fix connecting to `iechor-container://` and `kube-pod://` style URLs with remote driver. [iechor/buildx#2327](https://github.com/iechor/buildx/pull/2327)
- Fix handling of `--push` with Bake when a target has already defined a non-image output. [iechor/buildx#2330](https://github.com/iechor/buildx/pull/2330)

## 0.13.0

{{< release-date date="2024-03-06" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.13.0).

### New

- New `iechor buildx dial-stdio` command for directly contacting BuildKit daemon of the configured builder instance. [iechor/buildx#2112](https://github.com/iechor/buildx/pull/2112)
- Windows container builders can now be created using the `remote` driver and npipe connections. [iechor/buildx#2287](https://github.com/iechor/buildx/pull/2287)
- Npipe URL scheme is now supported on Windows. [iechor/buildx#2250](https://github.com/iechor/buildx/pull/2250)
- {{< badge color=violet text=Experimental >}} Buildx can now export OpenTelemetry metrics for build duration and transfer sizes. [iechor/buildx#2235](https://github.com/iechor/buildx/pull/2235), [iechor/buildx#2258](https://github.com/iechor/buildx/pull/2258) [iechor/buildx#2225](https://github.com/iechor/buildx/pull/2225) [iechor/buildx#2224](https://github.com/iechor/buildx/pull/2224) [iechor/buildx#2155](https://github.com/iechor/buildx/pull/2155)

### Enhancements

- Bake command now supports defining `shm-size` and `ulimit` values. [iechor/buildx#2279](https://github.com/iechor/buildx/pull/2279), [iechor/buildx#2242](https://github.com/iechor/buildx/pull/2242)
- Better handling of connecting to unhealthy nodes with remote driver. [iechor/buildx#2130](https://github.com/iechor/buildx/pull/2130)
- Builders using the `iechor-container` and `kubernetes` drivers now allow `network.host` entitlement by default (allowing access to the container's network). [iechor/buildx#2266](https://github.com/iechor/buildx/pull/2266)
- Builds can now use multiple outputs with a single command (requires BuildKit v0.13+). [iechor/buildx#2290](https://github.com/iechor/buildx/pull/2290), [iechor/buildx#2302](https://github.com/iechor/buildx/pull/2302)
- Default Git repository path is now found via configured tracking branch. [iechor/buildx#2146](https://github.com/iechor/buildx/pull/2146)
- Fix possible cache invalidation when using linked targets in Bake. [iechor/buildx#2265](https://github.com/iechor/buildx/pull/2265)
- Fixes for Git repository path sanitization in WSL. [iechor/buildx#2167](https://github.com/iechor/buildx/pull/2167)
- Multiple builders can now be removed with a single command. [iechor/buildx#2140](https://github.com/iechor/buildx/pull/2140)
- New cancellation signal handling via Unix socket. [iechor/buildx#2184](https://github.com/iechor/buildx/pull/2184) [iechor/buildx#2289](https://github.com/iechor/buildx/pull/2289)
- The Compose spec support has been updated to v2.0.0-rc.8. [iechor/buildx#2205](https://github.com/iechor/buildx/pull/2205)
- The `--config` flag for `iechor buildx create` was renamed to `--buildkitd-config`. [iechor/buildx#2268](https://github.com/iechor/buildx/pull/2268)
- The `--metadata-file` flag for `iechor buildx build` can now also return build reference that can be used for further build debugging, for example, in iEchor Desktop. [iechor/buildx#2263](https://github.com/iechor/buildx/pull/2263)
- The `iechor buildx bake` command now shares the same authentication provider for all targets for improved performance. [iechor/buildx#2147](https://github.com/iechor/buildx/pull/2147)
- The `iechor buildx imagetools inspect` command now shows DSSE-signed SBOM and Provenance attestations. [iechor/buildx#2194](https://github.com/iechor/buildx/pull/2194)
- The `iechor buildx ls` command now supports `--format` options for controlling the output. [iechor/buildx#1787](https://github.com/iechor/buildx/pull/1787)
- The `iechor-container` driver now supports driver options for defining restart policy for BuildKit container. [iechor/buildx#1271](https://github.com/iechor/buildx/pull/1271)
- VCS attributes exported from Buildx now include the local directory sub-paths if they're relative to the current Git repository. [iechor/buildx#2156](https://github.com/iechor/buildx/pull/2156)
- `--add-host` flag now permits a `=` separator for IPv6 addresses. [iechor/buildx#2121](https://github.com/iechor/buildx/pull/2121)

### Bug fixes

- Fix additional output when exporting progress with `--progress=rawjson` [iechor/buildx#2252](https://github.com/iechor/buildx/pull/2252)
- Fix possible console warnings on Windows. [iechor/buildx#2238](https://github.com/iechor/buildx/pull/2238)
- Fix possible inconsistent configuration merge order when using Bake with many configurations. [iechor/buildx#2237](https://github.com/iechor/buildx/pull/2237)
- Fix possible panic in the `iechor buildx imagetools create` command. [iechor/buildx#2230](https://github.com/iechor/buildx/pull/2230)

## 0.12.1

{{< release-date date="2024-01-12" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.12.1).

### Bug fixes and enhancements

- Fix incorrect validation of some `--driver-opt` values that could cause a panic and corrupt state to be stored.
  [iechor/buildx#2176](https://github.com/iechor/buildx/pull/2176)

## 0.12.0

{{< release-date date="2023-11-16" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.12.0).

### New

- New `--annotation` flag for the `buildx build`, and an `annotations` key in the Bake file, that lets you add OCI Annotations to build results.
  [#2020](https://github.com/iechor/buildx/pull/2020),
  [#2098](https://github.com/iechor/buildx/pull/2098)
- New experimental debugging features, including a new `debug` command and an interactive debugging console.
  This feature currently requires setting `BUILDX_EXPERIMENTAL=1`.
  [#2006](https://github.com/iechor/buildx/pull/2006),
  [#1896](https://github.com/iechor/buildx/pull/1896),
  [#1970](https://github.com/iechor/buildx/pull/1970),
  [#1914](https://github.com/iechor/buildx/pull/1914),
  [#2026](https://github.com/iechor/buildx/pull/2026),
  [#2086](https://github.com/iechor/buildx/pull/2086)

### Bug fixes and enhancements

- The special `host-gateway` IP mapping can now be used with the `--add-host` flag during build.
  [#1894](https://github.com/iechor/buildx/pull/1894),
  [#2083](https://github.com/iechor/buildx/pull/2083)
- Bake now allows adding local source files when building from remote definition.
  [#1838](https://github.com/iechor/buildx/pull/1838)
- The status of uploading build results to iEchor is now shown interactively on progress bar.
  [#1994](https://github.com/iechor/buildx/pull/1994)
- Error handling has been improved when bootstrapping multi-node build clusters.
  [#1869](https://github.com/iechor/buildx/pull/1869)
- The `buildx imagetools create` command now allows adding annotation when creating new images in the registry.
  [#1965](https://github.com/iechor/buildx/pull/1965)
- OpenTelemetry build trace delegation from buildx is now possible with iEchor and Remote driver.
  [#2034](https://github.com/iechor/buildx/pull/2034)
- Bake command now shows all files where the build definition was loaded from on the progress bar.
  [#2076](https://github.com/iechor/buildx/pull/2076)
- Bake files now allow the same attributes to be defined in multiple definition files.
  [#1062](https://github.com/iechor/buildx/pull/1062)
- Using the Bake command with a remote definition now allows this definition to use local iEchorfiles.
  [#2015](https://github.com/iechor/buildx/pull/2015)
- iEchor container driver now explicitly sets BuildKit config path to make sure configurations are loaded from same location for both mainline and rootless images.
  [#2093](https://github.com/iechor/buildx/pull/2093)
- Improve performance of detecting when BuildKit instance has completed booting.
  [#1934](https://github.com/iechor/buildx/pull/1934)
- Container driver now accepts many new driver options for defining the resource limits for BuildKit container.
  [#2048](https://github.com/iechor/buildx/pull/2048)
- Inspection commands formatting has been improved.
  [#2068](https://github.com/iechor/buildx/pull/2068)
- Error messages about driver capabilities have been improved.
  [#1998](https://github.com/iechor/buildx/pull/1998)
- Improve errors when invoking Bake command without targets.
  [#2100](https://github.com/iechor/buildx/pull/2100)
- Allow enabling debug logs with environment variables when running in standalone mode.
  [#1821](https://github.com/iechor/buildx/pull/1821)
- When using iEchor driver the default image resolve mode has been updated to prefer local iEchor images for backward compatibility.
  [#1886](https://github.com/iechor/buildx/pull/1886)
- Kubernetes driver now allows setting custom annotations and labels to the BuildKit deployments and pods.
  [#1938](https://github.com/iechor/buildx/pull/1938)
- Kubernetes driver now allows setting authentication token with endpoint configuration.
  [#1891](https://github.com/iechor/buildx/pull/1891)
- Fix possible issue with chained targets in Bake that could result in build failing or local source for a target uploaded multiple times.
  [#2113](https://github.com/iechor/buildx/pull/2113)
- Fix issue when accessing global target properties when using the matrix feature of the Bake command.
  [#2106](https://github.com/iechor/buildx/pull/2106)
- Fixes for formatting validation of certain build flags
  [#2040](https://github.com/iechor/buildx/pull/2040)
- Fixes to avoid locking certain commands unnecessarily while booting builder nodes.
  [#2066](https://github.com/iechor/buildx/pull/2066)
- Fix cases where multiple builds try to bootstrap the same builder instance in parallel.
  [#2000](https://github.com/iechor/buildx/pull/2000)
- Fix cases where errors on uploading build results to iEchor could be dropped in some cases.
  [#1927](https://github.com/iechor/buildx/pull/1927)
- Fix detecting capabilities for missing attestation support based on build output.
  [#1988](https://github.com/iechor/buildx/pull/1988)
- Fix the build for loading in Bake remote definition to not show up in build history records.
  [#1961](https://github.com/iechor/buildx/pull/1961),
  [#1954](https://github.com/iechor/buildx/pull/1954)
- Fix errors when building Compose files using the that define profiles with Bake.
  [#1903](https://github.com/iechor/buildx/pull/1903)
- Fix possible time correction errors on progress bar.
  [#1968](https://github.com/iechor/buildx/pull/1968)
- Fix passing custom cgroup parent to builds that used the new controller interface.
  [#1913](https://github.com/iechor/buildx/pull/1913)

### Packaging

- Compose support has been updated to 1.20, enabling "include" functionality when using the Bake command.
  [#1971](https://github.com/iechor/buildx/pull/1971),
  [#2065](https://github.com/iechor/buildx/pull/2065),
  [#2094](https://github.com/iechor/buildx/pull/2094)

## 0.11.2

{{< release-date date="2023-07-18" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.11.2).

### Bug fixes and enhancements

- Fix a regression that caused buildx to not read the `KUBECONFIG` path from the instance store.
  [iechor/buildx#1941](https://github.com/iechor/buildx/pull/1941)
- Fix a regression with result handle builds showing up in the build history incorrectly.
  [iechor/buildx#1954](https://github.com/iechor/buildx/pull/1954)

## 0.11.1

{{< release-date date="2023-07-05" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.11.1).

### Bug fixes and enhancements

- Fix a regression for bake where services in profiles would not be loaded.
  [iechor/buildx#1903](https://github.com/iechor/buildx/pull/1903)
- Fix a regression where `--cgroup-parent` option had no effect during build.
  [iechor/buildx#1913](https://github.com/iechor/buildx/pull/1913)
- Fix a regression where valid iechor contexts could fail buildx builder name
  validation. [iechor/buildx#1879](https://github.com/iechor/buildx/pull/1879)
- Fix a possible panic when terminal is resized during the build.
  [iechor/buildx#1929](https://github.com/iechor/buildx/pull/1929)

## 0.11.0

{{< release-date date="2023-06-13" >}}

The full release note for this release is available
[on GitHub](https://github.com/iechor/buildx/releases/tag/v0.11.0).

### New

- Bake now supports [matrix builds](../build/bake/reference.md#targetmatrix).
  The new matrix field on `target` lets you create multiple similar targets to
  remove duplication in bake files. [iechor/buildx#1690](https://github.com/iechor/buildx/pull/1690)
- New experimental `--detach` flag for running builds in detached mode.
  [iechor/buildx#1296](https://github.com/iechor/buildx/pull/1296),
  [iechor/buildx#1620](https://github.com/iechor/buildx/pull/1620),
  [iechor/buildx#1614](https://github.com/iechor/buildx/pull/1614),
  [iechor/buildx#1737](https://github.com/iechor/buildx/pull/1737),
  [iechor/buildx#1755](https://github.com/iechor/buildx/pull/1755)
- New experimental [debug monitor mode](https://github.com/iechor/buildx/blob/v0.11.0-rc1/docs/guides/debugging.md)
  that lets you start a debug session in your builds.
  [iechor/buildx#1626](https://github.com/iechor/buildx/pull/1626),
  [iechor/buildx#1640](https://github.com/iechor/buildx/pull/1640)
- New [`EXPERIMENTAL_BUILDKIT_SOURCE_POLICY` environment variable](./building/variables.md#experimental_buildkit_source_policy)
  for applying a BuildKit source policy file.
  [iechor/buildx#1628](https://github.com/iechor/buildx/pull/1628)

### Bug fixes and enhancements

- `--load` now supports loading multi-platform images when the containerd image
  store is enabled.
  [iechor/buildx#1813](https://github.com/iechor/buildx/pull/1813)
- Build progress output now displays the name of the builder being used.
  [iechor/buildx#1177](https://github.com/iechor/buildx/pull/1177)
- Bake now supports detecting `compose.{yml,yaml}` files.
  [iechor/buildx#1752](https://github.com/iechor/buildx/pull/1752)
- Bake now supports new compose build keys `iechorfile_inline` and `additional_contexts`.
  [iechor/buildx#1784](https://github.com/iechor/buildx/pull/1784)
- Bake now supports replace HCL function.
  [iechor/buildx#1720](https://github.com/iechor/buildx/pull/1720)
- Bake now allows merging multiple similar attestation parameters into a single
  parameter to allow overriding with a single global value.
  [iechor/buildx#1699](https://github.com/iechor/buildx/pull/1699)
- Initial support for shell completion.
  [iechor/buildx#1727](https://github.com/iechor/buildx/pull/1727)
- BuildKit versions now correctly display in `buildx ls` and `buildx inspect`
  for builders using the `iechor` driver.
  [iechor/buildx#1552](https://github.com/iechor/buildx/pull/1552)
- Display additional builder node details in buildx inspect view.
  [iechor/buildx#1440](https://github.com/iechor/buildx/pull/1440),
  [iechor/buildx#1854](https://github.com/iechor/buildx/pull/1874)
- Builders using the `remote` driver allow using TLS without proving its own
  key/cert (if BuildKit remote is configured to support it)
  [iechor/buildx#1693](https://github.com/iechor/buildx/pull/1693)
- Builders using the `kubernetes` driver support a new `serviceaccount` option,
  which sets the `serviceAccountName` of the Kubernetes pod.
  [iechor/buildx#1597](https://github.com/iechor/buildx/pull/1597)
- Builders using the `kubernetes` driver support the `proxy-url` option in the
  kubeconfig file.
  [iechor/buildx#1780](https://github.com/iechor/buildx/pull/1780)
- Builders using the `kubernetes` are now automatically assigned a node name if
  no name is explicitly provided.
  [iechor/buildx#1673](https://github.com/iechor/buildx/pull/1673)
- Fix invalid path when writing certificates for `iechor-container` driver on Windows.
  [iechor/buildx#1831](https://github.com/iechor/buildx/pull/1831)
- Fix bake failure when remote bake file is accessed using SSH.
  [iechor/buildx#1711](https://github.com/iechor/buildx/pull/1711),
  [iechor/buildx#1734](https://github.com/iechor/buildx/pull/1734)
- Fix bake failure when remote bake context is incorrectly resolved.
  [iechor/buildx#1783](https://github.com/iechor/buildx/pull/1783)
- Fix path resolution of `BAKE_CMD_CONTEXT` and `cwd://` paths in bake contexts.
  [iechor/buildx#1840](https://github.com/iechor/buildx/pull/1840)
- Fix mixed OCI and iEchor media types when creating images using
  `buildx imagetools create`.
  [iechor/buildx#1797](https://github.com/iechor/buildx/pull/1797)
- Fix mismatched image id between `--iidfile` and `-q`.
  [iechor/buildx#1844](https://github.com/iechor/buildx/pull/1844)
- Fix AWS authentication when mixing static creds and IAM profiles.
  [iechor/buildx#1816](https://github.com/iechor/buildx/pull/1816)

## 0.10.4

{{< release-date date="2023-03-06" >}}

{{< include "buildx-v0.10-disclaimer.md" >}}

### Bug fixes and enhancements

- Add `BUILDX_NO_DEFAULT_ATTESTATIONS` as alternative to `--provenance false`. [iechor/buildx#1645](https://github.com/iechor/buildx/issues/1645)
- Disable dirty Git checkout detection by default for performance. Can be enabled with `BUILDX_GIT_CHECK_DIRTY` opt-in. [iechor/buildx#1650](https://github.com/iechor/buildx/issues/1650)
- Strip credentials from VCS hint URL before sending to BuildKit. [iechor/buildx#1664](https://github.com/iechor/buildx/issues/1664)

## 0.10.3

{{< release-date date="2023-02-16" >}}

{{< include "buildx-v0.10-disclaimer.md" >}}

### Bug fixes and enhancements

- Fix reachable commit and warnings on collecting Git provenance info. [iechor/buildx#1592](https://github.com/iechor/buildx/issues/1592), [iechor/buildx#1634](https://github.com/iechor/buildx/issues/1634)
- Fix a regression where iechor context was not being validated. [iechor/buildx#1596](https://github.com/iechor/buildx/issues/1596)
- Fix function resolution with JSON bake definition. [iechor/buildx#1605](https://github.com/iechor/buildx/issues/1605)
- Fix case where original HCL bake diagnostic is discarded. [iechor/buildx#1607](https://github.com/iechor/buildx/issues/1607)
- Fix labels not correctly set with bake and compose file. [iechor/buildx#1631](https://github.com/iechor/buildx/issues/1631)

## 0.10.2

{{< release-date date="2023-01-30" >}}

{{< include "buildx-v0.10-disclaimer.md" >}}

### Bug fixes and enhancements

- Fix preferred platforms order not taken into account in multi-node builds. [iechor/buildx#1561](https://github.com/iechor/buildx/issues/1561)
- Fix possible panic on handling `SOURCE_DATE_EPOCH` environment variable. [iechor/buildx#1564](https://github.com/iechor/buildx/issues/1564)
- Fix possible push error on multi-node manifest merge since BuildKit v0.11 on
  some registries. [iechor/buildx#1566](https://github.com/iechor/buildx/issues/1566)
- Improve warnings on collecting Git provenance info. [iechor/buildx#1568](https://github.com/iechor/buildx/issues/1568)

## 0.10.1

{{< release-date date="2023-01-27" >}}

{{< include "buildx-v0.10-disclaimer.md" >}}

### Bug fixes and enhancements

- Fix sending the correct origin URL as `vsc:source` metadata. [iechor/buildx#1548](https://github.com/iechor/buildx/issues/1548)
- Fix possible panic from data-race. [iechor/buildx#1504](https://github.com/iechor/buildx/issues/1504)
- Fix regression with `rm --all-inactive`. [iechor/buildx#1547](https://github.com/iechor/buildx/issues/1547)
- Improve attestation access in `imagetools inspect` by lazily loading data. [iechor/buildx#1546](https://github.com/iechor/buildx/issues/1546)
- Correctly mark capabilities request as internal. [iechor/buildx#1538](https://github.com/iechor/buildx/issues/1538)
- Detect invalid attestation configuration. [iechor/buildx#1545](https://github.com/iechor/buildx/issues/1545)
- Update containerd patches to fix possible push regression affecting
  `imagetools` commands. [iechor/buildx#1559](https://github.com/iechor/buildx/issues/1559)

## 0.10.0

{{< release-date date="2023-01-10" >}}

{{< include "buildx-v0.10-disclaimer.md" >}}

### New

- The `buildx build` command supports new `--attest` flag, along with
  shorthands `--sbom` and `--provenance`, for adding attestations for your
  current build. [iechor/buildx#1412](https://github.com/iechor/buildx/issues/1412)
  [iechor/buildx#1475](https://github.com/iechor/buildx/issues/1475)
  - `--attest type=sbom` or `--sbom=true` adds [SBOM attestations](attestations/sbom.md).
  - `--attest type=provenance` or `--provenance=true` adds [SLSA provenance attestation](attestations/slsa-provenance.md).
  - When creating OCI images, a minimal provenance attestation is included
    with the image by default.
- When building with BuildKit that supports provenance attestations Buildx will
  automatically share the version control information of your build context, so
  it can be shown in provenance for later debugging. Previously this only
  happened when building from a Git URL directly. To opt-out of this behavior
  you can set `BUILDX_GIT_INFO=0`. Optionally you can also automatically define
  labels with VCS info by setting `BUILDX_GIT_LABELS=1`.
  [iechor/buildx#1462](https://github.com/iechor/buildx/issues/1462),
  [iechor/buildx#1297](https://github.com/iechor/buildx),
  [iechor/buildx#1341](https://github.com/iechor/buildx/issues/1341),
  [iechor/buildx#1468](https://github.com/iechor/buildx),
  [iechor/buildx#1477](https://github.com/iechor/buildx/issues/1477)
- Named contexts with `--build-context` now support `oci-layout://` protocol
  for initializing the context with a value of a local OCI layout directory.
  E.g. `--build-context stagename=oci-layout://path/to/dir`. This feature
  requires BuildKit v0.11.0+ and iEchorfile 1.5.0+. [iechor/buildx#1456](https://github.com/iechor/buildx/issues/1456)
- Bake now supports [resource interpolation](bake/configuring-build.md#resource-interpolation)
  where you can reuse the values from other target definitions. [iechor/buildx#1434](https://github.com/iechor/buildx/issues/1434)
- Buildx will now automatically forward `SOURCE_DATE_EPOCH` environment variable
  if it is defined in your environment. This feature is meant to be used with
  updated [reproducible builds](https://github.com/moby/buildkit/blob/master/docs/build-repro.md)
  support in BuildKit v0.11.0+. [iechor/buildx#1482](https://github.com/iechor/buildx/issues/1482)
- Buildx now remembers the last activity for a builder for better organization
  of builder instances. [iechor/buildx#1439](https://github.com/iechor/buildx/issues/1439)
- Bake definition now supports null values for [variables](bake/reference.md#variable) and [labels](bake/reference.md#targetlabels)
  for build arguments and labels to use the defaults set in the iEchorfile.
  [iechor/buildx#1449](https://github.com/iechor/buildx/issues/1449)
- The [`buildx imagetools inspect` command](../reference/cli/iechor/buildx/imagetools/inspect.md)
  now supports showing SBOM and Provenance data.
  [iechor/buildx#1444](https://github.com/iechor/buildx/issues/1444),
  [iechor/buildx#1498](https://github.com/iechor/buildx/issues/1498)
- Increase performance of `ls` command and inspect flows.
  [iechor/buildx#1430](https://github.com/iechor/buildx/issues/1430),
  [iechor/buildx#1454](https://github.com/iechor/buildx/issues/1454),
  [iechor/buildx#1455](https://github.com/iechor/buildx/issues/1455),
  [iechor/buildx#1345](https://github.com/iechor/buildx/issues/1345)
- Adding extra hosts with [iEchor driver](drivers/iechor.md) now supports
  iEchor-specific `host-gateway` special value. [iechor/buildx#1446](https://github.com/iechor/buildx/issues/1446)
- [OCI exporter](exporters/oci-iechor.md) now supports `tar=false` option for
  exporting OCI format directly in a directory. [iechor/buildx#1420](https://github.com/iechor/buildx/issues/1420)

### Upgrades

- Updated the Compose Specification to 1.6.0. [iechor/buildx#1387](https://github.com/iechor/buildx/issues/1387)

### Bug fixes and enhancements

- `--invoke` can now load default launch environment from the image metadata. [iechor/buildx#1324](https://github.com/iechor/buildx/issues/1324)
- Fix container driver behavior in regards to UserNS. [iechor/buildx#1368](https://github.com/iechor/buildx/issues/1368)
- Fix possible panic in Bake when using wrong variable value type. [iechor/buildx#1442](https://github.com/iechor/buildx/issues/1442)
- Fix possible panic in `imagetools inspect`. [iechor/buildx#1441](https://github.com/iechor/buildx/issues/1441)
  [iechor/buildx#1406](https://github.com/iechor/buildx/issues/1406)
- Fix sending empty `--add-host` value to BuildKit by default. [iechor/buildx#1457](https://github.com/iechor/buildx/issues/1457)
- Fix handling progress prefixes with progress groups. [iechor/buildx#1305](https://github.com/iechor/buildx/issues/1305)
- Fix recursively resolving groups in Bake. [iechor/buildx#1313](https://github.com/iechor/buildx/issues/1313)
- Fix possible wrong indentation on multi-node builder manifests. [iechor/buildx#1396](https://github.com/iechor/buildx/issues/1396)
- Fix possible panic from missing OpenTelemetry configuration. [iechor/buildx#1383](https://github.com/iechor/buildx/issues/1383)
- Fix `--progress=tty` behavior when TTY is not available. [iechor/buildx#1371](https://github.com/iechor/buildx/issues/1371)
- Fix connection error conditions in `prune` and `du` commands. [iechor/buildx#1307](https://github.com/iechor/buildx/issues/1307)

## 0.9.1

{{< release-date date="2022-08-18" >}}

### Bug fixes and enhancements

- The `inspect` command now displays the BuildKit version in use. [iechor/buildx#1279](https://github.com/iechor/buildx/issues/1279)
- Fixed a regression when building Compose files that contain services without a
  build block. [iechor/buildx#1277](https://github.com/iechor/buildx/issues/1277)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.9.1).

## 0.9.0

{{< release-date date="2022-08-17" >}}

### New

- Support for a new [`remote` driver](drivers/remote.md) that you can use
  to connect to any already running BuildKit instance.
  [iechor/buildx#1078](https://github.com/iechor/buildx/issues/1078),
  [iechor/buildx#1093](https://github.com/iechor/buildx/issues/1093),
  [iechor/buildx#1094](https://github.com/iechor/buildx/issues/1094),
  [iechor/buildx#1103](https://github.com/iechor/buildx/issues/1103),
  [iechor/buildx#1134](https://github.com/iechor/buildx/issues/1134),
  [iechor/buildx#1204](https://github.com/iechor/buildx/issues/1204)
- You can now load iEchorfile from standard input even when the build context is
  coming from external Git or HTTP URL. [iechor/buildx#994](https://github.com/iechor/buildx/issues/994)
- Build commands now support new the build context type `oci-layout://` for loading
  [build context from local OCI layout directories](../reference/cli/iechor/buildx/build.md#source-oci-layout).
  Note that this feature depends on an unreleased BuildKit feature and builder
  instance from `moby/buildkit:master` needs to be used until BuildKit v0.11 is
  released. [iechor/buildx#1173](https://github.com/iechor/buildx/issues/1173)
- You can now use the new `--print` flag to run helper functions supported by the
  BuildKit frontend performing the build and print their results. You can use
  this feature in iEchorfile to show the build arguments and secrets that the
  current build supports with `--print=outline` and list all available
  iEchorfile stages with `--print=targets`. This feature is experimental for
  gathering early feedback and requires enabling `BUILDX_EXPERIMENTAL=1`
  environment variable. We plan to update/extend this feature in the future
  without keeping backward compatibility. [iechor/buildx#1100](https://github.com/iechor/buildx/issues/1100),
  [iechor/buildx#1272](https://github.com/iechor/buildx/issues/1272)
- You can now use the new `--invoke` flag to launch interactive containers from
  build results for an interactive debugging cycle. You can reload these
  containers with code changes or restore them to an initial state from the
  special monitor mode. This feature is experimental for gathering early
  feedback and requires enabling `BUILDX_EXPERIMENTAL=1` environment variable.
  We plan to update/extend this feature in the future without enabling backward
  compatibility.
  [iechor/buildx#1168](https://github.com/iechor/buildx/issues/1168),
  [iechor/buildx#1257](https://github.com/iechor/buildx),
  [iechor/buildx#1259](https://github.com/iechor/buildx/issues/1259)
- Buildx now understands environment variable `BUILDKIT_COLORS` and `NO_COLOR`
  to customize/disable the colors of interactive build progressbar. [iechor/buildx#1230](https://github.com/iechor/buildx/issues/1230),
  [iechor/buildx#1226](https://github.com/iechor/buildx/issues/1226)
- `buildx ls` command now shows the current BuildKit version of each builder
  instance. [iechor/buildx#998](https://github.com/iechor/buildx/issues/998)
- The `bake` command now loads `.env` file automatically when building Compose
  files for compatibility. [iechor/buildx#1261](https://github.com/iechor/buildx/issues/1261)
- Bake now supports Compose files with `cache_to` definition. [iechor/buildx#1155](https://github.com/iechor/buildx/issues/1155)
- Bake now supports new builtin function `timestamp()` to access current time. [iechor/buildx#1214](https://github.com/iechor/buildx/issues/1214)
- Bake now supports Compose build secrets definition. [iechor/buildx#1069](https://github.com/iechor/buildx/issues/1069)
- Additional build context configuration is now supported in Compose files via `x-bake`. [iechor/buildx#1256](https://github.com/iechor/buildx/issues/1256)
- Inspecting builder now shows current driver options configuration. [iechor/buildx#1003](https://github.com/iechor/buildx/issues/1003),
  [iechor/buildx#1066](https://github.com/iechor/buildx/issues/1066)

### Updates

- Updated the Compose Specification to 1.4.0. [iechor/buildx#1246](https://github.com/iechor/buildx/issues/1246),
  [iechor/buildx#1251](https://github.com/iechor/buildx/issues/1251)

### Bug fixes and enhancements

- The `buildx ls` command output has been updated with better access to errors
  from different builders. [iechor/buildx#1109](https://github.com/iechor/buildx/issues/1109)
- The `buildx create` command now performs additional validation of builder parameters
  to avoid creating a builder instance with invalid configuration. [iechor/buildx#1206](https://github.com/iechor/buildx/issues/1206)
- The `buildx imagetools create` command can now create new multi-platform images
  even if the source subimages are located on different repositories or
  registries. [iechor/buildx#1137](https://github.com/iechor/buildx/issues/1137)
- You can now set the default builder config that is used when creating
  builder instances without passing custom `--config` value. [iechor/buildx#1111](https://github.com/iechor/buildx/issues/1111)
- iEchor driver can now detect if `iechord` instance supports initially
  disabled Buildkit features like multi-platform images. [iechor/buildx#1260](https://github.com/iechor/buildx/issues/1260),
  [iechor/buildx#1262](https://github.com/iechor/buildx/issues/1262)
- Compose files using targets with `.` in the name are now converted to use `_`
  so the selector keys can still be used in such targets. [iechor/buildx#1011](https://github.com/iechor/buildx/issues/1011)
- Included an additional validation for checking valid driver configurations. [iechor/buildx#1188](https://github.com/iechor/buildx/issues/1188),
  [iechor/buildx#1273](https://github.com/iechor/buildx/issues/1273)
- The `remove` command now displays the removed builder and forbids removing
  context builders. [iechor/buildx#1128](https://github.com/iechor/buildx/issues/1128)
- Enable Azure authentication when using Kubernetes driver. [iechor/buildx#974](https://github.com/iechor/buildx/issues/974)
- Add tolerations handling for kubernetes driver. [iechor/buildx#1045](https://github.com/iechor/buildx/issues/1045)
  [iechor/buildx#1053](https://github.com/iechor/buildx/issues/1053)
- Replace deprecated seccomp annotations with `securityContext` in the `kubernetes` driver.
  [iechor/buildx#1052](https://github.com/iechor/buildx/issues/1052)
- Fix panic on handling manifests with nil platform. [iechor/buildx#1144](https://github.com/iechor/buildx/issues/1144)
- Fix using duration filter with `prune` command. [iechor/buildx#1252](https://github.com/iechor/buildx/issues/1252)
- Fix merging multiple JSON files on Bake definition. [iechor/buildx#1025](https://github.com/iechor/buildx/issues/1025)
- Fix issues with implicit builder created from iEchor context had invalid
  configuration or dropped connection. [iechor/buildx#1129](https://github.com/iechor/buildx/issues/1129)
- Fix conditions for showing no-output warning when using named contexts. [iechor/buildx#968](https://github.com/iechor/buildx/issues/968)
- Fix duplicating builders when builder instance and iechor context have the
  same name. [iechor/buildx#1131](https://github.com/iechor/buildx/issues/1131)
- Fix printing unnecessary SSH warning logs. [iechor/buildx#1085](https://github.com/iechor/buildx/issues/1085)
- Fix possible panic when using an empty variable block with Bake JSON
  definition. [iechor/buildx#1080](https://github.com/iechor/buildx/issues/1080)
- Fix image tools commands not handling `--builder` flag correctly. [iechor/buildx#1067](https://github.com/iechor/buildx/issues/1067)
- Fix using custom image together with rootless option. [iechor/buildx#1063](https://github.com/iechor/buildx/issues/1063)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.9.0).

## 0.8.2

{{< release-date date="2022-04-04" >}}

### Updates

- Update Compose spec used by `buildx bake` to v1.2.1 to fix parsing ports definition. [iechor/buildx#1033](https://github.com/iechor/buildx/issues/1033)

### Bug fixes and enhancements

- Fix possible crash on handling progress streams from BuildKit v0.10. [iechor/buildx#1042](https://github.com/iechor/buildx/issues/1042)
- Fix parsing groups in `buildx bake` when already loaded by a parent group. [iechor/buildx#1021](https://github.com/iechor/buildx/issues/1021)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.8.2).

## 0.8.1

{{< release-date date="2022-03-21" >}}

### Bug fixes and enhancements

- Fix possible panic on handling build context scanning errors. [iechor/buildx#1005](https://github.com/iechor/buildx/issues/1005)
- Allow `.` on Compose target names in `buildx bake` for backward compatibility. [iechor/buildx#1018](https://github.com/iechor/buildx/issues/1018)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.8.1).

## 0.8.0

{{< release-date date="2022-03-09" >}}

### New

- Build command now accepts `--build-context` flag to [define additional named build contexts](/reference/cli/iechor/buildx/build/#build-context)
  for your builds. [iechor/buildx#904](https://github.com/iechor/buildx/issues/904)
- Bake definitions now support [defining dependencies between targets](bake/build-contexts.md)
  and using the result of one target in another build.
  [iechor/buildx#928](https://github.com/iechor/buildx/issues/928),
  [iechor/buildx#965](https://github.com/iechor/buildx/issues/965),
  [iechor/buildx#963](https://github.com/iechor/buildx/issues/963),
  [iechor/buildx#962](https://github.com/iechor/buildx/issues/962),
  [iechor/buildx#981](https://github.com/iechor/buildx/issues/981)
- `imagetools inspect` now accepts `--format` flag allowing access to config
  and buildinfo for specific images. [iechor/buildx#854](https://github.com/iechor/buildx/issues/854),
  [iechor/buildx#972](https://github.com/iechor/buildx/issues/972)
- New flag `--no-cache-filter` allows configuring build, so it ignores cache
  only for specified iEchorfile stages. [iechor/buildx#860](https://github.com/iechor/buildx/issues/860)
- Builds can now show a summary of warnings sets by the building frontend. [iechor/buildx#892](https://github.com/iechor/buildx/issues/892)
- The new build argument `BUILDKIT_INLINE_BUILDINFO_ATTRS` allows opting-in to embed
  building attributes to resulting image. [iechor/buildx#908](https://github.com/iechor/buildx/issues/908)
- The new flag `--keep-buildkitd` allows keeping BuildKit daemon running when removing a builder
  - [iechor/buildx#852](https://github.com/iechor/buildx/issues/852)

### Bug fixes and enhancements

- `--metadata-file` output now supports embedded structure types. [iechor/buildx#946](https://github.com/iechor/buildx/issues/946)
- `buildx rm` now accepts new flag `--all-inactive` for removing all builders
  that are not currently running. [iechor/buildx#885](https://github.com/iechor/buildx/issues/885)
- Proxy config is now read from iEchor configuration file and sent with build
  requests for backward compatibility. [iechor/buildx#959](https://github.com/iechor/buildx/issues/959)
- Support host networking in Compose. [iechor/buildx#905](https://github.com/iechor/buildx/issues/905),
  [iechor/buildx#880](https://github.com/iechor/buildx/issues/880)
- Bake files can now be read from stdin with `-f -`. [iechor/buildx#864](https://github.com/iechor/buildx/issues/864)
- `--iidfile` now always writes the image config digest independently of the
  driver being used (use `--metadata-file` for digest). [iechor/buildx#980](https://github.com/iechor/buildx/issues/980)
- Target names in Bake are now restricted to not use special characters. [iechor/buildx#929](https://github.com/iechor/buildx/issues/929)
- Image manifest digest can be read from metadata when pushed with `iechor`
  driver. [iechor/buildx#989](https://github.com/iechor/buildx/issues/989)
- Fix environment file handling in Compose files. [iechor/buildx#905](https://github.com/iechor/buildx/issues/905)
- Show last access time in `du` command. [iechor/buildx#867](https://github.com/iechor/buildx/issues/867)
- Fix possible double output logs when multiple Bake targets run same build
  steps. [iechor/buildx#977](https://github.com/iechor/buildx/issues/977)
- Fix possible errors on multi-node builder building multiple targets with
  mixed platform. [iechor/buildx#985](https://github.com/iechor/buildx/issues/985)
- Fix some nested inheritance cases in Bake. [iechor/buildx#914](https://github.com/iechor/buildx/issues/914)
- Fix printing default group on Bake files. [iechor/buildx#884](https://github.com/iechor/buildx/issues/884)
- Fix `UsernsMode` when using rootless container. [iechor/buildx#887](https://github.com/iechor/buildx/issues/887)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.8.0).

## 0.7.1

{{< release-date date="2021-08-25" >}}

### Fixes

- Fix issue with matching exclude rules in `.iechorignore`. [iechor/buildx#858](https://github.com/iechor/buildx/issues/858)
- Fix `bake --print` JSON output for current group. [iechor/buildx#857](https://github.com/iechor/buildx/issues/857)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.7.1).

## 0.7.0

{{< release-date date="2021-11-10" >}}

### New features

- TLS certificates from BuildKit configuration are now transferred to build
  container with `iechor-container` and `kubernetes` drivers. [iechor/buildx#787](https://github.com/iechor/buildx/issues/787)
- Builds support `--ulimit` flag for feature parity. [iechor/buildx#800](https://github.com/iechor/buildx/issues/800)
- Builds support `--shm-size` flag for feature parity. [iechor/buildx#790](https://github.com/iechor/buildx/issues/790)
- Builds support `--quiet` for feature parity. [iechor/buildx#740](https://github.com/iechor/buildx/issues/740)
- Builds support `--cgroup-parent` flag for feature parity. [iechor/buildx#814](https://github.com/iechor/buildx/issues/814)
- Bake supports builtin variable `BAKE_LOCAL_PLATFORM`. [iechor/buildx#748](https://github.com/iechor/buildx/issues/748)
- Bake supports `x-bake` extension field in Compose files. [iechor/buildx#721](https://github.com/iechor/buildx/issues/721)
- `kubernetes` driver now supports colon-separated `KUBECONFIG`. [iechor/buildx#761](https://github.com/iechor/buildx/issues/761)
- `kubernetes` driver now supports setting Buildkit config file with `--config`. [iechor/buildx#682](https://github.com/iechor/buildx/issues/682)
- `kubernetes` driver now supports installing QEMU emulators with driver-opt. [iechor/buildx#682](https://github.com/iechor/buildx/issues/682)

### Enhancements

- Allow using custom registry configuration for multi-node pushes from the
  client. [iechor/buildx#825](https://github.com/iechor/buildx/issues/825)
- Allow using custom registry configuration for `buildx imagetools` command. [iechor/buildx#825](https://github.com/iechor/buildx/issues/825)
- Allow booting builder after creating with `buildx create --bootstrap`. [iechor/buildx#692](https://github.com/iechor/buildx/issues/692)
- Allow `registry:insecure` output option for multi-node pushes. [iechor/buildx#825](https://github.com/iechor/buildx/issues/825)
- BuildKit config and TLS files are now kept in Buildx state directory and
  reused if BuildKit instance needs to be recreated. [iechor/buildx#824](https://github.com/iechor/buildx/issues/824)
- Ensure different projects use separate destination directories for
  incremental context transfer for better performance. [iechor/buildx#817](https://github.com/iechor/buildx/issues/817)
- Build containers are now placed on separate cgroup by default. [iechor/buildx#782](https://github.com/iechor/buildx/issues/782)
- Bake now prints the default group with `--print`. [iechor/buildx#720](https://github.com/iechor/buildx/issues/720)
- `iechor` driver now dials build session over HTTP for better performance. [iechor/buildx#804](https://github.com/iechor/buildx/issues/804)

### Fixes

- Fix using `--iidfile` together with a multi-node push. [iechor/buildx#826](https://github.com/iechor/buildx/issues/826)
- Using `--push` in Bake does not clear other image export options in the file. [iechor/buildx#773](https://github.com/iechor/buildx/issues/773)
- Fix Git URL detection for `buildx bake` when `https` protocol was used. [iechor/buildx#822](https://github.com/iechor/buildx/issues/822)
- Fix pushing image with multiple names on multi-node builds. [iechor/buildx#815](https://github.com/iechor/buildx/issues/815)
- Avoid showing `--builder` flags for commands that don't use it. [iechor/buildx#818](https://github.com/iechor/buildx/issues/818)
- Unsupported build flags now show a warning. [iechor/buildx#810](https://github.com/iechor/buildx/issues/810)
- Fix reporting error details in some OpenTelemetry traces. [iechor/buildx#812](https://github.com/iechor/buildx/issues/812)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.7.0).

## 0.6.3

{{< release-date date="2021-08-30" >}}

### Fixes

- Fix BuildKit state volume location for Windows clients. [iechor/buildx#751](https://github.com/iechor/buildx/issues/751)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.6.3).

## 0.6.2

{{< release-date date="2021-08-21" >}}

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.6.2).

### Fixes

- Fix connection error showing up in some SSH configurations. [iechor/buildx#741](https://github.com/iechor/buildx/issues/741)

## 0.6.1

{{< release-date date="2021-07-30" >}}

### Enhancements

- Set `ConfigFile` to parse compose files with Bake. [iechor/buildx#704](https://github.com/iechor/buildx/issues/704)

### Fixes

- Duplicate progress env var. [iechor/buildx#693](https://github.com/iechor/buildx/issues/693)
- Should ignore nil client. [iechor/buildx#686](https://github.com/iechor/buildx/issues/686)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.6.1).

## 0.6.0

{{< release-date date="2021-07-16" >}}

### New features

- Support for OpenTelemetry traces and forwarding Buildx client traces to
  BuildKit. [iechor/buildx#635](https://github.com/iechor/buildx/issues/635)
- Experimental GitHub Actions remote cache backend with `--cache-to type=gha`
  and `--cache-from type=gha`. [iechor/buildx#535](https://github.com/iechor/buildx/issues/535)
- New `--metadata-file` flag has been added to build and Bake command that
  allows saving build result metadata in JSON format. [iechor/buildx#605](https://github.com/iechor/buildx/issues/605)
- This is the first release supporting Windows ARM64. [iechor/buildx#654](https://github.com/iechor/buildx/issues/654)
- This is the first release supporting Linux Risc-V. [iechor/buildx#652](https://github.com/iechor/buildx/issues/652)
- Bake now supports building from remote definition with local files or
  another remote source as context. [iechor/buildx#671](https://github.com/iechor/buildx/issues/671)
- Bake now allows variables to reference each other and using user functions
  in variables and vice-versa.
  [iechor/buildx#575](https://github.com/iechor/buildx/issues/575),
  [iechor/buildx#539](https://github.com/iechor/buildx/issues/539),
  [iechor/buildx#532](https://github.com/iechor/buildx/issues/532)
- Bake allows defining attributes in the global scope. [iechor/buildx#541](https://github.com/iechor/buildx/issues/541)
- Bake allows variables across multiple files. [iechor/buildx#538](https://github.com/iechor/buildx/issues/538)
- New quiet mode has been added to progress printer. [iechor/buildx#558](https://github.com/iechor/buildx/issues/558)
- `kubernetes` driver now supports defining resources/limits. [iechor/buildx#618](https://github.com/iechor/buildx/issues/618)
- Buildx binaries can now be accessed through [buildx-bin](https://hub.iechor.com/r/iechor/buildx-bin)
  iEchor image. [iechor/buildx#656](https://github.com/iechor/buildx/issues/656)

### Enhancements

- `iechor-container` driver now keeps BuildKit state in volume. Enabling
  updates with keeping state. [iechor/buildx#672](https://github.com/iechor/buildx/issues/672)
- Compose parser is now based on new [compose-go parser](https://github.com/compose-spec/compose-go)
  fixing support for some newer syntax. [iechor/buildx#669](https://github.com/iechor/buildx/issues/669)
- SSH socket is now automatically forwarded when building an ssh-based git URL. [iechor/buildx#581](https://github.com/iechor/buildx/issues/581)
- Bake HCL parser has been rewritten. [iechor/buildx#645](https://github.com/iechor/buildx/issues/645)
- Extend HCL support with more functions. [iechor/buildx#491](https://github.com/iechor/buildx/issues/491)
  [iechor/buildx#503](https://github.com/iechor/buildx/issues/503)
- Allow secrets from environment variables. [iechor/buildx#488](https://github.com/iechor/buildx/issues/488)
- Builds with an unsupported multi-platform and load configuration now fail fast. [iechor/buildx#582](https://github.com/iechor/buildx/issues/582)
- Store Kubernetes config file to make buildx builder switchable. [iechor/buildx#497](https://github.com/iechor/buildx/issues/497)
- Kubernetes now lists all pods as nodes on inspection. [iechor/buildx#477](https://github.com/iechor/buildx/issues/477)
- Default Rootless image has been set to `moby/buildkit:buildx-stable-1-rootless`. [iechor/buildx#480](https://github.com/iechor/buildx/issues/480)

### Fixes

- `imagetools create` command now correctly merges JSON descriptor with old one. [iechor/buildx#592](https://github.com/iechor/buildx/issues/592)
- Fix building with `--network=none` not requiring extra security entitlements. [iechor/buildx#531](https://github.com/iechor/buildx/issues/531)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.6.0).

## 0.5.1

{{< release-date date="2020-12-15" >}}

### Fixes

- Fix regression on setting `--platform` on `buildx create` outside
  `kubernetes` driver. [iechor/buildx#475](https://github.com/iechor/buildx/issues/475)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.5.1).

## 0.5.0

{{< release-date date="2020-12-15" >}}

### New features

- The `iechor` driver now supports the `--push` flag. [iechor/buildx#442](https://github.com/iechor/buildx/issues/442)
- Bake supports inline iEchorfiles. [iechor/buildx#398](https://github.com/iechor/buildx/issues/398)
- Bake supports building from remote URLs and Git repositories. [iechor/buildx#398](https://github.com/iechor/buildx/issues/398)
- `BUILDX_CONFIG` env var allow users to have separate buildx state from
  iEchor config. [iechor/buildx#385](https://github.com/iechor/buildx/issues/385)
- `BUILDKIT_MULTI_PLATFORM` build arg allows to force building multi-platform
  return objects even if only one `--platform` specified. [iechor/buildx#467](https://github.com/iechor/buildx/issues/467)

### Enhancements

- Allow `--append` to be used with `kubernetes` driver. [iechor/buildx#370](https://github.com/iechor/buildx/issues/370)
- Build errors show error location in source files and system stacktraces
  with `--debug`. [iechor/buildx#389](https://github.com/iechor/buildx/issues/389)
- Bake formats HCL errors with source definition. [iechor/buildx#391](https://github.com/iechor/buildx/issues/391)
- Bake allows empty string values in arrays that will be discarded. [iechor/buildx#428](https://github.com/iechor/buildx/issues/428)
- You can now use the Kubernetes cluster config with the `kubernetes` driver. [iechor/buildx#368](https://github.com/iechor/buildx/issues/368)
  [iechor/buildx#460](https://github.com/iechor/buildx/issues/460)
- Creates a temporary token for pulling images instead of sharing credentials
  when possible. [iechor/buildx#469](https://github.com/iechor/buildx/issues/469)
- Ensure credentials are passed when pulling BuildKit container image. [iechor/buildx#441](https://github.com/iechor/buildx/issues/441)
  [iechor/buildx#433](https://github.com/iechor/buildx/issues/433)
- Disable user namespace remapping in `iechor-container` driver. [iechor/buildx#462](https://github.com/iechor/buildx/issues/462)
- Allow `--builder` flag to switch to default instance. [iechor/buildx#425](https://github.com/iechor/buildx/issues/425)
- Avoid warn on empty `BUILDX_NO_DEFAULT_LOAD` config value. [iechor/buildx#390](https://github.com/iechor/buildx/issues/390)
- Replace error generated by `quiet` option by a warning. [iechor/buildx#403](https://github.com/iechor/buildx/issues/403)
- CI has been switched to GitHub Actions.
  [iechor/buildx#451](https://github.com/iechor/buildx/issues/451),
  [iechor/buildx#463](https://github.com/iechor/buildx/issues/463),
  [iechor/buildx#466](https://github.com/iechor/buildx/issues/466),
  [iechor/buildx#468](https://github.com/iechor/buildx/issues/468),
  [iechor/buildx#471](https://github.com/iechor/buildx/issues/471)

### Fixes

- Handle lowercase iEchorfile name as a fallback for backward compatibility. [iechor/buildx#444](https://github.com/iechor/buildx/issues/444)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.5.0).

## 0.4.2

{{< release-date date="2020-08-22" >}}

### New features

- Support `cacheonly` exporter. [iechor/buildx#337](https://github.com/iechor/buildx/issues/337)

### Enhancements

- Update `go-cty` to pull in more `stdlib` functions. [iechor/buildx#277](https://github.com/iechor/buildx/issues/277)
- Improve error checking on load. [iechor/buildx#281](https://github.com/iechor/buildx/issues/281)

### Fixes

- Fix parsing json config with HCL. [iechor/buildx#280](https://github.com/iechor/buildx/issues/280)
- Ensure `--builder` is wired from root options. [iechor/buildx#321](https://github.com/iechor/buildx/issues/321)
- Remove warning for multi-platform iidfile. [iechor/buildx#351](https://github.com/iechor/buildx/issues/351)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.4.2).

## 0.4.1

{{< release-date date="2020-05-01" >}}

### Fixes

- Fix regression on flag parsing. [iechor/buildx#268](https://github.com/iechor/buildx/issues/268)
- Fix using pull and no-cache keys in HCL targets. [iechor/buildx#268](https://github.com/iechor/buildx/issues/268)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.4.1).

## 0.4.0

{{< release-date date="2020-04-30" >}}

### New features

- Add `kubernetes` driver. [iechor/buildx#167](https://github.com/iechor/buildx/issues/167)
- New global `--builder` flag to override builder instance for a single command. [iechor/buildx#246](https://github.com/iechor/buildx/issues/246)
- New `prune` and `du` commands for managing local builder cache. [iechor/buildx#249](https://github.com/iechor/buildx/issues/249)
- You can now set the new `pull` and `no-cache` options for HCL targets. [iechor/buildx#165](https://github.com/iechor/buildx/issues/165)

### Enhancements

- Upgrade Bake to HCL2 with support for variables and functions. [iechor/buildx#192](https://github.com/iechor/buildx/issues/192)
- Bake now supports `--load` and `--push`. [iechor/buildx#164](https://github.com/iechor/buildx/issues/164)
- Bake now supports wildcard overrides for multiple targets. [iechor/buildx#164](https://github.com/iechor/buildx/issues/164)
- Container driver allows setting environment variables via `driver-opt`. [iechor/buildx#170](https://github.com/iechor/buildx/issues/170)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.4.0).

## 0.3.1

{{< release-date date="2019-09-27" >}}

### Enhancements

- Handle copying unix sockets instead of erroring. [iechor/buildx#155](https://github.com/iechor/buildx/issues/155)
  [moby/buildkit#1144](https://github.com/moby/buildkit/issues/1144)

### Fixes

- Running Bake with multiple Compose files now merges targets correctly. [iechor/buildx#134](https://github.com/iechor/buildx/issues/134)
- Fix bug when building a iEchorfile from stdin (`build -f -`).
  [iechor/buildx#153](https://github.com/iechor/buildx/issues/153)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.3.1).

## 0.3.0

{{< release-date date="2019-08-02" >}}

### New features

- Custom `buildkitd` daemon flags. [iechor/buildx#102](https://github.com/iechor/buildx/issues/102)
- Driver-specific options on `create`. [iechor/buildx#122](https://github.com/iechor/buildx/issues/122)

### Enhancements

- Environment variables are used in Compose files. [iechor/buildx#117](https://github.com/iechor/buildx/issues/117)
- Bake now honors `--no-cache` and `--pull`. [iechor/buildx#118](https://github.com/iechor/buildx/issues/118)
- Custom BuildKit config file. [iechor/buildx#121](https://github.com/iechor/buildx/issues/121)
- Entitlements support with `build --allow`. [iechor/buildx#104](https://github.com/iechor/buildx/issues/104)

### Fixes

- Fix bug where `--build-arg foo` would not read `foo` from environment. [iechor/buildx#116](https://github.com/iechor/buildx/issues/116)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.3.0).

## 0.2.2

{{< release-date date="2019-05-30" >}}

### Enhancements

- Change Compose file handling to require valid service specifications. [iechor/buildx#87](https://github.com/iechor/buildx/issues/87)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.2.2).

## 0.2.1

{{< release-date date="2019-05-25" >}}

### New features

- Add `BUILDKIT_PROGRESS` env var. [iechor/buildx#69](https://github.com/iechor/buildx/issues/69)
- Add `local` platform. [iechor/buildx#70](https://github.com/iechor/buildx/issues/70)

### Enhancements

- Keep arm variant if one is defined in the config. [iechor/buildx#68](https://github.com/iechor/buildx/issues/68)
- Make iechorfile relative to context. [iechor/buildx#83](https://github.com/iechor/buildx/issues/83)

### Fixes

- Fix parsing target from compose files. [iechor/buildx#53](https://github.com/iechor/buildx/issues/53)

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.2.1).

## 0.2.0

{{< release-date date="2019-04-25" >}}

### New features

- First release

For more details, see the complete release notes in the [Buildx GitHub repository](https://github.com/iechor/buildx/releases/tag/v0.2.0).
