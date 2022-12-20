---
layout: post
title: "Journey to Iceberg with Trino"
author: "JaeChang Song, Jennifer Oh, Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/sk-telecom.jpg
---

This post comes from [the second half of Trino Summit 2022 session]({% post_url 
2022-11-21-trino-summit-2022-recap %}). Our friends JaeChang and Jennifer from
SK Telecom traveled across the globe from South Korea to join us in person! SK
Telecom recently had some issues scaling Trino on the Hive model, among other
issues that come with Hive. While some initial tweaking helped speed things up,
it ultimately never solved the problem. After switching to Iceberg, SK Telecom
ran initial performance tests with some very impressive results. In this talk,
Jennifer and JaeChang describe their journey to Iceberg with Trino.

<!--more-->

{% youtube V9_aPLXATh8 %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@SK-Telecom.pdf">
  Check out the slides!
</a>

## Recap

SK Telecom is a South Korean telecom company that has built and operated an
on-premise data platform based on open source software to determine
manufacturing yield since 2015. SK Telecom's goal has always been to build an observable
federated data platform on open source software at scale. 

SK Telecom manages on-premise Hadoop clusters to store their data. Previously,
they used tools like
[distcp](https://hadoop.apache.org/docs/stable/hadoop-distcp/DistCp.html) to
make data available in one center. SK Telecom started using Presto in 2016 and
shifted to Trino in 2021. To run batch queries on their warehouse, Trino workers
are deployed on HDFS data nodes. There is also an adhoc Trino cluster deployed
to manage federated queries over multiple data silos from an array of disparate
data sources. This was one of the slow and brittle processes that Trino
replaced. They chose Trino because it simplifies querying novel big data systems
and combines that data more commonplace systems for their users.

As Trino adoption grew within the company up to 300 requests per minute, they
eventually faced challenges with scaling. Not only were the number of
requests growing, but the range of data being queried grew as well; users were
evaluating petabytes of data, with terabyte-sized query input processed across
hundreds of nodes. Many user queries were blocked while waiting for resources to
become available. In response, the data engineering team began investigating how
they could both scale and improve individual query performance.

To find the root cause, SK Telecom's data engineers investigated cluster
behavior beyond what was exposed in the web UI. They began collecting all the
query plan JSON files, coordinator and worker JMX stats, system metrics, and
Trino logs to build out their own metrics dashboard. The two main
causes were that input data was too large, and there were spikes in the number
of `BlockedSplit` operations leading to queries being blocked while waiting for
other tasks to complete. They initially aimed to address this by changing some
settings to increase thread counts and tuning the settings, but these changes
still didn't achieve the desired results. The ultimate bottleneck was the Hive
metastore and the expensive list operations that caused many of the blocking
operations to finish slowly.

At this point, the team reevaluated their needs to consider alternative
solutions. They needed a better indexing strategy on the data with a flexible
partitioning strategy. They also needed to remove the bottleneck on the metadata
for this data while still maintaining compatibility across multiple query
engines as Hive did.

The team looked at the existing set of novel data lake connectors available in
Trino version 356, which at the time only included Iceberg. SK Telecom was 
immediately impressed by the metadata indexing in the Iceberg project. They 
particularly liked Iceberg's snapshot isolation as data is created or modified.
They were able to speed up queries using data file pruning on partition and
column stats stored in the manifest file.

After running a benchmark, the team found that Iceberg reduced the input data
size on the order of hundreds, down to under ten gigabytes. They also
investigated adding a high amount of partitions to continue lowering the input
data, but found that there's a tradeoff where creating too many partitions
increases query planning time. Ultimately, they found a sweet spot where the
input data size was around six gigabytes and planning only took 70 milliseconds.

This summary is just the tip of the iceberg of all the information JaeChang and
Jennifer shared with us about how Iceberg helped SK Telecom with their Trino
scaling issues. Watch this incredible talk to learn more if you're considering
taking the leap from Hive to Iceberg!

## Share this session

If you thought this talk was interesting, please consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome, 
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/sk-telecom-social.png"/>