---
layout: post
title: "Trino optimization with distributed caching on data lakes"
author: "Hope Wang, Beinan Wang, and Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Alluxio.png
show_pagenav: false
---

By 2025, there will be 100 zetabytes stored in the cloud. That's
100,000,000,000,000,000,000,000 bytes - a huge, eye-popping number. But only
about 10% of that data is actually used on a regular basis. At Uber, for
example, only 1% of their disk space is used for 50% of the data they access on
any given day. With so much data but such a small percentage being used, it
raises the question: how can we identify frequently-used data and make it more
accessible, efficient, and lower-cost to access?

Once we have identified that "hot data," the answer is data caching. By caching
that data in storage, you can reap a ton of benefits: performance gains, lower
costs, less network congestion, and reduced throttling on the storage layer.
Data caching sounds great, but why are we talking about it at a Trino event?
Because [data caching with Alluxio is coming to Trino](https://github.com/trinodb/trino/pull/16375)!

<!--more-->

{% youtube oK1A5U1WzFc %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Alluxio.pdf">
  Check out the slides!
</a>

## Recap

So what are the key features of data caching? The first and foremost is that the
frequently-accessed data gets stored on local SSDs. In the case of Trino, this
means that the Trino worker nodes will store data to reduce latency and decrease
the number of loads from object storage. Even if the worker restarts, it also still has
that data stored. Caching will work on all the data lake connectors, so whether
you're using Iceberg, Hive, Hudi, or Delta Lake, it'll be speeding your queries
up. The best part is that once it's in Trino, all you need to do is enable it,
set three configuration properties, and let the performance improvement speak
for itself. There's no other change to how queries run or execute, so there's no
headache or migration needed.

Hope then gives deeper technical detail on exactly how data caching works. She
highlights a few existing examples of how large-scale companies, Uber and
Shopee, have utilized data caching to reap massive performance gains. Then the
talk is passed off to Beinan, who gives further technical detail,
exploring cache invalidation, how to maximize cache hit rate, cluster
elasticity, cache storage efficiency, and data consistency. He also explores
ongoing work on semantic caching, native/off-heap caching, and distributed
caching, all of which have interesting upsides and benefits.

Give the full talk a listen if you're interested, as both Hope and Beinan go
into a lot of great, technical detail that you won't want to miss out on. And
don't forget to keep an eye on Trino release notes to see when it's live!

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!
