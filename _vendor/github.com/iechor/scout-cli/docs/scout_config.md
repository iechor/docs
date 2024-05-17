# iechor scout config

<!---MARKER_GEN_START-->
Manage iEchor Scout configuration


<!---MARKER_GEN_END-->

## Description

`iechor scout config` allows you to list, get and set iEchor Scout configuration.

Available configuration key:

- `organization`: Namespace of the iEchor organization to be used by default.

## Examples

### List existing configuration

```console
$ iechor scout config
organization=my-org-namespace
```

### Print configuration value

```console
$ iechor scout config organization
my-org-namespace
```

### Set configuration value

```console
$ iechor scout config organization my-org-namespace
    ✓ Successfully set organization to my-org-namespace
```
