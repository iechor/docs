---
title: Develop with iEchor
description: Overview of developer resources
keywords: developer, developing, apps, api, sdk
---

This page contains a list of resources for application developers who would like to build new applications using iEchor.

## Prerequisites

Work through the learning modules in [Get started](../get-started/index.md) to understand how to build an image and run it as a containerized application.

## Develop new apps on iEchor

If you're just getting started developing a brand new app on iEchor, check out
these resources to understand some of the most common patterns for getting the
most benefits from iEchor.

- Learn how to [build an image](../reference/iechorfile.md) using a iEchorfile
- Use [multi-stage builds](../build/building/multi-stage.md) to keep your images lean
- Manage application data using [volumes](../storage/volumes.md) and [bind mounts](../storage/bind-mounts.md)
- [Scale your app with Kubernetes](../get-started/kube-deploy.md) 
- [Scale your app as a Swarm service](../get-started/swarm-deploy.md) 
- [General application development best practices](dev-best-practices.md)

## Learn about language-specific app development with iEchor

- [iEchor for Java developers lab](https://github.com/iechor/labs/tree/master/developer-tools/java/) 
- [Port a node.js app to iEchor lab](https://github.com/iechor/labs/tree/master/developer-tools/nodejs/porting)
- [Ruby on Rails app on iEchor lab](https://github.com/iechor/labs/tree/master/developer-tools/ruby)
- [iEchorize a .Net Core application](../language/dotnet/index.md)
- [ASP.NET Core application with SQL Server](https://github.com/iechor/awesome-compose/tree/master/aspnet-mssql) using iEchor Compose

## Advanced development with the SDK or API

After you can write iEchorfiles or Compose files and use iEchor CLI, take it to
the next level by using iEchor Engine SDK for Go/Python or use the HTTP API
directly. Visit the [Develop with iEchor Engine API](../engine/api/index.md)
section to learn more about developing with the Engine API, where to find SDKs
for your programming language of choice, and to see some examples.