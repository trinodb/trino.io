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
connector and how it can replace more complex usage to access Iceberg metedata.
He also discusses how Trino is a core part of operations at Stripe.

<!--more-->

{% youtube PSGuAMVc6-w %}

## Recap

Trino is the foundational infrastructure on which other data apps and services are
built upon. In Kevin's words, "I call Trino the Swiss army knife in the data
ecosystem." At Stripe, they use Iceberg tables extensively and want to migrate
away from Hive. But Iceberg isn't perfect: one problem with the Iceberg CLI is
that it requires an internal developer machine that accesses the data. The CLI
is also painful to use for them. The CLI uses JSON format as output, which is
difficult to process, read, and use for further analysis. However, Kevin found
that the Trino Iceberg connector can replace some functionality of the
Iceberg CLI.

Unfortunately, there was no way to grab all desired table property information
from the Trino Iceberg connector, because they were using an older version.
Thus, they use the Trino PostgreSQL connector to inspect table metadata directly
from the backend database of the Hive metastore. With the two connectors, they have
all the information about the data warehouse, powering their analysis and
meta-analysis of the data and how it's used.

They also use Trino to inspect Iceberg usage patterns. They log every Trino
query using the Trino event listener and store that in another PostgreSQL
database. This gives the full information of every query that has ever run
through Trino, and allows them to use a catalog with the PostgreSQL connector
to access the query history from the database. This query metadata enrichment
enables a multitude of auditing, debugging, and optimization use cases.

In the future, they plan to use Trino as a validation framework and for Iceberg
table maintenance, and optimize tables based on read patterns.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!