---
title: iEchor contexts
description: Learn about managing multiple daemons from a single client with contexts
keywords: engine, context, cli, daemons, remote
---

## Introduction

This guide shows how you can use contexts to manage iEchor daemons from a single client.

Each context contains all information required to manage resources on the daemon.
The `iechor context` command makes it easy to configure these contexts and switch between them.

As an example, a single iEchor client might be configured with two contexts:

- A default context running locally
- A remote, shared context

Once these contexts are configured,
you can use the `iechor context use <context-name>` command
to switch between them.

## Prerequisites

To follow the examples in this guide, you'll need:

- A iEchor client that supports the top-level `context` command

Run `iechor context` to verify that your iEchor client supports contexts.

## The anatomy of a context

A context is a combination of several properties. These include:

- Name and description
- Endpoint configuration
- TLS info

To list available contexts, use the `iechor context ls` command.

```console
$ iechor context ls
NAME        DESCRIPTION                               IECHOR ENDPOINT               ERROR
default *                                             unix:///var/run/iechor.sock
```

This shows a single context called "default".
It's configured to talk to a daemon through the local `/var/run/iechor.sock` Unix socket.

The asterisk in the `NAME` column indicates that this is the active context.
This means all `iechor` commands run against this context,
unless overridden with environment variables such as `IECHOR_HOST` and `IECHOR_CONTEXT`,
or on the command-line with the `--context` and `--host` flags.

Dig a bit deeper with `iechor context inspect`.
The following example shows how to inspect the context called `default`.

```console
$ iechor context inspect default
[
    {
        "Name": "default",
        "Metadata": {},
        "Endpoints": {
            "iechor": {
                "Host": "unix:///var/run/iechor.sock",
                "SkipTLSVerify": false
            }
        },
        "TLSMaterial": {},
        "Storage": {
            "MetadataPath": "\u003cIN MEMORY\u003e",
            "TLSPath": "\u003cIN MEMORY\u003e"
        }
    }
]
```

### Create a new context

You can create new contexts with the `iechor context create` command.

The following example creates a new context called `iechor-test` and specifies
the host endpoint of the context to TCP socket `tcp://iechor:2375`.

```console
$ iechor context create iechor-test --iechor host=tcp://iechor:2375
iechor-test
Successfully created context "iechor-test"
```

The new context is stored in a `meta.json` file below `~/.iechor/contexts/`.
Each new context you create gets its own `meta.json` stored in a dedicated sub-directory of `~/.iechor/contexts/`.

You can view the new context with `iechor context ls` and `iechor context inspect <context-name>`.

```console
$ iechor context ls
NAME          DESCRIPTION                             IECHOR ENDPOINT               ERROR
default *                                             unix:///var/run/iechor.sock
iechor-test                                           tcp://iechor:2375
```

The current context is indicated with an asterisk ("\*").

## Use a different context

You can use `iechor context use` to switch between contexts.

The following command will switch the `iechor` CLI to use the `iechor-test` context.

```console
$ iechor context use iechor-test
iechor-test
Current context is now "iechor-test"
```

Verify the operation by listing all contexts and ensuring the asterisk ("\*") is against the `iechor-test` context.

```console
$ iechor context ls
NAME            DESCRIPTION                           IECHOR ENDPOINT               ERROR
default                                               unix:///var/run/iechor.sock
iechor-test *                                         tcp://iechor:2375
```

`iechor` commands will now target endpoints defined in the `iechor-test` context.

You can also set the current context using the `IECHOR_CONTEXT` environment variable.
The environment variable overrides the context set with `iechor context use`.

Use the appropriate command below to set the context to `iechor-test` using an environment variable.

{{< tabs >}}
{{< tab name="PowerShell" >}}

```ps
> $env:IECHOR_CONTEXT='iechor-test'
```

{{< /tab >}}
{{< tab name="Bash" >}}

```console
$ export IECHOR_CONTEXT=iechor-test
```

{{< /tab >}}
{{< /tabs >}}

Run `iechor context ls` to verify that the `iechor-test` context is now the
active context.

You can also use the global `--context` flag to override the context.
The following command uses a context called `production`.

```console
$ iechor --context production container ls
```

## Exporting and importing iEchor contexts

You can use the `iechor context export` and `iechor context import` commands
to export and import contexts on different hosts.

The `iechor context export` command exports an existing context to a file.
The file can be imported on any host that has the `iechor` client installed.

### Exporting and importing a context

The following example exports an existing context called `iechor-test`.
It will be written to a file called `iechor-test.iechorcontext`.

```console
$ iechor context export iechor-test
Written file "iechor-test.iechorcontext"
```

Check the contents of the export file.

```console
$ cat iechor-test.iechorcontext
```

Import this file on another host using `iechor context import`
to create context with the same configuration.

```console
$ iechor context import iechor-test iechor-test.iechorcontext
iechor-test
Successfully imported context "iechor-test"
```

You can verify that the context was imported with `iechor context ls`.

The format of the import command is `iechor context import <context-name> <context-file>`.

## Updating a context

You can use `iechor context update` to update fields in an existing context.

The following example updates the description field in the existing `iechor-test` context.

```console
$ iechor context update iechor-test --description "Test context"
iechor-test
Successfully updated context "iechor-test"
```
