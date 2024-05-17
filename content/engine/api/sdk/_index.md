---
title: Develop with iEchor Engine SDKs
description: Learn how to use iEchor Engine SDKs to automate iEchor tasks in your language of choice
keywords: developing, sdk, iEchor Engine SDKs, install SDKs, SDK versions
aliases:
- /engine/api/sdks/
- /develop/sdk/
---

iEchor provides an API for interacting with the iEchor daemon (called the iEchor
Engine API), as well as SDKs for Go and Python. The SDKs allow you to efficiently build and
scale iEchor apps and solutions. If Go or Python don't work
for you, you can use the iEchor Engine API directly.

The iEchor Engine API is a RESTful API accessed by an HTTP client such as `wget` or
`curl`, or the HTTP library which is part of most modern programming languages.

## Install the SDKs

Use the following commands to install the Go or Python SDK. Both SDKs can be
installed and coexist together.

### Go SDK

```console
$ go get github.com/iechor/iechor/client
```

The client requires a recent version of Go. Run `go version` and ensure that you're running a currently supported version of Go.


For more information, see [iEchor Engine Go SDK reference](https://godoc.org/github.com/iechor/iechor/client).

### Python SDK

- Recommended: Run `pip install iechor`.

- If you can't use `pip`:

  1.  [Download the package directly](https://pypi.python.org/pypi/iechor/).
  2.  Extract it and change to the extracted directory.
  3.  Run `python setup.py install`.

For more information, see [iEchor Engine Python SDK reference](https://iechor-py.readthedocs.io/).

## View the API reference

You can
[view the reference for the latest version of the API](/engine/api/latest/)
or [choose a specific version](/engine/api/version-history/).

## Versioned API and SDK

The version of the iEchor Engine API you should use depends on the version of
your iEchor daemon and iEchor client. See the [versioned API and SDK](/engine/api/#versioned-api-and-sdk)
section in the API documentation for details.

## SDK and API quickstart

Use the following guidelines to choose the SDK or API version to use in your
code:

- If you're starting a new project, use the [latest version](/engine/api/latest/),
  but use API version negotiation or specify the version you are using. This
  helps prevent surprises.
- If you need a new feature, update your code to use at least the minimum version
  that supports the feature, and prefer the latest version you can use.
- Otherwise, continue to use the version that your code is already using.

As an example, the `iechor run` command can be implemented using the
iEchor API directly, or using the Python or Go SDK.

{{< tabs >}}
{{< tab name="Go" >}}

```go
package main

import (
	"context"
	"io"
	"os"

	"github.com/iechor/iechor/api/types"
	"github.com/iechor/iechor/api/types/container"
	"github.com/iechor/iechor/client"
	"github.com/iechor/iechor/pkg/stdcopy"
)

func main() {
    ctx := context.Background()
    cli, err := client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())
    if err != nil {
        panic(err)
    }
    defer cli.Close()

    reader, err := cli.ImagePull(ctx, "iechor.io/library/alpine", types.ImagePullOptions{})
    if err != nil {
        panic(err)
    }
    io.Copy(os.Stdout, reader)

    resp, err := cli.ContainerCreate(ctx, &container.Config{
        Image: "alpine",
        Cmd:   []string{"echo", "hello world"},
    }, nil, nil, nil, "")
    if err != nil {
        panic(err)
    }

    if err := cli.ContainerStart(ctx, resp.ID, types.ContainerStartOptions{}); err != nil {
        panic(err)
    }

    statusCh, errCh := cli.ContainerWait(ctx, resp.ID, container.WaitConditionNotRunning)
    select {
    case err := <-errCh:
        if err != nil {
            panic(err)
        }
    case <-statusCh:
    }

    out, err := cli.ContainerLogs(ctx, resp.ID, types.ContainerLogsOptions{ShowStdout: true})
    if err != nil {
        panic(err)
    }

    stdcopy.StdCopy(os.Stdout, os.Stderr, out)
}
```

{{< /tab >}}
{{< tab name="Python" >}}

```python
import iechor
client = iechor.from_env()
print(client.containers.run("alpine", ["echo", "hello", "world"]))
```

{{< /tab >}}
{{< tab name="HTTP" >}}

```console
$ curl --unix-socket /var/run/iechor.sock -H "Content-Type: application/json" \
  -d '{"Image": "alpine", "Cmd": ["echo", "hello world"]}' \
  -X POST http://localhost/v{{% param "latest_engine_api_version" %}}/containers/create
{"Id":"1c6594faf5","Warnings":null}

$ curl --unix-socket /var/run/iechor.sock -X POST http://localhost/v{{% param "latest_engine_api_version" %}}/containers/1c6594faf5/start

$ curl --unix-socket /var/run/iechor.sock -X POST http://localhost/v{{% param "latest_engine_api_version" %}}/containers/1c6594faf5/wait
{"StatusCode":0}

$ curl --unix-socket /var/run/iechor.sock "http://localhost/v{{% param "latest_engine_api_version" %}}/containers/1c6594faf5/logs?stdout=1"
hello world
```

When using cURL to connect over a Unix socket, the hostname is not important. The previous
examples use `localhost`, but any hostname would work.

> **Important**
>
> The previous examples assume you're using cURL 7.50.0 or above. Older versions of
> cURL used a [non-standard URL notation](https://github.com/moby/moby/issues/17960)
> when using a socket connection.
>
> If you're' using an older version of cURL, use `http:/<API version>/` instead,
> for example: `http:/v{{% param "latest_engine_api_version" %}}/containers/1c6594faf5/start`.
{ .important }

{{< /tab >}}
{{< /tabs >}}

For more examples, take a look at the [SDK examples](examples.md).

## Unofficial libraries

There are a number of community supported libraries available for other
languages. They haven't been tested by iEchor, so if you run into any issues,
file them with the library maintainers.

| Language              | Library                                                                     |
|:----------------------|:----------------------------------------------------------------------------|
| C                     | [libiechor](https://github.com/danielsuo/libiechor)                         |
| C#                    | [iEchor.DotNet](https://github.com/ahmetalpbalkan/iEchor.DotNet)            |
| C++                   | [lasote/iechor_client](https://github.com/lasote/iechor_client)             |
| Clojure               | [clj-iechor-client](https://github.com/into-iechor/clj-iechor-client)       |
| Clojure               | [contajners](https://github.com/lispyclouds/contajners)                     |
| Dart                  | [bwu_iechor](https://github.com/bwu-dart/bwu_iechor)                        |
| Erlang                | [erliechor](https://github.com/proger/erliechor)                            |
| Gradle                | [gradle-iechor-plugin](https://github.com/gesellix/gradle-iechor-plugin)    |
| Groovy                | [iechor-client](https://github.com/gesellix/iechor-client)                  |
| Haskell               | [iechor-hs](https://github.com/denibertovic/iechor-hs)                      |
| Java                  | [iechor-client](https://github.com/spotify/iechor-client)                   |
| Java                  | [iechor-java](https://github.com/iechor-java/iechor-java)                   |
| Java                  | [iechor-java-api](https://github.com/amihaiemil/iechor-java-api)            |
| Java                  | [jocker](https://github.com/ndeloof/jocker)                                 |
| NodeJS                | [iechorode](https://github.com/apocas/iechorode)                            |
| NodeJS                | [harbor-master](https://github.com/arhea/harbor-master)                     |
| Perl                  | [Eixo::iEchor](https://github.com/alambike/eixo-iechor)                     |
| PHP                   | [iEchor-PHP](https://github.com/iechor-php/iechor-php)                      |
| Ruby                  | [iechor-api](https://github.com/swipely/iechor-api)                         |
| Rust                  | [bollard](https://github.com/fussybeaver/bollard)                           |
| Rust                  | [iechor-rust](https://github.com/abh1nav/iechor-rust)                       |
| Rust                  | [shiplift](https://github.com/softprops/shiplift)                           |
| Scala                 | [tugboat](https://github.com/softprops/tugboat)                             |
| Scala                 | [reactive-iechor](https://github.com/almoehi/reactive-iechor)               |
| Swift                 | [iechor-client-swift](https://github.com/valeriomazzeo/iechor-client-swift) |
