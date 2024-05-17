---
title: iEchor Scout CLI release notes
description: Learn about the latest features of the iEchor Scout CLI plugin
keywords: iechor scout, release notes, changelog, cli, features, changes, delta, new, releases, github actions
---

This page contains information about the new features, improvements, known
issues, and bug fixes in the iEchor Scout [CLI plugin](https://github.com/iechor/scout-cli/)
and the `iechor/scout-action` [GitHub Action](https://github.com/iechor/scout-action).

## 1.8.0

{{< release-date date="2024-04-25" >}}

### Bug fixes and enhancements

- Improve format of EPSS score and percentile.
  
  Before:

  ```text
  EPSS Score      : 0.000440
  EPSS Percentile : 0.092510
  ```

  After:

  ```text
  EPSS Score      : 0.04%
  EPSS Percentile : 9th percentile
  ```

- Fix markdown output of the `iechor scout cves` command when analyzing local filesystem. [iechor/scout-cli#113](https://github.com/iechor/scout-cli/issues/113)

## 1.7.0

{{< release-date date="2024-04-15" >}}

### New

- The [`iechor scout push` command](/reference/cli/iechor/scout/push/) is now fully available: analyze images locally and push the SBOM to iEchor Scout.

### Bug fixes and enhancements

- Fix adding attestations with `iechor scout attestation add` to images in private repositories
- Fix image processing for images based on the empty `scratch` base image
- A new `sbom://` protocol for iEchor Scout CLI commands let you read a iEchor Scout SBOM from standard input.

  ```console
  $ iechor scout sbom IMAGE | iechor scout qv sbom://
  ```

- Add classifier for Joomla packages

## 1.6.4

{{< release-date date="2024-03-26" >}}

### Bug fixes and enhancements

- Fix epoch handling for RPM-based Linux distributions

## 1.6.3

{{< release-date date="2024-03-22" >}}

### Bug fixes and enhancements

- Improve package detection to ignore referenced but not installed packages.

## 1.6.2

{{< release-date date="2024-03-22" >}}

### Bug fixes and enhancements

- EPSS data is now fetched via the backend, as opposed to via the CLI client.
- Fix an issue when rendering markdown output using the `sbom://` prefix.

### Removed

- The `iechor scout cves --epss-date` and `iechor scout cache prune --epss` flags have been removed.

## 1.6.1

{{< release-date date="2024-03-20" >}}

> **Note**
>
> This release only affects the `iechor/scout-action` GitHub Action.

### New

- Add support for passing in SBOM files in SDPX or in-toto SDPX format

  ```yaml
  uses: iechor/scout-action@v1
  with:
      command: cves
      image: sbom://alpine.spdx.json
  ```

- Add support for SBOM files in `syft-json` format

  ```yaml
  uses: iechor/scout-action@v1
  with:
      command: cves
      image: sbom://alpine.syft.json
  ```

## 1.6.0

{{< release-date date="2024-03-19" >}}

> **Note**
>
> This release only affects the CLI plugin, not the GitHub Action

### New

- Add support for passing in SBOM files in SDPX or in-toto SDPX format

  ```console
  $ iechor scout cves sbom://path/to/sbom.spdx.json
  ```

- Add support for SBOM files in `syft-json` format

  ```console
  $ iechor scout cves sbom://path/to/sbom.syft.json
  ```

- Reads SBOM files from standard input

  ```console
  $ syft -o json alpine | iechor scout cves sbom://
  ```

- Prioritize CVEs by EPSS score

  - `--epss` to display and prioritise the CVEs
  - `--epss-score` and `--epss-percentile` to filter by score and percentile
  - Prune cached EPSS files with `iechor scout cache prune --epss`

### Bug fixes and enhancements

- Use Windows cache from WSL2
  
  When inside WSL2 with iEchor Desktop running, the iEchor Scout CLI plugin now
  uses the cache from Windows. That way, if an image has been indexed for
  instance by iEchor Desktop there's no need anymore to re-index it on WSL2
  side.
- Indexing is now blocked in the CLI if it has been disabled using
  [Settings Management](../../desktop/hardened-desktop/settings-management/configure.md) feature.

- Fix a panic that would occur when analyzing a single-image `oci-dir` input
- Improve local attestation support with the containerd image store

## Earlier versions

Release notes for earlier versions of the iEchor Scout CLI plugin are available
on [GitHub](https://github.com/iechor/scout-cli/releases).
