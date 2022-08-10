---
layout: post
title: "Architecting Trino to be the Next-Generation ETL Query Engine"
author: "Zebing Lin"
excerpt_separator: <!--more-->
---

Trino was originally designed as an interactive analytics engine, featuring
amazing processing speed, standard SQL support, and the ability to query data
from different sources. However, after seeing the merit of a unified engine for
both interactive and batch workloads, it quickly got popular as an ELT/ETL
engine in the industry. In practice though, insufficient support for
memory-intensive and long-running queries has been major pain points that
prevent users from adopting Trino for batch processing at larger scale.
Inability to recover from failures in long-running queries leads to huge
variance of data landing time, and lack of fine-grained resource management
requires all data of stage execution to fit in memory. This blog discusses the
architecture we used to address these pain points and provide first-class
support for large-scale batch processing in Trino.

<!--more-->

# Limitations of the original architecture

![](/assets/blog/architecting-trino-next-gen-etl-engine/previous-architecture.png)

Trino is designed for low latency and follows the classic MPP architecture,
featuring in-memory streaming shuffle. Tasks are interconnected and data is
streamed through the task dependency graph with no intermediate checkpointing.
This all-or-nothing architecture makes it really hard to tolerate faults. If
any of the tasks dies/fails, there is no way to resume execution from some
intermediate state, the only option is to restart the whole query. This is
extremely painful for long-running queries as they are more likely to fail, and
impact of failures is much higher as it often results in significant waste of
time and resources.

With the exception of grouped execution,which applies to limited scenarios like
bucketed tables in Hive, Trino requires processing of all partitions in a stage
to happen at the same time. As a result, data processing of all these partitions
must fit in memory. This memory barrier constraint makes it extremely difficult
to execute huge joins/aggregations in ETL pipelines, when the cluster doesn’t
have enough memory to hold the hash tables.

Using static task placement, we are limited by the size of the cluster in how
many nodes we can partition the data. With inflexible scheduling runtime,
certain optimizations are not possible. We can’t apply classic techniques like resource
isolation, speculative execution, adaptive query planning, and skew handling to
scale Trino worker execution.

# A new execution paradigm

![](/assets/blog/architecting-trino-next-gen-etl-engine/current-architecture.png)

To address this, we introduce a new execution paradigm to Trino by adding
exchange spooling that stores intermediate data in an efficient buffering layer
at stage boundaries. This opens up a lot of new opportunities around failure
recovery, resource management, and query optimization.

## Fault-tolerance

There are now two levels of fault-tolerance into Trino:

### Query-level Retry

By maintaining a deduplication buffer with the ability to spill to external
storage on the coordinator, Trino supports auto restart of a full query in case
of transient errors. This enables auto failure recovery for interactive and
short-running batch workloads, without the need for users to intervene.

### Task-level Retry

Task-level retry is supported via storing intermediate data produced by tasks to
external storage, such as replicated RAM/SSD/HDD for persistence.
This is also called exchange spooling. This allows restart of a single task in
case of failure, assuming deterministic partitioning at exchange boundaries, and
therefore providing granular failure recovery.

This new fault-tolerant execution paradigm presents challenges in
terms of correctness and performance in the following aspects:

#### Task Scheduling

To ensure correctness, we added task scheduling support for fault-tolerant
execution to ensure:

1. **Determinism**: In case of failure, a task must be restarted with the same 
input partition or set of splits.
2. **Restartability**: Failure of a task should be propagated to the scheduler,
and scheduler should be able to reschedule the failed task for re-execution.
3. **Atomicity**: We need to make sure tasks are atomic and don’t produce any
side effects. A deduplication buffer on Coordinator is used to deduplicate the
output produced by different instances of the same task. Meanwhile, for insert
queries, connectors need to make sure non-committed data is not visible.

#### Exchange Spooling

The intermediate storage for spooling data should be able to buffer, store and
return it efficiently.

![](/assets/blog/architecting-trino-next-gen-etl-engine/exchange-spooling.png)

Currently, we have implemented a filesystem-based approach in the 
`trino-exchange-filesystem` plugin, supporting AWS S3, Azure Blob
Storage, Google Cloud Storage, as well as S3-compatible systems. The
implementation takes full advantage of asynchronous APIs to overlap
computation and I/O, and performs parallel reads and writes from and to exchange
storage in parts to maximize throughput. We also opportunistically coalesce and
split partition files depending on the size. 

The exchange APIs defined in the Trino SPI are designed to be extensible. This 
allows for customized implementations of the exchange spooling APIs, and that 
future directions might involve building a dedicated buffering service using 
tiered storage from memory and SSD to the existing object stores.

With fault tolerance built into Trino, long-running queries on unreliable 
hardware can complete successfully without users having to resubmit them. This 
leads to more efficient execution, and a better experience in the face of 
machine failure. It also opens the opportunity for running on much cheaper spot
instances as well as auto scaling our Trino clusters to further optimize costs.

## Resource Management

Buffering intermediate results makes it possible to execute tasks iteratively,
and we are no longer constrained by the size of the cluster to configure the
number of partitions. This greatly reduces the memory pressure of large queries,
as now we can process a subset of data at a time. Executing memory-intensive
queries without the need of expanding a cluster significantly lowers the cost of
operation.

Iterative task execution also allows us to be more flexible in terms of resource
management. We have added scheduler support for allowing exclusive node
allocation, implemented adaptive sizing strategy for intermediate tasks,
memory-aware bin packing and memory overcommitment. In the future, we plan to
enhance resource management by adding support for autoscaling and spot
instances, add stats-based task size estimation, as well as support for
heterogeneous nodes.

With features mentioned above, Trino is able to serve memory-intensive queries
significantly better and improve cluster resource utilization.

## Query Optimization

The new execution paradigm makes a lot of query optimizations possible,
including but not limited to:

* Adaptive query planning
* Adaptive exchange spooling
* Skew handling
* Speculative execution

One performance feature that was
[recently implemented](https://trino.io/docs/current/release/release-392.html)
is integrating the existing
[dynamic filtering and dynamic partition pruning](https://trino.io/episodes/11.html)
features with the iterative task execution paradigm.

This is a space full of innovations, and we are just getting started.

# Conclusion

Project Tardigrade brought a new execution paradigm into Trino, which provides
first-class support for batch processing. Featuring fault-tolerance and flexible
scheduling, it greatly improves Trino’s support for long-running and
memory-intensive queries. To learn how we evaluated performance, you can find
[our benchmark results on TPC-H data](https://www.starburst.io/blog/a-better-solution-for-managing-and-maintaining-data-pipelines-now-in-public-preview/).

We are excited for the Trino community to try it out. We provide a one-click
option for enabling it out using a a [fully managed Trino (Starburst Galaxy)](https://www.starburst.io/platform/starburst-galaxy/),
or you can [try out the tutorial using open source Trino](https://github.com/bitsondatadev/trino-getting-started/tree/main/kubernetes/tardigrade-eks).
Please reach out to us on [Trino Slack](https://trino.io/slack.html) in the 
`#project-tardigrade` channel for further discussions or questions.