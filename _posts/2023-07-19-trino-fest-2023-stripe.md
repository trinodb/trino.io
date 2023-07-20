---
layout: post
title: "Inspecting Trino on ice"
author: "Kevin Liu, Ryan Duan"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Stripe.png
show_pagenav: false
---

For those unfamiliar, Stripe is an online payment processor that facilitates
online payments for digital-native merchants. They use Trino to facilitate ad
hoc analytics, enable dashboarding, and provide an API for internal services and
data apps to utilize Trino. In Kevin Liu's session at [Trino Fest 2023]({%
post_url 2023-06-20-trino-fest-2023-recap %}), he showcases the Trino Iceberg
connector and how it can replace more complex usage to access Iceberg metadata.
He also discusses how Trino is a core part of operations at Stripe.

<!--more-->

{% youtube PSGuAMVc6-w %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Stripe.pdf">
  Check out the slides!
</a>

## Recap

Trino is the foundational infrastructure on which other data apps and services
are built upon. In Kevin's words, "I call Trino the Swiss army knife in the data
ecosystem."

At Stripe, they use Iceberg tables extensively, replacing legacy Hive tables.
But Iceberg isn't perfect: one problem with Iceberg is reading its metadata from
S3. To work with Iceberg metadata, Stripe developed an internal CLI tool. The
tool requires a privileged internal machine, which is only accessible to
developers. And outputs the result in JSON format, which is difficult to
process, read, and use for further analysis. However, Kevin found that the Trino
Iceberg connector can replace most of the functionality of the Iceberg CLI. The
connector brings Iceberg metadata information to Trino’s powerful analytical
engine and facilitates lightning fast debugging and analysis.

Unfortunately, there was no way to grab all desired table property information
from the Trino Iceberg connector, because they were using an older version.
Thus, they use the Trino PostgreSQL connector to connect directly to the backend
database of the Hive Metastore, allowing them to inspect table metadata
directly. With the two connectors, they have all the information about the data
warehouse, powering their analysis and meta-analysis of the data and how it's
used. 

They also use Trino to inspect Iceberg usage patterns. They log every Trino
query using the Trino event listener and store that in another PostgreSQL
database. This gives the full information of every query that has ever run
through Trino, and allows them to perform analysis using historical queries.
Combined with Trino's built-in query metadata enrichment, this method enables a
multitude of auditing, debugging, and optimization use cases. 

In the future, they plan to use Trino to improve data quality by leveraging it
as a validation framework, to perform Iceberg table maintenance, and to optimize
tables based on historical read patterns.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!