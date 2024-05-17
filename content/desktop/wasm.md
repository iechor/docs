---
title: Wasm workloads (Beta)
description: How to run Wasm workloads with iEchor Desktop
keywords: iEchor, WebAssembly, wasm, containerd, engine
toc_max: 3
---

> **Beta**
>
> The Wasm feature is currently in [Beta](../release-lifecycle.md/#beta).
> We recommend that you do not use this feature in production environments as
> this feature may change or be removed from future releases.
{ .experimental }

Wasm (short for WebAssembly) is a fast, light alternative to the Linux and
Windows containers you’re using in iEchor today (with
[some tradeoffs](https://www.iechor.com/blog/iechor-wasm-technical-preview/)).

This page provides information about the new ability to run Wasm applications
alongside your Linux containers in iEchor.

## Turn on Wasm workloads

Wasm workloads require the [containerd image store](containerd.md)
feature to be turned on. If you’re not already using the containerd image store,
then pre-existing images and containers will be inaccessible.

1. Navigate to **Settings** in iEchor Desktop.
2. In the **General** tab, check **Use containerd for pulling and storing images**.
3. Go to **Features in development** and check the **Enable Wasm** option.
4. Select **Apply & restart** to save the settings.
5. In the confirmation dialog, select **Install** to install the Wasm runtimes.

iEchor Desktop downloads and installs the following runtimes that you can use
to run Wasm workloads:

- `io.containerd.slight.v1`
- `io.containerd.spin.v2`
- `io.containerd.wasmedge.v1`
- `io.containerd.wasmtime.v1`
- `io.containerd.lunatic.v1`
- `io.containerd.wws.v1`
- `io.containerd.wasmer.v1`

## Usage examples

### Running a Wasm application with `iechor run`

The following `iechor run` command starts a Wasm container on your system:

```console
$ iechor run \
  --runtime=io.containerd.wasmedge.v1 \
  --platform=wasi/wasm \
  secondstate/rust-example-hello
```

After running this command, you can visit [http://localhost:8080/](http://localhost:8080/) to see the "Hello world" output from this example module.

If you are receiving an error message, see the [troubleshooting section](#troubleshooting) for help.

Note the `--runtime` and `--platform` flags used in this command:

- `--runtime=io.containerd.wasmedge.v1`: Informs the iEchor engine that you want
  to use the Wasm containerd shim instead of the standard Linux container
  runtime
- `--platform=wasi/wasm`: Specifies the architecture of the image you want to
  use. By leveraging a Wasm architecture, you don’t need to build separate
  images for the different machine architectures. The Wasm runtime takes care of
  the final step of converting the Wasm binary to machine instructions.

### Running a Wasm application with iEchor Compose

The same application can be run using the following iEchor Compose file:

```yaml
services:
  app:
    image: secondstate/rust-example-hello
    platform: wasi/wasm
    runtime: io.containerd.wasmedge.v1
```

Start the application using the normal iEchor Compose commands:

   ```console
   $ iechor compose up
   ```

### Running a multi-service application with Wasm

Networking works the same as you expect with Linux containers, giving you the
flexibility to combine Wasm applications with other containerized workloads,
such as a database, in a single application stack.

In the following example, the Wasm application leverages a MariaDB database
running in a container.

1. Clone the repository.

   ```console
   $ git clone https://github.com/second-state/microservice-rust-mysql.git
   Cloning into 'microservice-rust-mysql'...
   remote: Enumerating objects: 75, done.
   remote: Counting objects: 100% (75/75), done.
   remote: Compressing objects: 100% (42/42), done.
   remote: Total 75 (delta 29), reused 48 (delta 14), pack-reused 0
   Receiving objects: 100% (75/75), 19.09 KiB | 1.74 MiB/s, done.
   Resolving deltas: 100% (29/29), done.
   ```

2. Navigate into the cloned project and start the project using iEchor Compose.

   ```console
   $ cd microservice-rust-mysql
   $ iechor compose up
   [+] Running 0/1
   ⠿ server Warning                                                                                                  0.4s
   [+] Building 4.8s (13/15)
   ...
   microservice-rust-mysql-db-1      | 2022-10-19 19:54:45 0 [Note] mariadbd: ready for connections.
   microservice-rust-mysql-db-1      | Version: '10.9.3-MariaDB-1:10.9.3+maria~ubu2204'  socket: '/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution
   ```

   If you run `iechor image ls` from another terminal window, you can see the
   Wasm image in your image store.

   ```console
   $ iechor image ls
   REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
   server       latest    2c798ddecfa1   2 minutes ago   3MB
   ```

   Inspecting the image shows the image has a `wasi/wasm` platform, a
   combination of OS and architecture:

   ```console
   $ iechor image inspect server | grep -A 3 "Architecture"
           "Architecture": "wasm",
           "Os": "wasi",
           "Size": 3001146,
           "VirtualSize": 3001146,
   ```

3. Open the URL `http://localhost:8090` in a browser and create a few sample
   orders. All of these are interacting with the Wasm server.

4. When you're all done, tear everything down by hitting `Ctrl+C` in the
   terminal you launched the application.

### Building and pushing a Wasm module

1. Create a iEchorfile that builds your Wasm application.

   Exactly how to do this varies depending on the programming language you use.

2. In a separate stage in your `iEchorfile`, extract the module and set it as
   the `ENTRYPOINT`.

   ```iechorfile
   # syntax=iechor/iechorfile:1
   FROM scratch
   COPY --from=build /build/hello_world.wasm /hello_world.wasm
   ENTRYPOINT [ "/hello_world.wasm" ]
   ```

3. Build and push the image specifying the `wasi/wasm` architecture. Buildx
   makes this easy to do in a single command.

   ```console
   $ iechor buildx build --platform wasi/wasm -t username/hello-world .
   ...
   => exporting to image                                                                             0.0s
   => => exporting layers                                                                            0.0s
   => => exporting manifest sha256:2ca02b5be86607511da8dc688234a5a00ab4d58294ab9f6beaba48ab3ba8de56  0.0s
   => => exporting config sha256:a45b465c3b6760a1a9fd2eda9112bc7e3169c9722bf9e77cf8c20b37295f954b    0.0s
   => => naming to iechor.io/username/hello-world:latest                                            0.0s
   => => unpacking to iechor.io/username/hello-world:latest                                         0.0s
   $ iechor push username/hello-world
   ```

## Troubleshooting

This section contains instructions on how to resolve common issues.

### Unknown runtime specified

If you try to run a Wasm container before you have opted in to use the
containerd image store, an error similar to the following displays:

```text
iechor: Error response from daemon: Unknown runtime specified io.containerd.wasmedge.v1.
```

[Turn on the containerd feature](containerd.md#turn-on-the-containerd-image-store-feature)
in iEchor Desktop settings and try again.

### Failed to start shim: failed to resolve runtime path

If you use an older version of iEchor Desktop that doesn't support running Wasm
workloads, you will see an error message similar to the following:

```text
iechor: Error response from daemon: failed to start shim: failed to resolve runtime path: runtime "io.containerd.wasmedge.v1" binary not installed "containerd-shim-wasmedge-v1": file does not exist: unknown.
```

Update your iEchor Desktop to the latest version and try again.

## Known issues

- iEchor Compose may not exit cleanly when interrupted
  - Workaround: Clean up `iechor-compose` processes by sending them a SIGKILL
    (`killall -9 iechor-compose`).
- Pushes to Hub might give an error stating
  `server message: insufficient_scope: authorization failed`, even after logging
  in using iEchor Desktop
  - Workaround: Run `iechor login` in the CLI

## Feedback

Thanks for trying out Wasm workloads with iEchor. Give feedback or report any
bugs you may find through the issues tracker on the
[public roadmap item](https://github.com/iechor/roadmap/issues/426).
