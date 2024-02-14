---
layout: post
title:  "A cache refresh for Trino"
author: Manfred Moser
image: /assets/blog/trino-cache-refresh.png
excerpt_separator: <!--more-->
show_pagenav: true
---

Thinking about our recent work on caching in Trino reminds me of the famous
saying, ["There are only two hard things in computer science: cache invalidation
and naming things](https://www.karlton.org/2017/12/naming-things-hard/)." Well,
in the Trino community we know all about caching and naming. With the recent
[Trino 439 release]({{site.url}}/docs/current/release/release-439.html), caching
from object storage file systems got a refresh. Catalogs using the Delta Lake,
Hive, Iceberg, and soon Hudi connectors now get to access performance benefits
from the new Alluxio-powered file system caching.

<!--more-->

## In the past

So how did we get here? A long, long time ago, Qubole open-sourced a [light
light-weight data caching framework called
RubiX](https://github.com/qubole/rubix). The library was integrated into the
Trino Hive connector, and it enabled [Hive connector storage
caching]({{site.url}}/docs/438/connector/hive-caching.html). But over time, any
open source project without active maintenance becomes stale. And like a stale
cache, a stale open source project can cause issues, or becomes outdated and
unsuitable for modern use. Though RubiX had once served Trino well, it was time
to remove the dust, and RubiX had to go.

## Making progress

Catching back up to 2024, Trino now includes powerful connectors for the modern
lakehouse formats Delta Lake, Hudi, and Iceberg:

<div class="container">
  <div class="row">
    <div class="col-sm">
      <a href="{{site.url}}/docs/current/connector/delta-lake.html" target="_blank">
        <img src="{{site.url}}/assets/images/logos/delta-lake.png" title="Delta Lake connector">
      </a>
    </div>
    <div class="col-sm">
      <a href="{{site.url}}/docs/current/connector/hudi.html" target="_blank">
        <img src="{{site.url}}/assets/images/logos/apache-hudi.png" title="Hudi connector">
      </a>
    </div>
    <div class="col-sm">
      <a href="{{site.url}}/docs/current/connector/iceberg.html" target="_blank">
        <img src="{{site.url}}/assets/images/logos/apache-iceberg.png" title="Iceberg connector">
      </a>
    </div>
  </div>
</div>

Hive is still around, just like HDFS, but we consider them both close to legacy
status. Yet all four connectors could benefit from caching. Good news came at
Trino Summit 2022 when Hope Wang and Beinan Wang from
[Alluxio]({{site.url}}/ecosystem/add-on.html#alluxio) presented about their
integration with Trino and the Hive connector - [Trino optimization with
distributed caching on data lake]({% post_url
2023-07-21-trino-fest-2023-alluxio-recap %}). They mentioned plans to open
source their implementation and an initial pull request (PR) was created.

<div class="container">
  <div class="row">
    <div class="col-sm"></div>
    <div class="col-sm">
      <img src="{{site.url}}/assets/images/logos/alluxio.png" title="Alluxio">
    </div>
    <div class="col-sm"></div>
  </div>
</div>

## Collaboration

The initial presentation and PR planted a seed in the community. The Trino
project had been moving fast in terms of deprecating the old dependencies from
the Hadoop and Hive ecosystem, so the initial Alluxio PR was no longer up to
date and compatible with latest Trino version. Discussions with [David
Phillips](https://github.com/electrum) laid out the path to adjust to the new
file system support and get ready for reviews towards a merge.

In the end it was [Florent Delannoy](https://github.com/pluies) who started
another [PR for file system caching support, specifically for the Delta Lake
connector](https://github.com/trinodb/trino/pull/18719). His teammate [Jonas
Irgens Kylling](https://github.com/jkylling), also a [presenter from Trino Fest
2023]({% post_url 2023-07-14-trino-fest-2023-dune %}), took over the work on the
PR. The collaboration on it was an **epic effort**. After many months of time,
over 300 comments directly on GitHub and numerous hours of coding, reviewing,
testing, and discussion on Slack and elsewhere the work finally resulted in a
successful merge, and therefore inclusion in the next release.

Special props for their help for Florent and Jonas must go out to [David
Phillips](https://github.com/electrum), [Raunaq
Morarka](https://github.com/raunaqmorarka), [Piotr
Findeisen](https://github.com/findepi), [Mateusz
Gajewski](https://github.com/wendigo), [Beinan Wang](https://github.com/beinan),
[Amogh Margoor](https://github.com/amoghmargoor), and [Marton
Bod](https://github.com/marton-bod).

## Finishing

In parallel to the work on the initial PR for Delta Lake, yours truly ended up
working on the documentation, and pulled together an [issue and conversations to
streamline the roll out](https://github.com/trinodb/trino/issues/20550).

[Mateusz Gajewski](https://github.com/wendigo) had also put together a PR to
remove the old RubiX integration already. With the merge of the initial PR we
were off to the races. We merged the removal of RubiX and the addition of the
docs. Mateusz also added support for OpenTelemetry.

[Manish Malhorta](https://github.com/osscm) and [Amogh
Margoor](https://github.com/amoghmargoor) sent a PR for Iceberg support. They
were also about to add Hive support, when [Raunaq
Morarka](https://github.com/raunaqmorarka) beat them and submitted that PR.

After some final clean up, [Cole Bowden](https://github.com/colebow) and [Martin
Traverso](https://github.com/martint) got the release notes together and shipped
[Trino 439]({{site.url}}/docs/current/release/release-438.html)! Now you can use
it, too.

## Using file system caching

There are only a few relatively simple steps to add file system caching to your
catalogs that use Delta Lake, Hive, or Iceberg connectors:

* Provision fast local file system storage on all your Trino cluster nodes. How
  you do that depends on your cluster provisioning.
* Enable file system caching and configure the cache location, for example at
  `/tmp/trino-cache` on the nodes, in your catalog properties files.

```
fs.cache.enabled=true
fs.cache.directories=/tmp/trino-cache
```

After a cluster restart, file system caching is active for the configured
catalogs, and you can tweak it with [further, optional configuration
properties]({{site.url}}/docs/current/object-storage/file-system-cache.html).

## What's next

What a success! It took many members from the global Trino village to get this
feature added. Now our users across the globe can enjoy even more benefits of
using Trino, and also participate in our next steps:

* Further improvements to the current implementation, maybe adding
  worker-to-worker connections for exchanging cached files.
* Preparation to add file system caching with the Hudi connector is in progress
  with [Sagar Sumit](https://github.com/codope) and [Y Ethan
  Guo](https://github.com/yihua) and implementation is following next.
* Adjust to any learnings from production usage.

Our thanks, and those from all current and future users, go out to everyone
involved in this effort. What are we going to do next?

*Manfred*

PS: If you want to share your use of Trino or connect with other Trino users,
[join us for the free Trino Fest 2024]({% post_url
2024-02-20-announcing-trino-fest-2024 %}) as speaker or attendee live in Boston,
or virtually from your home.
