---
layout: post
title: "Data mesh implementation using Hive views"
author: "Alejandro Rojas, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Comcast.png
show_pagenav: false
---

At Comcast, data is used in a data mesh ecosystem, with a vision where users can
discover data and request data through a self-service platform. With federation,
various tools, and the ability to create, read, and write data with different
platforms, it's a full-blown data mesh. So how do you build that? With Trino, of
course, and with the power of Hive views. Tune into the 10-minute lightning talk
that Alejandro gave at Trino Fest to learn more about how Comcast pulled it off.

<!--more-->

{% youtube ZgcVtPFkKHM %}

## Recap

With various different storage systems, like S3 and MinIO, and users that
want to be able to use a variety of data platforms, including Trino, but also
Databricks and Spark, Comcast needed something to sit between the data and those
platforms. The solution was the Hive CLI and Hive views, which could read from 
all their various forms of storage, and which could be read from all the
user-facing query engines and data platforms with no issues.

By centralizing data, there was also the upside of easily integrating with
Privacera, which allowed for privacy policies to be implemented without much
issue. Users could request access to the data within the Hive views, and data
owners could approve or reject access as appropriate. Because of the
centralization, it was easy to go very fine-grained with data access rules,
allowing for access control as specific as column-level.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!