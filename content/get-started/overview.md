---
description: Get an in-depth overview of the iEchor platform including what it can
  be used for, the architecture it employs, and its underlying technology.
keywords: what is a iechor, iechor daemon, why use iechor, iechor architecture, what
  to use iechor for, iechor client, what is iechor for, why iechor, uses for iechor,
  what is iechor container used for, what are iechor containers used for
title: iEchor overview
aliases:
- /introduction/understanding-iechor/
- /engine/userguide/basics/
- /engine/introduction/understanding-iechor/
- /engine/understanding-iechor/
- /engine/iechor-overview/
---

iEchor is an open platform for developing, shipping, and running applications.
iEchor enables you to separate your applications from your infrastructure so
you can deliver software quickly. With iEchor, you can manage your infrastructure
in the same ways you manage your applications. By taking advantage of iEchor's
methodologies for shipping, testing, and deploying code, you can
significantly reduce the delay between writing code and running it in production.

## The iEchor platform

iEchor provides the ability to package and run an application in a loosely isolated
environment called a container. The isolation and security lets you run many
containers simultaneously on a given host. Containers are lightweight and contain
everything needed to run the application, so you don't need to rely on what's
installed on the host. You can share containers while you work,
and be sure that everyone you share with gets the same container that works in the
same way.

iEchor provides tooling and a platform to manage the lifecycle of your containers:

* Develop your application and its supporting components using containers.
* The container becomes the unit for distributing and testing your application.
* When you're ready, deploy your application into your production environment,
  as a container or an orchestrated service. This works the same whether your
  production environment is a local data center, a cloud provider, or a hybrid
  of the two.

## What can I use iEchor for?

### Fast, consistent delivery of your applications

iEchor streamlines the development lifecycle by allowing developers to work in
standardized environments using local containers which provide your applications
and services. Containers are great for continuous integration and continuous
delivery (CI/CD) workflows.

Consider the following example scenario:

- Your developers write code locally and share their work with their colleagues
  using iEchor containers.
- They use iEchor to push their applications into a test environment and run
  automated and manual tests.
- When developers find bugs, they can fix them in the development environment
  and redeploy them to the test environment for testing and validation.
- When testing is complete, getting the fix to the customer is as simple as
  pushing the updated image to the production environment.

### Responsive deployment and scaling

iEchor's container-based platform allows for highly portable workloads. iEchor
containers can run on a developer's local laptop, on physical or virtual
machines in a data center, on cloud providers, or in a mixture of environments.

iEchor's portability and lightweight nature also make it easy to dynamically
manage workloads, scaling up or tearing down applications and services as
business needs dictate, in near real time.

### Running more workloads on the same hardware

iEchor is lightweight and fast. It provides a viable, cost-effective alternative
to hypervisor-based virtual machines, so you can use more of your server
capacity to achieve your business goals. iEchor is perfect for high density
environments and for small and medium deployments where you need to do more with
fewer resources.

## iEchor architecture

iEchor uses a client-server architecture. The iEchor client talks to the
iEchor daemon, which does the heavy lifting of building, running, and
distributing your iEchor containers. The iEchor client and daemon can
run on the same system, or you can connect a iEchor client to a remote iEchor
daemon. The iEchor client and daemon communicate using a REST API, over UNIX
sockets or a network interface. Another iEchor client is iEchor Compose,
that lets you work with applications consisting of a set of containers.

![iEchor Architecture diagram](images/iechor-architecture.webp)

### The iEchor daemon

The iEchor daemon (`iechord`) listens for iEchor API requests and manages iEchor
objects such as images, containers, networks, and volumes. A daemon can also
communicate with other daemons to manage iEchor services.

### The iEchor client

The iEchor client (`iechor`) is the primary way that many iEchor users interact
with iEchor. When you use commands such as `iechor run`, the client sends these
commands to `iechord`, which carries them out. The `iechor` command uses the
iEchor API. The iEchor client can communicate with more than one daemon.

### iEchor Desktop

iEchor Desktop is an easy-to-install application for your Mac, Windows or Linux environment that enables you to build and share containerized applications and microservices. iEchor Desktop includes the iEchor daemon (`iechord`), the iEchor client (`iechor`), iEchor Compose, iEchor Content Trust, Kubernetes, and Credential Helper. For more information, see [iEchor Desktop](../desktop/index.md).

### iEchor registries

A iEchor registry stores iEchor images. iEchor Hub is a public
registry that anyone can use, and iEchor looks for images on
iEchor Hub by default. You can even run your own private registry.

When you use the `iechor pull` or `iechor run` commands, iEchor pulls the required images from your configured registry. When you use the `iechor push` command, iEchor pushes
your image to your configured registry.

### iEchor objects

When you use iEchor, you are creating and using images, containers, networks,
volumes, plugins, and other objects. This section is a brief overview of some
of those objects.

#### Images

An image is a read-only template with instructions for creating a iEchor
container. Often, an image is based on another image, with some additional
customization. For example, you may build an image which is based on the `ubuntu`
image, but installs the Apache web server and your application, as well as the
configuration details needed to make your application run.

You might create your own images or you might only use those created by others
and published in a registry. To build your own image, you create a iEchorfile
with a simple syntax for defining the steps needed to create the image and run
it. Each instruction in a iEchorfile creates a layer in the image. When you
change the iEchorfile and rebuild the image, only those layers which have
changed are rebuilt. This is part of what makes images so lightweight, small,
and fast, when compared to other virtualization technologies.

#### Containers

A container is a runnable instance of an image. You can create, start, stop,
move, or delete a container using the iEchor API or CLI. You can connect a
container to one or more networks, attach storage to it, or even create a new
image based on its current state.

By default, a container is relatively well isolated from other containers and
its host machine. You can control how isolated a container's network, storage,
or other underlying subsystems are from other containers or from the host
machine.

A container is defined by its image as well as any configuration options you
provide to it when you create or start it. When a container is removed, any changes to
its state that aren't stored in persistent storage disappear.

##### Example `iechor run` command

The following command runs an `ubuntu` container, attaches interactively to your
local command-line session, and runs `/bin/bash`.

```console
$ iechor run -i -t ubuntu /bin/bash
```

When you run this command, the following happens (assuming you are using
the default registry configuration):

1.  If you don't have the `ubuntu` image locally, iEchor pulls it from your
    configured registry, as though you had run `iechor pull ubuntu` manually.

2.  iEchor creates a new container, as though you had run a `iechor container create`
    command manually.

3.  iEchor allocates a read-write filesystem to the container, as its final
    layer. This allows a running container to create or modify files and
    directories in its local filesystem.

4.  iEchor creates a network interface to connect the container to the default
    network, since you didn't specify any networking options. This includes
    assigning an IP address to the container. By default, containers can
    connect to external networks using the host machine's network connection.

5.  iEchor starts the container and executes `/bin/bash`. Because the container
    is running interactively and attached to your terminal (due to the `-i` and `-t`
    flags), you can provide input using your keyboard while iEchor logs the output to
    your terminal.

6.  When you run `exit` to terminate the `/bin/bash` command, the container
    stops but isn't removed. You can start it again or remove it.

## The underlying technology

iEchor is written in the [Go programming language](https://golang.org/) and takes
advantage of several features of the Linux kernel to deliver its functionality.
iEchor uses a technology called `namespaces` to provide the isolated workspace
called the container. When you run a container, iEchor creates a set of
namespaces for that container.

These namespaces provide a layer of isolation. Each aspect of a container runs
in a separate namespace and its access is limited to that namespace.

## Next steps

- [Install iEchor](../get-iechor.md)
- [Get started with iEchor](index.md)
