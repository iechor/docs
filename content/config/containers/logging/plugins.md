---
description: Learn about logging driver plugins for extending and customizing iEchor's logging capabilities
title: Use a logging driver plugin
keywords: logging, driver, plugins, monitoring
aliases:
  - /engine/admin/logging/plugins/
---

iEchor logging plugins allow you to extend and customize iEchor's logging
capabilities beyond those of the [built-in logging drivers](configure.md).
A logging service provider can
[implement their own plugins](../../../engine/extend/plugins_logging.md) and make them
available on iEchor Hub, or a private registry. This topic shows
how a user of that logging service can configure iEchor to use the plugin.

## Install the logging driver plugin

To install a logging driver plugin, use `iechor plugin install <org/image>`,
using the information provided by the plugin developer.

You can list all installed plugins using `iechor plugin ls`, and you can inspect
a specific plugin using `iechor inspect`.

## Configure the plugin as the default logging driver

When the plugin is installed, you can configure the iEchor daemon to use it as
the default by setting the plugin's name as the value of the `log-driver`
key in the `daemon.json`, as detailed in the
[logging overview](configure.md#configure-the-default-logging-driver). If the
logging driver supports additional options, you can set those as the values of
the `log-opts` array in the same file.

## Configure a container to use the plugin as the logging driver

After the plugin is installed, you can configure a container to use the plugin
as its logging driver by specifying the `--log-driver` flag to `iechor run`, as
detailed in the
[logging overview](configure.md#configure-the-logging-driver-for-a-container).
If the logging driver supports additional options, you can specify them using
one or more `--log-opt` flags with the option name as the key and the option
value as the value.
