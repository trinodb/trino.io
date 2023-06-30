---
layout: post
title: "CDC patterns in Apache Iceberg"
author: "Ryan Blue, Ryan Duan"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/ApacheIceberg.png
show_pagenav: false
---

Have you ever wanted to keep your data in a table and have an efficient way to
interact with them? Iceberg, an open standard table format, is
exactly what you need. One of the great and unique features of the Iceberg
table format is its support for change data capture (CDC). Co-creator of
Apache Iceberg, Ryan Blue, presented at [Trino Fest 2023]({% post_url
2023-06-20-trino-fest-2023-recap %}) this past week detailing the CDC support
and the trade-offs between different patterns that can be used for writing
CDC streams into Iceberg tables.

<!--more-->

{% youtube GM7EvRc7_is %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Iceberg.pdf">
  Check out the slides!
</a>

## Recap

To begin, what is CDC and why should you use it? CDC is the idea that when
relational or transactional tables are modified, you emit an update stream.
This enables you to keep copies in sync by capturing changes to tables as
they happen. As Ryan states, "[CDC] is very lightweight on the source
database ... rather than being super careful with what we run on the database,
what we want to do is just make a copy of it very easily and maintain that
copy." Ryan continues giving an example of a bank using a transactional table
in Iceberg to offer some context on what's going on.

Although CDC has many advantages, there are also some problems that make it
difficult:

* Lower latency means more work
* Write amplification - the work necessary to balance the trade-offs between
  efficiency at write time and efficiency at read time
* Batch writes with double update and possible inconsistency
* Read requirements with the different types of deletes in a table

With these types of problems, the importance of the trade-offs between the
different patterns rise due to the need for utmost efficiency. The first
trade-offs that Ryan talks about are the storage trade-offs between using direct
writes and a change log table, which is considered the most important and often
overlooked decision. The next trade-offs are in regards to the `MERGE` pattern's
choice of lazy merge (merge-on-read) or eager merge (copy-on-write). In
addition, the commit frequency trade-offs have different benefits depending on if you
prefer it to be faster or slower. The change log pattern and `MERGE` pattern both
have benefits you may want, so Ryan suggests using a hybrid version of both that
may give you what you want from both patterns. With Iceberg, you have the choice and the
different CDC patterns can be supported for you to adjust your usage to your
specific needs. Check out the video and review the slides for more details!

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!