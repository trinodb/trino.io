---
layout: post
title: "DuneSQL - A query engine for blockchain data"
author: "Miguel Filipe, Jonas Irgens Kylling, Ryan Duan"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Dune.png
show_pagenav: false
---

The need to make blockchain data easily accessible has risen over the recent
years due to the popularity of cryptocurrencies, NFTs, and other uses of
blockchains. Dune has made it their mission to make blockchain data more
accessible. Dune is a community data platform for querying public blockchain
data and building beautiful dashboards. They use their own query engine called
DuneSQL, built as extension of Trino, to query blockchain data. In the session,
Miguel and Jonas from Dune talk about the challenges of querying blockchain
data, their transition to Trino, and how DuneSQL is operated. Watch the
recording of the session or keep reading for a recap.

<!--more-->

{% youtube sCJncarnGdU %}

## Recap

The Dune community data platform is a serverless, open access, community-wide
collaboration portal. Dune experienced some difficulties with blockchain data,
such as processing and ingesting raw data, deserializing and decoding function
calls and arguments, and allowing the community to build abstractions. Their
engine, DuneSQL, is Trino with custom extensions that they created. It runs tens
of thousands of queries that are executed, saved, and re-used each day.

At first, Dune used PostgreSQL, where they sharded per blockchain and used
vertical scaling. However, they quickly ran into bottleneck issues on storage
size and IOPS (I/O operations per second). Thus, they switched to Apache Spark
with Databricks to allow horizontal scaling and support more blockchains
processing and to support the vast query volume that they had. Unfortunately,
the result was not performant and not interactive enough. In the end, Miguel
says that, "Trino was our choice for performance reasons, for the good
environment and ecosystem, and to fully support our scheme and our datasets."
Using Trino addressed the performance issues.

Operating DuneSQL requires modifications and extensions of Trino to suit the
needs of the users and platform as a whole. DuneSQL needs to manage the whole
fleet and the capacity they have, because they use over 4000 CPUs per hour, do
more than 100 billion S3 requests per month, and operate over 10 clusters. To
handle the scheduling and load balancing of these massive operations, DuneSQL
uses query execution services and
[gateway](https://github.com/lyft/presto-gateway). Clusters have a fixed size to
have a predictable capacity and performance. The gateway exposes the clusters to
reduce the blast-radius so failures do not affect other clusters. Even with all
these adjustments, they still have work to do as they plan to optimize the
billions of S3 requests they receive, improve data layout, and implement
sandboxed user defined functions.

Interested in DuneSQL? Check out the video where Jonas goes over the
specificities and unique characteristics of DuneSQL.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!