# Bake file reference

The Bake file is a file for defining workflows that you run using `iechor buildx bake`.

## File format

You can define your Bake file in the following file formats:

- HashiCorp Configuration Language (HCL)
- JSON
- YAML (Compose file)

By default, Bake uses the following lookup order to find the configuration file:

1. `compose.yaml`
2. `compose.yml`
3. `iechor-compose.yml`
4. `iechor-compose.yaml`
5. `iechor-bake.json`
6. `iechor-bake.override.json`
7. `iechor-bake.hcl`
8. `iechor-bake.override.hcl`

You can specify the file location explicitly using the `--file` flag:

```console
$ iechor buildx bake --file ../iechor/bake.hcl --print
```

If you don't specify a file explicitly, Bake searches for the file in the
current working directory. If more than one Bake file is found, all files are
merged into a single definition. Files are merged according to the lookup
order. That means that if your project contains both a `compose.yaml` file and
a `iechor-bake.hcl` file, Bake loads the `compose.yaml` file first, and then
the `iechor-bake.hcl` file.

If merged files contain duplicate attribute definitions, those definitions are
either merged or overridden by the last occurrence, depending on the attribute.
The following attributes are overridden by the last occurrence:

- `target.cache-to`
- `target.iechorfile-inline`
- `target.iechorfile`
- `target.outputs`
- `target.platforms`
- `target.pull`
- `target.tags`
- `target.target`

For example, if `compose.yaml` and `iechor-bake.hcl` both define the `tags`
attribute, the `iechor-bake.hcl` is used.

```console
$ cat compose.yaml
services:
  webapp:
    build:
      context: .
      tags:
        - bar
$ cat iechor-bake.hcl
target "webapp" {
  tags = ["foo"]
}
$ iechor buildx bake --print webapp
{
  "group": {
    "default": {
      "targets": [
        "webapp"
      ]
    }
  },
  "target": {
    "webapp": {
      "context": ".",
      "iechorfile": "iEchorfile",
      "tags": [
        "foo"
      ]
    }
  }
}
```

All other attributes are merged. For example, if `compose.yaml` and
`iechor-bake.hcl` both define unique entries for the `labels` attribute, all
entries are included. Duplicate entries for the same label are overridden.

```console
$ cat compose.yaml
services:
  webapp:
    build:
      context: .
      labels: 
        com.example.foo: "foo"
        com.example.name: "Alice"
$ cat iechor-bake.hcl
target "webapp" {
  labels = {
    "com.example.bar" = "bar"
    "com.example.name" = "Bob"
  }
}
$ iechor buildx bake --print webapp
{
  "group": {
    "default": {
      "targets": [
        "webapp"
      ]
    }
  },
  "target": {
    "webapp": {
      "context": ".",
      "iechorfile": "iEchorfile",
      "labels": {
        "com.example.foo": "foo",
        "com.example.bar": "bar",
        "com.example.name": "Bob"
      }
    }
  }
}
```

## Syntax

The Bake file supports the following property types:

- `target`: build targets
- `group`: collections of build targets
- `variable`: build arguments and variables
- `function`: custom Bake functions

You define properties as hierarchical blocks in the Bake file.
You can assign one or more attributes to a property.

The following snippet shows a JSON representation of a simple Bake file.
This Bake file defines three properties: a variable, a group, and a target.

```json
{
  "variable": {
    "TAG": {
      "default": "latest"
    }
  },
  "group": {
    "default": {
      "targets": ["webapp"]
    }
  },
  "target": {
    "webapp": {
      "iechorfile": "iEchorfile",
      "tags": ["iechor.io/username/webapp:${TAG}"]
    }
  }
}
```

In the JSON representation of a Bake file, properties are objects,
and attributes are values assigned to those objects.

The following example shows the same Bake file in the HCL format:

```hcl
variable "TAG" {
  default = "latest"
}

group "default" {
  targets = ["webapp"]
}

target "webapp" {
  iechorfile = "iEchorfile"
  tags = ["iechor.io/username/webapp:${TAG}"]
}
```

