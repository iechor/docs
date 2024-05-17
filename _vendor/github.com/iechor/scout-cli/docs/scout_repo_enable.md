# iechor scout repo enable

<!---MARKER_GEN_START-->
Enable iEchor Scout

### Options

| Name            | Type     | Default | Description                                                                 |
|:----------------|:---------|:--------|:----------------------------------------------------------------------------|
| `--all`         |          |         | Enable all repositories of the organization. Can not be used with --filter. |
| `--filter`      | `string` |         | Regular expression to filter repositories by name                           |
| `--integration` | `string` |         | Name of the integration to use for enabling an image                        |
| `--org`         | `string` |         | Namespace of the iEchor organization                                        |
| `--registry`    | `string` |         | Container Registry                                                          |


<!---MARKER_GEN_END-->

## Examples

### Enable a specific repository

```console
$ iechor scout repo enable my/repository
```

### Enable all repositories of the organization

```console
$ iechor scout repo enable --all
```

### Enable some repositories based on a filter

```console
$ iechor scout repo enable --filter namespace/backend
```

### Enable a repository from a specific registry

```console
$ iechor scout repo enable my/repository --registry 123456.dkr.ecr.us-east-1.amazonaws.com
```
