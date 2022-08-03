---
layout: post
title: Migrating from PrestoSQL to Trino
author: David Phillips, Dain Sundstrom
excerpt_separator: <!--more-->
---

As we previously announced, we're
[rebranding Presto SQL as Trino]({% post_url 2020-12-27-announcing-trino %}).
Now comes the hard part: migrating to the new version of the software.
We just released the first version,
[Trino 351](/docs/current/release/release-351.html),
which uses the name Trino everywhere, both internally and externally.
Unfortunately, there are some unavoidable compatibility aspects that
administrators of Trino need to know about. We hope this post makes the
transition as smooth as possible.

<!--more-->

# Things that haven't changed

Let's start with the good news. For end users running queries against Trino,
everything should be the same. There are no changes to the SQL language,
SQL functions, session properties, etc.

Users now see *Trino* in error messages, a different logo in the web UI,
and error stack traces have a different package name, but otherwise they
won't know that anything has changed. All of their views, reports,
or other stored queries will work as before.

Similarly for administrators, except for a few things noted in the
[Trino 351 release notes](/docs/current/release/release-351.html),
all the configuration properties are the same.

# Client protocol compatiblity

The client protocol is how clients, such as the
[CLI](docs/current/client/cli.html) or
[JDBC driver](/docs/current/client/jdbc.html),
talk to Trino. It uses standard HTTP as the underlying communications
protocol, with some custom HTTP headers to communicate values
to and from Trino. Unfortunately, those header names started with
`X-Presto-` and thus had to be changed to `X-Trino-`.

The Trino CLI and JDBC driver send the new headers, so they are
**only compatible with Trino versions 351 and newer**. Users should
wait to upgrade the CLI or JDBC driver until the Trino servers they
talk to have been upgraded.

Out of the box, the Trino server does not work with older clients.
However, in order to support a graceful transition, you can allow the
server to support older clients by adding a configuration property:

```
protocol.v1.alternate-header-name=Presto
```

**We recommend using version 350 of CLI and JDBC driver as the transition version**.
It has all the newest features such as variable precision timestamps,
has been tested with a range of older server versions, and is the last
version to support older servers.

# JDBC driver


The URL prefix for the JDBC driver now starts with `jdbc:trino:` instead
of `jdbc:presto:`. This means that any client applications using the
JDBC driver need to update their connection configuration. The old
prefix is still supported, but will be removed in a future release.

The class name of the driver is now `io.trino.jdbc.TrinoDriver`. This is
of no concern to most users, as the driver is normally accessed via the
standard JDBC auto-discovery mechanism based on the URL. As with the URL prefix,
the old name is still supported, but will be removed in a future release.

# Server RPM

The name of the RPM has changed, so it is treated as a different RPM, and
thus you cannot simply upgrade from the old version to the new version.
All of the directories for the RPM that contained the name `presto` now
use `trino` instead. You likely want to uninstall the old RPM, rename
the config and log directories, then install the new RPM.

# Docker image

The [Trino Docker image](https://hub.docker.com/r/trinodb/trino) is now
published as `trinodb/trino`. The supported configuration directory is
now `/etc/trino`. The CLI is now named `trino` instead of `presto`.

# JMX MBean naming

Trino runs on the JVM, which has the JMX framework as a standard way to expose
system and application metrics. Trino exposes a huge number of JMX metrics for
administrators to monitor their clusters. You might be using these metrics
via your monitoring system, or perhaps you are accessing them in SQL via the
Trino [JMX connector](/docs/current/connector/jmx.html).

The metrics for Trino server now start with `trino` instead of `presto`. You
might need to update this name in your monitoring system, or you can revert
to the old name:

```
jmx.base-name=presto
```

Similarly, the metrics for the Elasticsearch, Hive, Iceberg, Raptor, and Thrift
connectors now start with `trino.plugin` instead of `presto.plugin`. Again,
you might need to update these names in your monitoring system, or you can
revert to the old name. For example, for the Hive connector:

```
jmx.base-name=presto.plugin.hive
```

# Thrift connector

The [Thrift connector](/docs/current/connector/thrift.html) had many
[backwards incompatible changes](/docs/current/release/release-351.html#thrift-connector-changes)
to both the Thrift service interface and the configuration properties. You need
update all of your implementations of the Thrift service used by the connector.

# SPI

If you have any custom plugins for Trino, such as connectors or functions,
these need to be updated. The package name is now `io.trino.spi`, and a
few classes were renamed:

* `PrestoException` to `TrinoException`
* `PrestoPrincipal` to `TrinoPrincipal`
* `PrestoWarning` to `TrinoWarning`

There are no functional changes, so all you should need to do is update
your imports and rename the references to the above class names.

# Migration guide

Now that you understand what is different and what you need to change,
you can start thinking about the list of steps needed to perform the
migration. The following is a rough plan for upgrading your environment.

**Step 1: Prepare to deploy the new version**

* Let users know the name is changing, so they are not surprised by the logo changes in the UI.
* Make sure that users are using recent client versions. Ideally, upgrade them all to
  version 350, as mentioned above. You can check the HTTP request logs for the coordinator
  to see what client versions are in use.
* Update your server configuration with `protocol.v1.alternate-header-name=Presto`
  to allow supporting all of your existing Presto clients.
* If you are using the RPM, have a plan to deal with the new RPM name
  and the `trino` directory names.
* If you are using Docker, use the new image name, make sure your configuration will
  be mounted using the `trino` path name, and remember that the CLI is now named `trino`.
* Update any custom plugins to use the new SPI.
* Check if you have anything using JMX to monitor your clusters, and decide if you will
  update them to the new names or set a Trino config to revert to the old names.

**Step 2: Upgrade your servers to Trino 351+**

* Upgrade development and staging servers.
* Upgrade production servers. If you have multiple clusters, you can do them one
  at a time, and verify everything is working before moving on to the next one.

**Step 3: Upgrade clients**

* Upgrade all clients including the CLI, JDBC driver, Python, etc., to the Trino versions.
* Update any applications using JDBC to use the new `jdbc:trino:` connection URL prefix.

**Step 4: Cleanup**

* Remove the `protocol.v1.alternate-header-name` configuration property.
* If you configured Trino to use the old JMX names, convert your monitoring system
  to use the new JMX names and remove the fallback configs.

# Getting help

We're here to help! If you run into any issues while upgrading, or having any
questions or concerns, [ask on Slack](/slack.html).
