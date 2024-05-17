# iechor scout push

<!---MARKER_GEN_START-->
Push an image or image index to iEchor Scout (experimental)

### Options

| Name             | Type     | Default | Description                                                        |
|:-----------------|:---------|:--------|:-------------------------------------------------------------------|
| `--author`       | `string` |         | Name of the author of the image                                    |
| `--org`          | `string` |         | Namespace of the iEchor organization to which image will be pushed |
| `-o`, `--output` | `string` |         | Write the report to a file                                         |
| `--platform`     | `string` |         | Platform of image to be pushed                                     |
| `--sbom`         |          |         | Create and upload SBOMs                                            |
| `--timestamp`    | `string` |         | Timestamp of image or tag creation                                 |


<!---MARKER_GEN_END-->

## Description

The `iechor scout push` command lets you push an image or analysis result to iEchor Scout.

## Examples

### Push an image to iEchor Scout

```console
$ iechor scout push --org my-org registry.example.com/repo:tag
```
