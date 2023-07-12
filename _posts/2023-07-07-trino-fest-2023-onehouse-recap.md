---
layout: post
title: "Skip rocks and files: Turbocharge Trino queries with Hudi’s multi-modal indexing subsystem"
author: "Nadine Farah, Sagar Sumit, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Onehouse.png
show_pagenav: false
---

Optimizing data access and query performance is crucial to building low-latency
applications and running analytics. Even with the modern data lakehouse designed
to be as efficient and performant as possible, there are a number of bottlenecks
that can slow things down and plenty of challenges to overcome. Nadine and Sagar
explored this at Trino Fest, introducing us to multi-modal indexing and the
metadata table in Hudi, how they work, and how leveraging them with Trino can
unlock queries faster than ever before.

<!--more-->

{% youtube IiDOmAEOXUM %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Onehouse.pdf">
  Check out the slides!
</a>

## Recap

When you're building large-scale data-based applications, bottlenecks are
inevitable. Finding ways to address these bottlenecks and optimizing your
platform to avoid them is going to be a huge cost, so it pays off to know your
requirements. In the same vein, if you know the types of services and features
you need to effectively scale, you can build with them in mind from the ground
up. Hudi has a couple key features you might be interested in that aren't
present in all lakehouses:

* Write indexing, speeding up and optimizing inserts and upserts
* Automated table services, which handle clustering, cleaning, compacting,
  and metadata indexing without any need for manual orchestration or overhead

Nadine also goes on a deep dive into exactly how the Hudi table format works,
but emphasizes that these extra features elevate it to being an entire platform,
not just a table format.

From there, Nadine passes things off to Sagar, who does an explanation of the
multi-modal indexing sub-system in Hudi, which features a scalable metadata
table, different types of indexes, and an async indexer. All of these features
minimize tradeoffs while maximizing performance, helping you read and write data
faster than ever. And with Trino's Hudi connector, the Trino coordinator is able
to read the feature-rich Hudi metadata to more effectively delegate workers,
leveraging that speed as the best-in-class query engine for running analytics on
your data stored in Hudi.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!