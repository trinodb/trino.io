---
layout: page
menu_id: download
title: Download
---

## Current Release

The current Presto release is version <b>{{ site.presto_version }}</b>.
Learn more details from the <a href="docs/current/release/release-{{ site.presto_version }}.html">release notes</a>.

<div markdown="1" class="feature-grid">

<div markdown="1">
## Server

See [Deploying Presto](docs/current/installation/deployment.html)
for complete deployment instructions.

{% download presto-server .tar.gz %}
{% download presto-server-rpm .rpm %}
</div>

<div markdown="1">
## Command Line Interface

You can run queries using the interactive
[Command Line Interface](docs/current/installation/cli.html).

{% download presto-cli -executable.jar %}
</div>

<div markdown="1">
## JDBC Driver

Connect to Presto from Java using the
[JDBC Driver](docs/current/installation/jdbc.html).

{% download presto-jdbc .jar %}
</div>

</div>