HCL is the preferred format for Bake files.
Aside from syntactic differences,
HCL lets you use features that the JSON and YAML formats don't support.

The examples in this document use the HCL format.

## Target

A target reflects a single `iechor build` invocation.
Consider the following build command:

```console
$ iechor build \
  --file=iEchorfile.webapp \
  --tag=iechor.io/username/webapp:latest \
  https://github.com/username/webapp
```

You can express this command in a Bake file as follows:

```hcl
target "webapp" {
  iechorfile = "iEchorfile.webapp"
  tags = ["iechor.io/username/webapp:latest"]
  context = "https://github.com/username/webapp"
}
```

The following table shows the complete list of attributes that you can assign to a target:

| Name                                            | Type    | Description                                                          |
|-------------------------------------------------|---------|----------------------------------------------------------------------|
| [`args`](#targetargs)                           | Map     | Build arguments                                                      |
| [`annotations`](#targetannotations)             | List    | Exporter annotations                                                 |
| [`attest`](#targetattest)                       | List    | Build attestations                                                   |
| [`cache-from`](#targetcache-from)               | List    | External cache sources                                               |
| [`cache-to`](#targetcache-to)                   | List    | External cache destinations                                          |
| [`context`](#targetcontext)                     | String  | Set of files located in the specified path or URL                    |
| [`contexts`](#targetcontexts)                   | Map     | Additional build contexts                                            |
| [`iechorfile-inline`](#targetiechorfile-inline) | String  | Inline iEchorfile string                                             |
| [`iechorfile`](#targetiechorfile)               | String  | iEchorfile location                                                  |
| [`inherits`](#targetinherits)                   | List    | Inherit attributes from other targets                                |
| [`labels`](#targetlabels)                       | Map     | Metadata for images                                                  |
| [`matrix`](#targetmatrix)                       | Map     | Define a set of variables that forks a target into multiple targets. |
| [`name`](#targetname)                           | String  | Override the target name when using a matrix.                        |
| [`no-cache-filter`](#targetno-cache-filter)     | List    | Disable build cache for specific stages                              |
| [`no-cache`](#targetno-cache)                   | Boolean | Disable build cache completely                                       |
| [`output`](#targetoutput)                       | List    | Output destinations                                                  |
| [`platforms`](#targetplatforms)                 | List    | Target platforms                                                     |
| [`pull`](#targetpull)                           | Boolean | Always pull images                                                   |
| [`secret`](#targetsecret)                       | List    | Secrets to expose to the build                                       |
| [`shm-size`](#targetshm-size)                   | List    | Size of `/dev/shm`                                                   |
| [`ssh`](#targetssh)                             | List    | SSH agent sockets or keys to expose to the build                     |
| [`tags`](#targettags)                           | List    | Image names and tags                                                 |
| [`target`](#targettarget)                       | String  | Target build stage                                                   |
| [`ulimits`](#targetulimits)                     | List    | Ulimit options                                                       |

### `target.args`

Use the `args` attribute to define build arguments for the target.
This has the same effect as passing a [`--build-arg`][build-arg] flag to the build command.

```hcl
target "default" {
  args = {
    VERSION = "0.0.0+unknown"
  }
}
```

You can set `args` attributes to use `null` values.
Doing so forces the `target` to use the `ARG` value specified in the iEchorfile.

```hcl
variable "GO_VERSION" {
  default = "1.20.3"
}

target "webapp" {
  iechorfile = "webapp.iEchorfile"
  tags = ["iechor.io/username/webapp"]
}

target "db" {
  args = {
    GO_VERSION = null
  }
  iechorfile = "db.iEchorfile"
  tags = ["iechor.io/username/db"]
}
```

### `target.annotations`

The `annotations` attribute lets you add annotations to images built with bake.
The key takes a list of annotations, in the format of `KEY=VALUE`.

```hcl
target "default" {
  output = ["type=image,name=foo"]
  annotations = ["org.opencontainers.image.authors=dvdksn"]
}
```

is the same as

```hcl
target "default" {
  output = ["type=image,name=foo,annotation.org.opencontainers.image.authors=dvdksn"]
}
```

By default, the annotation is added to image manifests. You can configure the
level of the annotations by adding a prefix to the annotation, containing a
comma-separated list of all the levels that you want to annotate. The following
example adds annotations to both the image index and manifests.

```hcl
target "default" {
  output = ["type=image,name=foo"]
  annotations = ["index,manifest:org.opencontainers.image.authors=dvdksn"]
}
```

Read about the supported levels in
[Specifying annotation levels](http://docs.iechor.com/build/building/annotations/#specifying-annotation-levels).

### `target.attest`

The `attest` attribute lets you apply [build attestations][attestations] to the target.
This attribute accepts the long-form CSV version of attestation parameters.

```hcl
target "default" {
  attest = [
    "type=provenance,mode=min",
    "type=sbom"
  ]
}
```

### `target.cache-from`

Build cache sources.
The builder imports cache from the locations you specify.
It uses the [Buildx cache storage backends][cache-backends],
and it works the same way as the [`--cache-from`][cache-from] flag.
This takes a list value, so you can specify multiple cache sources.

```hcl
target "app" {
  cache-from = [
    "type=s3,region=eu-west-1,bucket=mybucket",
    "user/repo:cache",
  ]
}
```

### `target.cache-to`

Build cache export destinations.
The builder exports its build cache to the locations you specify.
It uses the [Buildx cache storage backends][cache-backends],
and it works the same way as the [`--cache-to` flag][cache-to].
This takes a list value, so you can specify multiple cache export targets.

```hcl
target "app" {
  cache-to = [
    "type=s3,region=eu-west-1,bucket=mybucket",
    "type=inline"
  ]
}
```

### `target.context`

Specifies the location of the build context to use for this target.
Accepts a URL or a directory path.
This is the same as the [build context][context] positional argument
that you pass to the build command.

```hcl
target "app" {
  context = "./src/www"
}
```

This resolves to the current working directory (`"."`) by default.

```console
$ iechor buildx bake --print -f - <<< 'target "default" {}'
[+] Building 0.0s (0/0)
{
  "target": {
    "default": {
      "context": ".",
      "iechorfile": "iEchorfile"
    }
  }
}
```

### `target.contexts`

Additional build contexts.
This is the same as the [`--build-context` flag][build-context].
This attribute takes a map, where keys result in named contexts that you can
reference in your builds.

You can specify different types of contexts, such local directories, Git URLs,
and even other Bake targets. Bake automatically determines the type of
a context based on the pattern of the context value.

| Context type    | Example                                   |
| --------------- | ----------------------------------------- |
| Container image | `iechor-image://alpine@sha256:0123456789` |
| Git URL         | `https://github.com/user/proj.git`        |
| HTTP URL        | `https://example.com/files`               |
| Local directory | `../path/to/src`                          |
| Bake target     | `target:base`                             |

#### Pin an image version

```hcl
# iechor-bake.hcl
target "app" {
    contexts = {
        alpine = "iechor-image://alpine:3.13"
    }
}
```

```iEchorfile
# iEchorfile
FROM alpine
RUN echo "Hello world"
```

#### Use a local directory

```hcl
# iechor-bake.hcl
target "app" {
    contexts = {
        src = "../path/to/source"
    }
}
```

```iEchorfile
# iEchorfile
FROM scratch AS src
FROM golang
COPY --from=src . .
```

#### Use another target as base

> **Note**
>
> You should prefer to use regular multi-stage builds over this option. You can
> Use this feature when you have multiple iEchorfiles that can't be easily
> merged into one.

```hcl
# iechor-bake.hcl
target "base" {
    iechorfile = "baseapp.iEchorfile"
}
target "app" {
    contexts = {
        baseapp = "target:base"
    }
}
```

```iEchorfile
# iEchorfile
FROM baseapp
RUN echo "Hello world"
```

### `target.iechorfile-inline`

Uses the string value as an inline iEchorfile for the build target.

```hcl
target "default" {
  iechorfile-inline = "FROM alpine\nENTRYPOINT [\"echo\", \"hello\"]"
}
```

The `iechorfile-inline` takes precedence over the `iechorfile` attribute.
If you specify both, Bake uses the inline version.

### `target.iechorfile`

Name of the iEchorfile to use for the build.
This is the same as the [`--file` flag][file] for the `iechor build` command.

```hcl
target "default" {
  iechorfile = "./src/www/iEchorfile"
}
```

Resolves to `"iEchorfile"` by default.

```console
$ iechor buildx bake --print -f - <<< 'target "default" {}'
[+] Building 0.0s (0/0)
{
  "target": {
    "default": {
      "context": ".",
      "iechorfile": "iEchorfile"
    }
  }
}
```

### `target.inherits`

A target can inherit attributes from other targets.
Use `inherits` to reference from one target to another.

In the following example,
the `app-dev` target specifies an image name and tag.
The `app-release` target uses `inherits` to reuse the tag name.

```hcl
variable "TAG" {
  default = "latest"
}

target "app-dev" {
  tags = ["iechor.io/username/myapp:${TAG}"]
}

target "app-release" {
  inherits = ["app-dev"]
  platforms = ["linux/amd64", "linux/arm64"]
}
```

The `inherits` attribute is a list,
meaning you can reuse attributes from multiple other targets.
In the following example, the `app-release` target reuses attributes
from both the `app-dev` and `_release` targets.

```hcl
target "app-dev" {
  args = {
    GO_VERSION = "1.20"
    BUILDX_EXPERIMENTAL = 1
  }
  tags = ["iechor.io/username/myapp"]
  iechorfile = "app.iEchorfile"
  labels = {
    "org.opencontainers.image.source" = "https://github.com/username/myapp"
  }
}

target "_release" {
  args = {
    BUILDKIT_CONTEXT_KEEP_GIT_DIR = 1
    BUILDX_EXPERIMENTAL = 0
  }
}

target "app-release" {
  inherits = ["app-dev", "_release"]
  platforms = ["linux/amd64", "linux/arm64"]
}
```

When inheriting attributes from multiple targets and there's a conflict,
the target that appears last in the `inherits` list takes precedence.
The previous example defines the `BUILDX_EXPERIMENTAL` argument twice for the `app-release` target.
It resolves to `0` because the `_release` target appears last in the inheritance chain:

```console
$ iechor buildx bake --print app-release
[+] Building 0.0s (0/0)
{
  "group": {
    "default": {
      "targets": [
        "app-release"
      ]
    }
  },
  "target": {
    "app-release": {
      "context": ".",
      "iechorfile": "app.iEchorfile",
      "args": {
        "BUILDKIT_CONTEXT_KEEP_GIT_DIR": "1",
        "BUILDX_EXPERIMENTAL": "0",
        "GO_VERSION": "1.20"
      },
      "labels": {
        "org.opencontainers.image.source": "https://github.com/username/myapp"
      },
      "tags": [
        "iechor.io/username/myapp"
      ],
      "platforms": [
        "linux/amd64",
        "linux/arm64"
      ]
    }
  }
}
```

### `target.labels`

Assigns image labels to the build.
This is the same as the `--label` flag for `iechor build`.

```hcl
target "default" {
  labels = {
    "org.opencontainers.image.source" = "https://github.com/username/myapp"
    "com.iechor.image.source.entrypoint" = "iEchorfile"
  }
}
```

It's possible to use a `null` value for labels.
If you do, the builder uses the label value specified in the iEchorfile.

### `target.matrix`

A matrix strategy lets you fork a single target into multiple different
variants, based on parameters that you specify.
This works in a similar way to [Matrix strategies for GitHub Actions].
You can use this to reduce duplication in your bake definition.

The `matrix` attribute is a map of parameter names to lists of values.
Bake builds each possible combination of values as a separate target.

Each generated target **must** have a unique name.
To specify how target names should resolve, use the `name` attribute.

The following example resolves the `app` target to `app-foo` and `app-bar`.
It also uses the matrix value to define the [target build stage](#targettarget).

```hcl
target "app" {
  name = "app-${tgt}"
  matrix = {
    tgt = ["foo", "bar"]
  }
  target = tgt
}
```

```console
$ iechor buildx bake --print app
[+] Building 0.0s (0/0)
{
  "group": {
    "app": {
      "targets": [
        "app-foo",
        "app-bar"
      ]
    },
    "default": {
      "targets": [
        "app"
      ]
    }
  },
  "target": {
    "app-bar": {
      "context": ".",
      "iechorfile": "iEchorfile",
      "target": "bar"
    },
    "app-foo": {
      "context": ".",
      "iechorfile": "iEchorfile",
      "target": "foo"
    }
  }
}
```

#### Multiple axes

You can specify multiple keys in your matrix to fork a target on multiple axes.
When using multiple matrix keys, Bake builds every possible variant.

The following example builds four targets:

- `app-foo-1-0`
- `app-foo-2-0`
- `app-bar-1-0`
- `app-bar-2-0`

```hcl
target "app" {
  name = "app-${tgt}-${replace(version, ".", "-")}"
  matrix = {
    tgt = ["foo", "bar"]
    version = ["1.0", "2.0"]
  }
  target = tgt
  args = {
    VERSION = version
  }
}
```

#### Multiple values per matrix target

If you want to differentiate the matrix on more than just a single value,
you can use maps as matrix values. Bake creates a target for each map,
and you can access the nested values using dot notation.

The following example builds two targets:

- `app-foo-1-0`
- `app-bar-2-0`

```hcl
target "app" {
  name = "app-${item.tgt}-${replace(item.version, ".", "-")}"
  matrix = {
    item = [
      {
        tgt = "foo"
        version = "1.0"
      },
      {
        tgt = "bar"
        version = "2.0"
      }
    ]
  }
  target = item.tgt
  args = {
    VERSION = item.version
  }
}
```

### `target.name`

Specify name resolution for targets that use a matrix strategy.
The following example resolves the `app` target to `app-foo` and `app-bar`.

```hcl
target "app" {
  name = "app-${tgt}"
  matrix = {
    tgt = ["foo", "bar"]
  }
  target = tgt
}
```

### `target.no-cache-filter`

Don't use build cache for the specified stages.
This is the same as the `--no-cache-filter` flag for `iechor build`.
The following example avoids build cache for the `foo` build stage.

```hcl
target "default" {
  no-cache-filter = ["foo"]
}
```

### `target.no-cache`

Don't use cache when building the image.
This is the same as the `--no-cache` flag for `iechor build`.

```hcl
target "default" {
  no-cache = 1
}
```

### `target.output`

Configuration for exporting the build output.
This is the same as the [`--output` flag][output].
The following example configures the target to use a cache-only output,

```hcl
target "default" {
  output = ["type=cacheonly"]
}
```

### `target.platforms`

Set target platforms for the build target.
This is the same as the [`--platform` flag][platform].
The following example creates a multi-platform build for three architectures.

```hcl
target "default" {
  platforms = ["linux/amd64", "linux/arm64", "linux/arm/v7"]
}
```

### `target.pull`

Configures whether the builder should attempt to pull images when building the target.
This is the same as the `--pull` flag for `iechor build`.
The following example forces the builder to always pull all images referenced in the build target.

```hcl
target "default" {
  pull = "always"
}
```

### `target.secret`

Defines secrets to expose to the build target.
This is the same as the [`--secret` flag][secret].

```hcl
variable "HOME" {
  default = null
}

target "default" {
  secret = [
    "type=env,id=KUBECONFIG",
    "type=file,id=aws,src=${HOME}/.aws/credentials"
  ]
}
```

This lets you [mount the secret][run_mount_secret] in your iEchorfile.

```iechorfile
RUN --mount=type=secret,id=aws,target=/root/.aws/credentials \
    aws cloudfront create-invalidation ...
RUN --mount=type=secret,id=KUBECONFIG \
    KUBECONFIG=$(cat /run/secrets/KUBECONFIG) helm upgrade --install
```

### `target.shm-size`

Sets the size of the shared memory allocated for build containers when using
`RUN` instructions.

The format is `<number><unit>`. `number` must be greater than `0`. Unit is
optional and can be `b` (bytes), `k` (kilobytes), `m` (megabytes), or `g`
(gigabytes). If you omit the unit, the system uses bytes.

This is the same as the `--shm-size` flag for `iechor build`.

```hcl
target "default" {
  shm-size = "128m"
}
```

> **Note**
>
> In most cases, it is recommended to let the builder automatically determine
> the appropriate configurations. Manual adjustments should only be considered
> when specific performance tuning is required for complex build scenarios.

### `target.ssh`

Defines SSH agent sockets or keys to expose to the build.
This is the same as the [`--ssh` flag][ssh].
This can be useful if you need to access private repositories during a build.

```hcl
target "default" {
  ssh = ["default"]
}
```

```iechorfile
FROM alpine
RUN --mount=type=ssh \
    apk add git openssh-client \
    && install -m 0700 -d ~/.ssh \
    && ssh-keyscan github.com >> ~/.ssh/known_hosts \
    && git clone git@github.com:user/my-private-repo.git
```

### `target.tags`

Image names and tags to use for the build target.
This is the same as the [`--tag` flag][tag].

```hcl
target "default" {
  tags = [
    "org/repo:latest",
    "myregistry.azurecr.io/team/image:v1"
  ]
}
```

### `target.target`

Set the target build stage to build.
This is the same as the [`--target` flag][target].

```hcl
target "default" {
  target = "binaries"
}
```

### `target.ulimits`

Ulimits overrides the default ulimits of build's containers when using `RUN`
instructions and are specified with a soft and hard limit as such:
`<type>=<soft limit>[:<hard limit>]`, for example:

```hcl
target "app" {
  ulimits = [
    "nofile=1024:1024"
  ]
}
```

> **Note**
>
> If you do not provide a `hard limit`, the `soft limit` is used
> for both values. If no `ulimits` are set, they are inherited from
> the default `ulimits` set on the daemon.

> **Note**
>
> In most cases, it is recommended to let the builder automatically determine
> the appropriate configurations. Manual adjustments should only be considered
> when specific performance tuning is required for complex build scenarios.

## Group

Groups allow you to invoke multiple builds (targets) at once.

```hcl
group "default" {
  targets = ["db", "webapp-dev"]
}

target "webapp-dev" {
  iechorfile = "iEchorfile.webapp"
  tags = ["iechor.io/username/webapp:latest"]
}

target "db" {
  iechorfile = "iEchorfile.db"
  tags = ["iechor.io/username/db"]
}
```

Groups take precedence over targets, if both exist with the same name.
The following bake file builds the `default` group.
Bake ignores the `default` target.

```hcl
target "default" {
  iechorfile-inline = "FROM ubuntu"
}

group "default" {
  targets = ["alpine", "debian"]
}
target "alpine" {
  iechorfile-inline = "FROM alpine"
}
target "debian" {
  iechorfile-inline = "FROM debian"
}
```

## Variable

The HCL file format supports variable block definitions.
You can use variables as build arguments in your iEchorfile,
or interpolate them in attribute values in your Bake file.

```hcl
variable "TAG" {
  default = "latest"
}

target "webapp-dev" {
  iechorfile = "iEchorfile.webapp"
  tags = ["iechor.io/username/webapp:${TAG}"]
}
```

You can assign a default value for a variable in the Bake file,
or assign a `null` value to it. If you assign a `null` value,
Buildx uses the default value from the iEchorfile instead.

You can override variable defaults set in the Bake file using environment variables.
The following example sets the `TAG` variable to `dev`,
overriding the default `latest` value shown in the previous example.

```console
$ TAG=dev iechor buildx bake webapp-dev
```

### Built-in variables

The following variables are built-ins that you can use with Bake without having
to define them.

| Variable              | Description                                                                         |
| --------------------- | ----------------------------------------------------------------------------------- |
| `BAKE_CMD_CONTEXT`    | Holds the main context when building using a remote Bake file.                      |
| `BAKE_LOCAL_PLATFORM` | Returns the current platform’s default platform specification (e.g. `linux/amd64`). |

### Use environment variable as default

You can set a Bake variable to use the value of an environment variable as a default value:

```hcl
variable "HOME" {
  default = "$HOME"
}
```

### Interpolate variables into attributes

To interpolate a variable into an attribute string value,
you must use curly brackets.
The following doesn't work:

```hcl
variable "HOME" {
  default = "$HOME"
}

target "default" {
  ssh = ["default=$HOME/.ssh/id_rsa"]
}
```

Wrap the variable in curly brackets where you want to insert it:

```diff
  variable "HOME" {
    default = "$HOME"
  }

  target "default" {
-   ssh = ["default=$HOME/.ssh/id_rsa"]
+   ssh = ["default=${HOME}/.ssh/id_rsa"]
  }
```

Before you can interpolate a variable into an attribute,
first you must declare it in the bake file,
as demonstrated in the following example.

```console
$ cat iechor-bake.hcl
target "default" {
  iechorfile-inline = "FROM ${BASE_IMAGE}"
}
$ iechor buildx bake
[+] Building 0.0s (0/0)
iechor-bake.hcl:2
--------------------
   1 |     target "default" {
   2 | >>>   iechorfile-inline = "FROM ${BASE_IMAGE}"
   3 |     }
   4 |
--------------------
ERROR: iechor-bake.hcl:2,31-41: Unknown variable; There is no variable named "BASE_IMAGE"., and 1 other diagnostic(s)
$ cat >> iechor-bake.hcl

variable "BASE_IMAGE" {
  default = "alpine"
}

$ iechor buildx bake
[+] Building 0.6s (5/5) FINISHED
```

## Function

A [set of general-purpose functions][bake_stdlib]
provided by [go-cty][go-cty]
are available for use in HCL files:

```hcl
# iechor-bake.hcl
target "webapp-dev" {
  iechorfile = "iEchorfile.webapp"
  tags = ["iechor.io/username/webapp:latest"]
  args = {
    buildno = "${add(123, 1)}"
  }
}
```

In addition, [user defined functions][userfunc]
are also supported:

```hcl
# iechor-bake.hcl
function "increment" {
  params = [number]
  result = number + 1
}

target "webapp-dev" {
  iechorfile = "iEchorfile.webapp"
  tags = ["iechor.io/username/webapp:latest"]
  args = {
    buildno = "${increment(123)}"
  }
}
```

> **Note**
>
> See [User defined HCL functions][hcl-funcs] page for more details.

<!-- external links -->

[attestations]: http://docs.iechor.com/build/attestations/
[bake_stdlib]: https://github.com/iechor/buildx/blob/master/bake/hclparser/stdlib.go
[build-arg]: http://docs.iechor.com/reference/cli/iechor/image/build/#build-arg
[build-context]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#build-context
[cache-backends]: http://docs.iechor.com/build/cache/backends/
[cache-from]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#cache-from
[cache-to]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#cache-to
[context]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#build-context
[file]: http://docs.iechor.com/reference/cli/iechor/image/build/#file
[go-cty]: https://github.com/zclconf/go-cty/tree/main/cty/function/stdlib
[hcl-funcs]: http://docs.iechor.com/build/bake/hcl-funcs/
[output]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#output
[platform]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#platform
[run_mount_secret]: http://docs.iechor.com/reference/iechorfile/#run---mounttypesecret
[secret]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#secret
[ssh]: http://docs.iechor.com/reference/cli/iechor/buildx/build/#ssh
[tag]: http://docs.iechor.com/reference/cli/iechor/image/build/#tag
[target]: http://docs.iechor.com/reference/cli/iechor/image/build/#target
[userfunc]: https://github.com/hashicorp/hcl/tree/main/ext/userfunc
