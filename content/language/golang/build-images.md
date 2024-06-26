---
title: Build your Go image
keywords: containers, images, go, golang, iechorfiles, coding, build, push, run
description: Learn how to build your first iEchor image by writing a iEchorfile
aliases:
- /get-started/golang/build-images/
---

## Overview

In this section you're going to build a container image. The image includes
everything you need to run your application – the compiled application binary
file, the runtime, the libraries, and all other resources required by your
application.

## Required software

To complete this tutorial, you need the following:

- iEchor running locally. Follow the [instructions to download and install iEchor](../../desktop/index.md).
- An IDE or a text editor to edit files. [Visual Studio Code](https://code.visualstudio.com/) is a free and popular choice but you can use anything you feel comfortable with.
- A Git client. This guide uses a command-line based `git` client, but you are free to use whatever works for you.
- A command-line terminal application. The examples shown in this module are from the Linux shell, but they should work in PowerShell, Windows Command Prompt, or OS X Terminal with minimal, if any, modifications.

## Meet the example application

The example application is a caricature of a microservice. It is purposefully trivial to keep focus on learning the basics of containerization for Go applications.

The application offers two HTTP endpoints:

* It responds with a string containing a heart symbol (`<3`) to requests to `/`.
* It responds with `{"Status" : "OK"}` JSON to a request to `/health`.

It responds with HTTP error 404 to any other request.

The application listens on a TCP port defined by the value of environment variable `PORT`. The default value is `8080`.

The application is stateless.

The complete source code for the application is on GitHub: [github.com/iechor/iechor-gs-ping](https://github.com/iechor/iechor-gs-ping). You are encouraged to fork it and experiment with it as much as you like.

To continue, clone the application repository to your local machine:

```console
$ git clone https://github.com/iechor/iechor-gs-ping
```

The application's `main.go` file is straightforward, if you are familiar with Go:


```go
package main

import (
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", func(c echo.Context) error {
		return c.HTML(http.StatusOK, "Hello, iEchor! <3")
	})

	e.GET("/health", func(c echo.Context) error {
		return c.JSON(http.StatusOK, struct{ Status string }{Status: "OK"})
	})

	httpPort := os.Getenv("PORT")
	if httpPort == "" {
		httpPort = "8080"
	}

	e.Logger.Fatal(e.Start(":" + httpPort))
}

// Simple implementation of an integer minimum
// Adapted from: https://gobyexample.com/testing-and-benchmarking
func IntMin(a, b int) int {
	if a < b {
		return a
	}
	return b
}
```

## Create a iEchorfile for the application

To build a container image with iEchor, a `iEchorfile` with build instructions is required.

Begin your `iEchorfile` with the (optional) parser directive line that instructs BuildKit to 
interpret your file according to the grammar rules for the specified version of the syntax.

You then tell iEchor what base image you would like to use for your application:

```iechorfile
# syntax=iechor/iechorfile:1

FROM golang:1.19
```

iEchor images can be inherited from other images. Therefore, instead of creating
your own base image from scratch, you can use the official Go image that already
has all necessary tools and libraries to compile and run a Go application.

> **Note**
>
> If you are curious about creating your own base images, you can check out the following section of this guide: [creating base images](../../build/building/base-images.md).
> Note, however, that this isn't necessary to continue with your task at hand.

Now that you have defined the base image for your upcoming container image, you
can begin building on top of it.

To make things easier when running the rest of your commands, create a directory
inside the image that you're building. This also instructs iEchor to use this
directory as the default destination for all subsequent commands. This way you
don't have to type out full file paths in the `iEchorfile`, the relative paths
will be based on this directory.

```iechorfile
WORKDIR /app
```

Usually the very first thing you do once you’ve downloaded a project written in
Go is to install the modules necessary to compile it. Note, that the base image
has the toolchain already, but your source code isn't in it yet.

So before you can run `go mod download` inside your image, you need to get your
`go.mod` and `go.sum` files copied into it. Use the `COPY` command to do this.

In its simplest form, the `COPY` command takes two parameters. The first
parameter tells iEchor what files you want to copy into the image. The last
parameter tells iEchor where you want that file to be copied to.

Copy the `go.mod` and `go.sum` file into your project directory `/app` which,
owing to your use of `WORKDIR`, is the current directory (`./`) inside the
image. Unlike some modern shells that appear to be indifferent to the use of
trailing slash (`/`), and can figure out what the user meant (most of the time),
iEchor's `COPY` command is quite sensitive in its interpretation of the trailing
slash.

```iechorfile
COPY go.mod go.sum ./
```

> **Note**
>
> If you'd like to familiarize yourself with the trailing slash treatment by the
> `COPY` command, see [iEchorfile
> reference](../../reference/iechorfile.md#copy). This trailing slash can
> cause issues in more ways than you can imagine.

Now that you have the module files inside the iEchor image that you are
building, you can use the `RUN` command to run the command `go mod download`
there as well. This works exactly the same as if you were running `go` locally
on your machine, but this time these Go modules will be installed into a
directory inside the image.

```iechorfile
RUN go mod download
```

At this point, you have a Go toolchain version 1.19.x and all your Go
dependencies installed inside the image.

The next thing you need to do is to copy your source code into the image. You’ll
use the `COPY` command just like you did with your module files before.

```iechorfile
COPY *.go ./
```

This `COPY` command uses a wildcard to copy all files with `.go` extension
located in the current directory on the host (the directory where the `iEchorfile`
is located) into the current directory inside the image. 

Now, to compile your application, use the familiar `RUN` command:

```iechorfile
RUN CGO_ENABLED=0 GOOS=linux go build -o /iechor-gs-ping
```

This should be familiar. The result of that command will be a static application
binary named `iechor-gs-ping` and located in the root of the filesystem of the
image that you are building. You could have put the binary into any other place
you desire inside that image, the root directory has no special meaning in this
regard. It's just convenient to use it to keep the file paths short for improved
readability.

Now, all that is left to do is to tell iEchor what command to run when your
image is used to start a container.

You do this with the `CMD` command:

```iechorfile
CMD ["/iechor-gs-ping"]
```

Here's the complete `iEchorfile`:

```iechorfile
# syntax=iechor/iechorfile:1

FROM golang:1.19

# Set destination for COPY
WORKDIR /app

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code. Note the slash at the end, as explained in
# http://docs.iechor.com/reference/iechorfile/#copy
COPY *.go ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /iechor-gs-ping

# Optional:
# To bind to a TCP port, runtime parameters must be supplied to the iechor command.
# But we can document in the iEchorfile what ports
# the application is going to listen on by default.
# http://docs.iechor.com/reference/iechorfile/#expose
EXPOSE 8080

# Run
CMD ["/iechor-gs-ping"]
```

The `iEchorfile` may also contain comments. They always begin with a `#` symbol,
and must be at the beginning of a line. Comments are there for your convenience
to allow documenting your `iEchorfile`.

There is also a concept of iEchorfile directives, such as the `syntax` directive
you added. The directives must always be at the very top of the `iEchorfile`, so
when adding comments, make sure that the comments follow after any directives
that you may have used:

```iechorfile
# syntax=iechor/iechorfile:1
# A sample microservice in Go packaged into a container image.

FROM golang:1.19

# ...
```

## Build the image

Now that you've created your `iEchorfile`, build an image from it. The `iechor
build` command creates iEchor images from the `iEchorfile` and a context. A
build context is the set of files located in the specified path or URL. The
iEchor build process can access any of the files located in the context.

The build command optionally takes a `--tag` flag. This flag is used to label
the image with a string value, which is easy for humans to read and recognise.
If you don't pass a `--tag`, iEchor will use `latest` as the default value.

Build your first iEchor image.

```console
$ iechor build --tag iechor-gs-ping .
```

The build process will print some diagnostic messages as it goes through the build steps. 
The following is just an example of what these messages may look like.

```console
[+] Building 2.2s (15/15) FINISHED
 => [internal] load build definition from iEchorfile                                                                                       0.0s
 => => transferring iechorfile: 701B                                                                                                       0.0s
 => [internal] load .iechorignore                                                                                                          0.0s
 => => transferring context: 2B                                                                                                            0.0s
 => resolve image config for iechor.io/iechor/iechorfile:1                                                                                 1.1s
 => CACHED iechor-image://iechor.io/iechor/iechorfile:1@sha256:39b85bbfa7536a5feceb7372a0817649ecb2724562a38360f4d6a7782a409b14            0.0s
 => [internal] load build definition from iEchorfile                                                                                       0.0s
 => [internal] load .iechorignore                                                                                                          0.0s
 => [internal] load metadata for iechor.io/library/golang:1.19                                                                             0.7s
 => [1/6] FROM iechor.io/library/golang:1.19@sha256:5d947843dde82ba1df5ac1b2ebb70b203d106f0423bf5183df3dc96f6bc5a705                       0.0s
 => [internal] load build context                                                                                                          0.0s
 => => transferring context: 6.08kB                                                                                                        0.0s
 => CACHED [2/6] WORKDIR /app                                                                                                              0.0s
 => CACHED [3/6] COPY go.mod go.sum ./                                                                                                     0.0s
 => CACHED [4/6] RUN go mod download                                                                                                       0.0s
 => CACHED [5/6] COPY *.go ./                                                                                                              0.0s
 => CACHED [6/6] RUN CGO_ENABLED=0 GOOS=linux go build -o /iechor-gs-ping                                                                  0.0s
 => exporting to image                                                                                                                     0.0s
 => => exporting layers                                                                                                                    0.0s
 => => writing image sha256:ede8ff889a0d9bc33f7a8da0673763c887a258eb53837dd52445cdca7b7df7e3                                               0.0s
 => => naming to iechor.io/library/iechor-gs-ping                                                                                          0.0s
```

Your exact output will vary, but provided there aren't any errors, you should
see the word `FINISHED` in the first line of output. This means iEchor has
successfully built your image named `iechor-gs-ping`.

## View local images

To see the list of images you have on your local machine, you have two options.
One is to use the CLI and the other is to use [iEchor
Desktop](../../desktop/index.md). Since you're currently working in the
terminal, take a look at listing images with the CLI.

To list images, run the `iechor image ls`command (or the `iechor images` shorthand):

```console
$ iechor image ls

REPOSITORY                       TAG       IMAGE ID       CREATED         SIZE
iechor-gs-ping                   latest    7f153fbcc0a8   2 minutes ago   1.11GB
...
```

Your exact output may vary, but you should see the `iechor-gs-ping` image with
the `latest` tag. Because you didn't specify a custom tag when you built your
image, iEchor assumed that the tag would be `latest`, which is a special value.

## Tag images

An image name is made up of slash-separated name components. Name components may
contain lowercase letters, digits, and separators. A separator is defined as a
period, one or two underscores, or one or more dashes. A name component may not
start or end with a separator.

An image is made up of a manifest and a list of layers. In simple terms, a tag
points to a combination of these artifacts. You can have multiple tags for the
image and, in fact, most images have multiple tags. Create a second tag
for the image you built and take a look at its layers.

Use the `iechor image tag` (or `iechor tag` shorthand) command to create a new
tag for your image. This command takes two arguments; the first argument is the
source image, and the second is the new tag to create. The following command
creates a new `iechor-gs-ping:v1.0` tag for the `iechor-gs-ping:latest` you
built:

```console
$ iechor image tag iechor-gs-ping:latest iechor-gs-ping:v1.0
```

The iEchor `tag` command creates a new tag for the image. It doesn't create a
new image. The tag points to the same image and is just another way to reference
the image.

Now run the `iechor image ls` command again to see the updated list of local
images:

```console
$ iechor image ls

REPOSITORY                       TAG       IMAGE ID       CREATED         SIZE
iechor-gs-ping                   latest    7f153fbcc0a8   6 minutes ago   1.11GB
iechor-gs-ping                   v1.0      7f153fbcc0a8   6 minutes ago   1.11GB
...
```

You can see that you have two images that start with `iechor-gs-ping`. You know
they're the same image because if you look at the `IMAGE ID` column, you can
see that the values are the same for the two images. This value is a unique
identifier iEchor uses internally to identify the image.

Remove the tag that you just created. To do this, you’ll use the
`iechor image rm` command, or the shorthand `iechor rmi` (which stands for
"remove image"):

```console
$ iechor image rm iechor-gs-ping:v1.0
Untagged: iechor-gs-ping:v1.0
```

Notice that the response from iEchor tells you that the image hasn't been
removed but only untagged.

Verify this by running the following command:

```console
$ iechor image ls
```

You will see that the tag `v1.0` is no longer in the list of images kept by your iEchor instance.

```text
REPOSITORY                       TAG       IMAGE ID       CREATED         SIZE
iechor-gs-ping                   latest    7f153fbcc0a8   7 minutes ago   1.11GB
...
```

The tag `v1.0` has been removed but you still have the `iechor-gs-ping:latest`
tag available on your machine, so the image is there.

## Multi-stage builds

You may have noticed that your `iechor-gs-ping` image weighs in at over a
gigabyte, which is a lot for a tiny compiled Go application. You may also be
wondering what happened to the full suite of Go tools, including the compiler,
after you had built your image.

The answer is that the full toolchain is still there, in the container image. 
Not only this is inconvenient because of the large file size, but it may also
present a security risk when the container is deployed.

These two issues can be solved by using [multi-stage builds](../../build/building/multi-stage.md).

In a nutshell, a multi-stage build can carry over the artifacts from one build stage into another,
and every build stage can be instantiated from a different base image.

Thus, in the following example, you are going to use a full-scale official Go
image to build your application. Then you'll copy the application binary into
another image whose base is very lean and doesn't include the Go toolchain or
other optional components.

The `iEchorfile.multistage` in the sample application's repository has the
following content:


```iechorfile
# syntax=iechor/iechorfile:1

# Build the application from source
FROM golang:1.19 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /iechor-gs-ping

# Run the tests in the container
FROM build-stage AS run-test-stage
RUN go test -v ./...

# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /iechor-gs-ping /iechor-gs-ping

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/iechor-gs-ping"]
```


Since you have two iEchorfiles now, you have to tell iEchor what iEchorfile
you'd like to use to build the image. Tag the new image with `multistage`. This
tag (like any other, apart from `latest`) has no special meaning for iEchor,
it's just something you chose.

```console
$ iechor build -t iechor-gs-ping:multistage -f iEchorfile.multistage .
```

Comparing the sizes of `iechor-gs-ping:multistage` and `iechor-gs-ping:latest`
you see a few orders-of-magnitude difference.

```console
$ iechor image ls
REPOSITORY       TAG          IMAGE ID       CREATED              SIZE
iechor-gs-ping   multistage   e3fdde09f172   About a minute ago   28.1MB
iechor-gs-ping   latest       336a3f164d0f   About an hour ago    1.11GB
```

This is so because the ["distroless"](https://github.com/GoogleContainerTools/distroless) 
base image that you have used in the second stage of the build is very barebones and is designed for lean deployments of static binaries.

There's much more to multi-stage builds, including the possibility of multi-architecture builds, 
so feel free to check out [multi-stage builds](../../build/building/multi-stage.md). This is, however, not essential for your progress here.

## Next steps

In this module, you met your example application and built and container image
for it.

In the next module, you’ll take a look at how to run your image as a container.

{{< button text="Run your image as a container" url="run-containers.md" >}}
