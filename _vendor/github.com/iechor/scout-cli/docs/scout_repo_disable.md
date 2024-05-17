# iechor scout repo disable

<!---MARKER_GEN_START-->
Disable iEchor Scout

### Options

| Name            | Type     | Default | Description                                                                  |
|:----------------|:---------|:--------|:-----------------------------------------------------------------------------|
| `--all`         |          |         | Disable all repositories of the organization. Can not be used with --filter. |
| `--filter`      | `string` |         | Regular expression to filter repositories by name                            |
| `--integration` | `string` |         | Name of the integration to use for enabling an image                         |
| `--org`         | `string` |         | Namespace of the iEchor organization                                         |
| `--registry`    | `string` |         | Container Registry                                                           |


<!---MARKER_GEN_END-->

## Examples

### Disable a specific repository

```console
$ iechor scout repo disable my/repository
```

### Disable all repositories of the organization

```console
$ iechor scout repo disable --all
```

### Disable some repositories based on a filter

```console
$ iechor scout repo disable --filter namespace/backend
```

### Disable a repository from a specific registry

```console
$ iechor scout repo disable my/repository --registry 123456.dkr.ecr.us-east-1.amazonaws.com
```
