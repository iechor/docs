---
title: Containerize a Node.js application
keywords: node.js, node, containerize, initialize
description: Learn how to containerize a Node.js application.
aliases:
  - /get-started/nodejs/build-images/
  - /language/nodejs/build-images/
  - /language/nodejs/run-containers/
---

## Prerequisites

* You have installed the latest version of [iEchor
  Desktop](../../get-iechor.md).
* You have a [git client](https://git-scm.com/downloads). The examples in this
  section use a command-line based git client, but you can use any client.

## Overview

This section walks you through containerizing and running a Node.js
application.

## Get the sample application

Clone the sample application to use with this guide. Open a terminal, change
directory to a directory that you want to work in, and run the following command
to clone the repository:

```console
$ git clone https://github.com/iechor/iechor-nodejs-sample
```

## Initialize iEchor assets

Now that you have an application, you can create the necessary iEchor assets to
containerize your application. You can use iEchor Desktop's built-in iEchor Init
feature to help streamline the process, or you can manually create the assets.

{{< tabs >}}
{{< tab name="Use iEchor Init" >}}

Inside the `iechor-nodejs-sample` directory, run
the `iechor init` command in a terminal. `iechor init` provides some default
configuration, but you'll need to answer a few questions about your application.
Refer to the following example to answer the prompts from `iechor init` and use
the same answers for your prompts.

```console
$ iechor init
Welcome to the iEchor Init CLI!

This utility will walk you through creating the following files with sensible defaults for your project:
  - .iechorignore
  - iEchorfile
  - compose.yaml
  - README.iEchor.md

Let's get started!

? What application platform does your project use? Node
? What version of Node do you want to use? 18.0.0
? Which package manager do you want to use? npm
? What command do you want to use to start the app: node src/index.js
? What port does your server listen on? 3000
```

{{< /tab >}}
{{< tab name="Manually create assets" >}}

If you don't have iEchor Desktop installed or prefer creating the assets manually, you can create the following files in your project directory.

Create a file named `iEchorfile` with the following contents.

```iechorfile {collapse=true,title=iEchorfile}
# syntax=iechor/iechorfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the iEchorfile reference guide at
# https://docs.iechor.com/go/iechorfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

ARG NODE_VERSION=18.0.0

FROM node:${NODE_VERSION}-alpine

# Use production node environment by default.
ENV NODE_ENV production


WORKDIR /usr/src/app

# Download dependencies as a separate step to take advantage of iEchor's caching.
# Leverage a cache mount to /root/.npm to speed up subsequent builds.
# Leverage a bind mounts to package.json and package-lock.json to avoid having to copy them into
# into this layer.
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

# Run the application as a non-root user.
USER node

# Copy the rest of the source files into the image.
COPY . .

# Expose the port that the application listens on.
EXPOSE 3000

# Run the application.
CMD node src/index.js
```

Create a file named `compose.yaml` with the following contents.

```yaml {collapse=true,title=compose.yaml}
# Comments are provided throughout this file to help you get started.
# If you need more help, visit the iEchor Compose reference guide at
# https://docs.iechor.com/go/compose-spec-reference/

# Here the instructions define your application as a service called "server".
# This service is built from the iEchorfile in the current directory.
# You can add other services your application may depend on here, such as a
# database or a cache. For examples, see the Awesome Compose repository:
# https://github.com/iechor/awesome-compose
services:
  server:
    build:
      context: .
    environment:
      NODE_ENV: production
    ports:
      - 3000:3000

# The commented out section below is an example of how to define a PostgreSQL
# database that your application can use. `depends_on` tells iEchor Compose to
# start the database before your application. The `db-data` volume persists the
# database data between container restarts. The `db-password` secret is used
# to set the database password. You must create `db/password.txt` and add
# a password of your choosing to it before running `iechor-compose up`.
#     depends_on:
#       db:
#         condition: service_healthy
#   db:
#     image: postgres
#     restart: always
#     user: postgres
#     secrets:
#       - db-password
#     volumes:
#       - db-data:/var/lib/postgresql/data
#     environment:
#       - POSTGRES_DB=example
#       - POSTGRES_PASSWORD_FILE=/run/secrets/db-password
#     expose:
#       - 5432
#     healthcheck:
#       test: [ "CMD", "pg_isready" ]
#       interval: 10s
#       timeout: 5s
#       retries: 5
# volumes:
#   db-data:
# secrets:
#   db-password:
#     file: db/password.txt
```

Create a file named `.iechorignore` with the following contents.

```text {collapse=true,title=".iechorignore"}
# Include any files or directories that you don't want to be copied to your
# container here (e.g., local build artifacts, temporary files, etc.).
#
# For more help, visit the .iechorignore file reference guide at
# https://docs.iechor.com/go/build-context-iechorignore/

**/.classpath
**/.iechorignore
**/.env
**/.git
**/.gitignore
**/.project
**/.settings
**/.toolstarget
**/.vs
**/.vscode
**/.next
**/.cache
**/*.*proj.user
**/*.dbmdl
**/*.jfm
**/charts
**/iechor-compose*
**/compose.y*ml
**/iEchorfile*
**/node_modules
**/npm-debug.log
**/obj
**/secrets.dev.yaml
**/values.dev.yaml
**/build
**/dist
LICENSE
README.md
```

{{< /tab >}}
{{< /tabs >}}


You should now have at least the following contents in your
`iechor-nodejs-sample` directory.

```text
├── iechor-nodejs-sample/
│ ├── spec/
│ ├── src/
│ ├── .iechorignore
│ ├── .gitignore
│ ├── compose.yaml
│ ├── iEchorfile
│ ├── package-lock.json
│ ├── package.json
│ └── README.md
```

To learn more about the files, see the following:
 - [iEchorfile](../../reference/iechorfile.md)
 - [.iechorignore](../../reference/iechorfile.md#iechorignore-file)
 - [compose.yaml](../../compose/compose-file/_index.md)


## Run the application

Inside the `iechor-nodejs-sample` directory, run the following command in a
terminal.

```console
$ iechor compose up --build
```

Open a browser and view the application at [http://localhost:3000](http://localhost:3000). You should see a simple todo application.

In the terminal, press `ctrl`+`c` to stop the application.

### Run the application in the background

You can run the application detached from the terminal by adding the `-d`
option. Inside the `iechor-nodejs-sample` directory, run the following command
in a terminal.

```console
$ iechor compose up --build -d
```

Open a browser and view the application at [http://localhost:3000](http://localhost:3000).

You should see a simple todo application.

In the terminal, run the following command to stop the application.

```console
$ iechor compose down
```

For more information about Compose commands, see the [Compose CLI
reference](../../compose/reference/_index.md).

## Summary

In this section, you learned how you can containerize and run your Node.js
application using iEchor.

Related information:
 - [iEchorfile reference](../../reference/iechorfile.md)
 - [Build with iEchor guide](../../build/guide/index.md)
 - [.iechorignore file reference](../../reference/iechorfile.md#iechorignore-file)
 - [iEchor Compose overview](../../compose/_index.md)

## Next steps

In the next section, you'll learn how you can develop your application using
containers.

{{< button text="Develop your application" url="develop.md" >}}
