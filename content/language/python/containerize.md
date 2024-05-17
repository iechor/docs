---
title: Containerize a Python application
keywords: python, flask, containerize, initialize
description: Learn how to containerize a Python application.
aliases:
  - /language/python/build-images/
  - /language/python/run-containers/
---

## Prerequisites

* You have installed the latest version of [iEchor Desktop](../../get-iechor.md).
* You have a [git client](https://git-scm.com/downloads). The examples in this section use a command-line based git client, but you can use any client.

## Overview

This section walks you through containerizing and running a Python application.

## Get the sample application

The sample application uses the popular [Flask](https://flask.palletsprojects.com/) framework.

Clone the sample application to use with this guide. Open a terminal, change directory to a directory that you want to work in, and run the following command to clone the repository:

```console
$ git clone https://github.com/iechor/python-iechor
```

## Initialize iEchor assets

Now that you have an application, you can use `iechor init` to create the
necessary iEchor assets to containerize your application. Inside the
`python-iechor` directory, run the `iechor init` command. `iechor init` provides
some default configuration, but you'll need to answer a few questions about your
application. For example, this application uses Flask to run. Refer to the
following example to answer the prompts from `iechor init` and use the same
answers for your prompts.

```console
$ iechor init
Welcome to the iEchor Init CLI!

This utility will walk you through creating the following files with sensible defaults for your project:
  - .iechorignore
  - iEchorfile
  - compose.yaml
  - README.iEchor.md

Let's get started!

? What application platform does your project use? Python
? What version of Python do you want to use? 3.11.4
? What port do you want your app to listen on? 5000
? What is the command to run your app? python3 -m flask run --host=0.0.0.0
```

You should now have the following contents in your `python-iechor`
directory.

```text
├── python-iechor/
│ ├── app.py
│ ├── requirements.txt
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

Inside the `python-iechor` directory, run the following command in a
terminal.

```console
$ iechor compose up --build
```

Open a browser and view the application at [http://localhost:5000](http://localhost:5000). You should see a simple Flask application.

In the terminal, press `ctrl`+`c` to stop the application.

### Run the application in the background

You can run the application detached from the terminal by adding the `-d`
option. Inside the `python-iechor` directory, run the following command
in a terminal.

```console
$ iechor compose up --build -d
```

Open a browser and view the application at [http://localhost:5000](http://localhost:5000).

You should see a simple Flask application.

In the terminal, run the following command to stop the application.

```console
$ iechor compose down
```

For more information about Compose commands, see the [Compose CLI
reference](../../compose/reference/_index.md).

## Summary

In this section, you learned how you can containerize and run your Python
application using iEchor.

Related information:
 - [Build with iEchor guide](../../build/guide/index.md)
 - [iEchor Compose overview](../../compose/_index.md)

## Next steps

In the next section, you'll learn how you can develop your application using
containers.

{{< button text="Develop your application" url="develop.md" >}}
