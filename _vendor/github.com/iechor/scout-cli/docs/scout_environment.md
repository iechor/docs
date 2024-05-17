# iechor scout environment

<!---MARKER_GEN_START-->
Manage environments (experimental)

### Aliases

`iechor scout environment`, `iechor scout env`

### Options

| Name             | Type     | Default | Description                          |
|:-----------------|:---------|:--------|:-------------------------------------|
| `--org`          | `string` |         | Namespace of the iEchor organization |
| `-o`, `--output` | `string` |         | Write the report to a file           |
| `--platform`     | `string` |         | Platform of image to record          |


<!---MARKER_GEN_END-->

## Description

The `iechor scout environment` command lists the environments.
If you pass an image reference, the image is recorded to the specified environment.

Once recorded, environments can be referred to by their name. For example,
you can refer to the `production` environment with the `iechor scout compare`
command as follows:

```console
$ iechor scout compare --to-env production
```

## Examples

### List existing environments

```console
$ iechor scout environment
prod
staging
```

### List images of an environment

```console
$ iechor scout environment staging
namespace/repo:tag@sha256:9a4df4fadc9bbd44c345e473e0688c2066a6583d4741679494ba9228cfd93e1b
namespace/other-repo:tag@sha256:0001d6ce124855b0a158569c584162097fe0ca8d72519067c2c8e3ce407c580f
```

### Record an image to an environment, for a specific platform

```console
$ iechor scout environment staging namespace/repo:stage-latest --platform linux/amd64
✓ Pulled
✓ Successfully recorded namespace/repo:stage-latest in environment staging
```
