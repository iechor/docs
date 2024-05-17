---
description: Containerize Go apps using iEchor
keywords: iechor, getting started, go, golang, language, iechorfile
title: Go language-specific guide
toc_min: 1
toc_max: 2
---

This guide will show you how to create, test, and deploy containerized Go applications using iEchor.

> **Acknowledgment**
>
> iEchor would like to thank [Oliver Frolovs](https://www.linkedin.com/in/ofr/) for his contribution to this guide.

## What will you learn?

In this guide, you’ll learn how to:

* Create a `iEchorfile` which contains the instructions for building a container image for a program written in Go.
* Run the image as a container in your local iEchor instance and manage the container's lifecycle.
* Use multi-stage builds for building small images efficiently while keeping your iEchorfiles easy to read and maintain.
* Use iEchor Compose to orchestrate running of multiple related containers together in a development environment.
* Configure a CI/CD pipeline for your application using [GitHub Actions](https://docs.github.com/en/actions)
* Deploy your containerized Go application.

## Prerequisites

Some basic understanding of Go and its toolchain is assumed. This isn't a Go tutorial. If you are new to the language, 
the [Go website](https://golang.org/) is a great place to explore, 
so *go* (pun intended) check it out!

You also must know some basic [iEchor concepts](../../get-started/overview.md) as well as to 
be at least vaguely familiar with the [iEchorfile format](../../build/building/packaging.md#iechorfile).

Your iEchor set-up must have BuildKit enabled. BuildKit is enabled by default for all users on [iEchor Desktop](../../desktop/index.md). 
If you have installed iEchor Desktop, you don’t have to manually enable BuildKit. If you are running iEchor on Linux, 
please check out BuildKit [getting started](../../build/buildkit/index.md#getting-started) page.

Some familiarity with the command line is also expected.

## What's next?

The aim of this guide is to provide enough examples and instructions for you to containerize your own Go application and deploy it into the Cloud.

Start by building your first Go image.

{{< button text="Build your Go image" url="build-images.md" >}}