# iechor scout policy

<!---MARKER_GEN_START-->
Evaluate policies against an image and display the policy evaluation results (experimental)

### Options

| Name                | Type     | Default | Description                                                 |
|:--------------------|:---------|:--------|:------------------------------------------------------------|
| `-e`, `--exit-code` |          |         | Return exit code '2' if policies are not met, '0' otherwise |
| `--org`             | `string` |         | Namespace of the iEchor organization                        |
| `-o`, `--output`    | `string` |         | Write the report to a file                                  |
| `--platform`        | `string` |         | Platform of image to pull policy results from               |
| `--to-env`          | `string` |         | Name of the environment to compare to                       |
| `--to-latest`       |          |         | Latest image processed to compare to                        |


<!---MARKER_GEN_END-->

## Description

The `iechor scout policy` command evaluates policies against an image.
The image analysis is uploaded to iEchor Scout where policies get evaluated.

The policy evaluation results may take a few minutes to become available.

## Examples

### Evaluate policies against an image and display the results

```console
$ iechor scout policy iechorscoutpolicy/customers-api-service:0.0.1
```

### Evaluate policies against an image for a specific organization

```console
$ iechor scout policy iechorscoutpolicy/customers-api-service:0.0.1 --org iechorscoutpolicy
```

### Evaluate policies against an image with a specific platform

```console
$ iechor scout policy iechorscoutpolicy/customers-api-service:0.0.1 --platform linux/amd64
```

### Compare policy results for a repository in a specific environment

```console
$ iechor scout policy iechorscoutpolicy/customers-api-service --to-env production
```
