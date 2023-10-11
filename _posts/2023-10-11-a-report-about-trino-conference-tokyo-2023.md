---
layout: post
title: "A report from the Trino Conference Tokyo 2023"
author: Yuya Ebihara
excerpt_separator: <!--more-->
show_pagenav: false
---

The Trino community in Japan held an online event on October 5th, 2023. This
article is a summary of the conference aiming to share the presentations and
provide an overview.

<!--more-->

Watch a replay of the whole event, or jump to specific time stamps and topic of
interest:

{% youtube CTwk2rkatx8 %}

This year, there were 4 sessions:

1. Trino, Starburst Galaxy, and Enterprise
2. Log infrastructure using Trino and Iceberg
3. Data infrastructure using Spark and Trino on bare metal k8s
4. Getting started Trino and a transactional data lake with serverless Athena

# Trino, Starburst Galaxy, and Enterprise

The first session was presented by Yuya Ebihara (me) from Starburst. I explained
the Trino changes from 2022 and 2023, as well as features of Starburst Galaxy
and Starburst Enterprise. The session introduced [a press release of the
partnership of Starburst and Dell Technologies in
Japan](https://prtimes.jp/main/html/rd/p/000000226.000025237.html).

<iframe src="https://docs.google.com/presentation/d/e/2PACX-1vRubtZB9peROzcGgaTQQYkLs-9jZEbWuRszNInKviuj1RdPwp5CrElssLwLYSUuVeGUfj58wv428UFw/embed" frameborder="0" width="595" height="485" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

# Log infrastructure using Trino and Iceberg

The second session was presented by Tadahisa Kamijo from Sakura Internet. He
 explained some requirements for new analytics environments such as concurrent
read/write, schema evolution, record-level modification, restoring past
snapshots, and addressing performance issues with the Hive metastore. They
decided to use Trino and Iceberg for handling these requests. Kamijo-san also
introduced the file layout in Iceberg and demonstrated how to debug Iceberg
files using their Java client.

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/4c9229c81e36494ca0c722b20bfdf20e" title="TrinoとIcebergで ログ基盤の構築 / 2023-10-05 Trino Presto Meetup" allowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 100%; height: auto; aspect-ratio: 560 / 315;" data-ratio="1.7777777777777777"></iframe>

# Data infrastructure using Spark an Trino on bare metal k8s

The third session was presented by Yasukazu Nagatomi from MicroAd. They started
a migration to Trino from Impala to resolve the following issues - separating
computing and storage, refreshing and utilizing table and column statistics even
with large tables, and supporting schema evolution. Nagatomi-san shared a use
case of the Trino features fault-tolerant execution and spill-to-disk, which is
the first public use case of these features in Japan.

<iframe src="//www.slideshare.net/slideshow/embed_code/key/NTzgv4IUvAPIvp" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/microad_engineer/trino-conference-tokyo-2023" title="ベアメタルで実現するSpark＆Trino on K8sなデータ基盤" target="_blank">ベアメタルで実現するSpark＆Trino on K8sなデータ基盤</a> </strong> from <strong><a href="//www.slideshare.net/microad_engineer" target="_blank">MicroAd, Inc.(Engineer)</a></strong> </div>

# Getting started Trino and a transactional data lake with serverless Athena

The last session was presented by Sotaro Hikita from AWS. Athena is a serverless
service for ad hoc analytics with Trino and Presto foundation. It supports not only S3
data but also various datasources via Federated Query. In Athena, Iceberg
supports both read and write operations, while Hudi and Delta Lake only support
read operations.

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/e1f3188001ca4919b227177f3934b626" title="サーバレスなAmazon Athenaで始めるTrinoとTransactional Data Lake" allowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 100%; height: auto; aspect-ratio: 560 / 315;" data-ratio="1.7777777777777777"></iframe>

# Wrap up

We sincerely appreciate the participation of community members in Japan. Thank
you so much for watching the live event. We are planning to hold an offline
event next year, see you next time!

*Yuya*
