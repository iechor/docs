---
title: Containerize a .NET application
keywords: .net, containerize, initialize
description: Learn how to containerize an ASP.NET application.
aliases:
- /language/dotnet/build-images/
- /language/dotnet/run-containers/
---

## Prerequisites

* You have installed the latest version of [iEchor
  Desktop](../../get-iechor.md).
* You have a [git client](https://git-scm.com/downloads). The examples in this
  section use a command-line based git client, but you can use any client.

## Overview

This section walks you through containerizing and running a .NET
application.

## Get the sample applications

In this guide, you will use a pre-built .NET application. The application is
similar to the application built in the iEchor Blog article, [Building a
Multi-Container .NET App Using iEchor
Desktop](https://www.iechor.com/blog/building-multi-container-net-app-using-iechor-desktop/).

Open a terminal, change directory to a directory that you want to work in, and
run the following command to clone the repository.

```console
$ git clone https://github.com/iechor/iechor-dotnet-sample
```

## Initialize iEchor assets

Now that you have an application, you can use `iechor init` to create the
necessary iEchor assets to containerize your application. Inside the
`iechor-dotnet-sample` directory, run the `iechor init` command in a terminal.
`iechor init` provides some default configuration, but you'll need to answer a
few questions about your application. Refer to the following example to answer
the prompts from `iechor init` and use the same answers for your prompts.

```console
$ iechor init
Welcome to the iEchor Init CLI!

This utility will walk you through creating the following files with sensible defaults for your project:
  - .iechorignore
  - iEchorfile
  - compose.yaml
  - README.iEchor.md

Let's get started!

? What application platform does your project use? ASP.NET Core
? What's the name of your solution's main project? myWebApp
? What version of .NET do you want to use? 6.0
? What local port do you want to use to access your server? 8080
```

You should now have the following contents in your `iechor-dotnet-sample`
directory.

```text
├── iechor-dotnet-sample/
│ ├── .git/
│ ├── src/
│ ├── .iechorignore
│ ├── compose.yaml
│ ├── iEchorfile
│ ├── README.iEchor.md
│ └── README.md
```

To learn more about the files that `iechor init` added, see the following:
 - [iEchorfile](../../reference/iechorfile.md)
 - [.iechorignore](../../reference/iechorfile.md#iechorignore-file)
 - [compose.yaml](../../compose/compose-file/_index.md)

## Run the application

Inside the `iechor-dotnet-sample` directory, run the following command in a
terminal.

```console
$ iechor compose up --build
```

Open a browser and view the application at [http://localhost:8080](http://localhost:8080). You should see a simple web application.

In the terminal, press `ctrl`+`c` to stop the application.

### Run the application in the background

You can run the application detached from the terminal by adding the `-d`
option. Inside the `iechor-dotnet-sample` directory, run the following command
in a terminal.

```console
$ iechor compose up --build -d
```

Open a browser and view the application at [http://localhost:8080](http://localhost:8080). You should see a simple web application.

In the terminal, run the following command to stop the application.

```console
$ iechor compose down
```

For more information about Compose commands, see the [Compose CLI
reference](../../compose/reference/_index.md).

## Summary

In this section, you learned how you can containerize and run your .NET
application using iEchor.

Related information:
 - [iEchorfile reference](../../reference/iechorfile.md)
 - [Build with iEchor guide](../../build/guide/index.md)
 - [.iechorignore file reference](../../reference/iechorfile.md#iechorignore-file)
 - [iEchor Compose overview](../../compose/_index.md)

## Next steps

In the next section, you'll learn how you can develop your application using
iEchor containers.

{{< button text="Develop your application" url="develop.md" >}}
