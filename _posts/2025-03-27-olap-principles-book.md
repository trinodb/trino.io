---
layout: post
title: Core Principles and Design Practices of OLAP Engines 
author: Yiteng Xu, Yingju Gao, Manfred Moser
excerpt_separator: <!--more-->
image: /assets/blog/core-principles-olap-book.jpg
---

Yiteng Xu and Yingju Gao are proudly announcing the new book "Core Principle and
Design Practices of OLAP Engines" from China Machine Press. This is great news
for the Trino community, since the book is based on the open source project
Trino, specifically Trino 350. It took more than four years for the two authors
to finish writing. All concepts and details are explained with Trino falvor and
generalized to all OLAP engines. Let us walk throught the chapters and you will
find out the two author dive deep into the source code layer and bring you so
many treasures.

<!--more-->

## Author introduction

[Yiteng (Ivan) Xu](https://github.com/medsmeds): is a data security engineer and
is currently utilizing Trino, Spark, and Calcite for SQL analysis. His work
encompasses various scenarios, including data warehouse metrics, SQL
auto-rewriting, SQL purpose detection, and the development of SQL-based
Purpose-Aware Access Control System.

[Yingju (Gary) Gao](https://github.com/garyelephant) is an Apache Seatunnel PMC
member and the lead of the time series database team. He currently serves as the
technical lead for the observability-engine team, and is responsible for
building the ecosystem for observability data, including metrics, trace, log,
and event data, providing a high-performance, high-throughput data pipeline from
ingestion to consumption, storage, querying, and data warehousing. Additionally,
he oversees metrics stability, multi-tenant access, and user requirement
integration.

Both authors are passionate about sharing their technical knowledge. They have
delved deep into source code and excel in technical writing, breaking down
complex underlying principles into a linear and comprehensible format for
readers. They firmly believe that sharing is a virtue and are committed to
continuing their technical contributions.

So now it is time to get the book, or read on for a walk through of the content:

<div class="card-deck spacer-30">
    <a class="btn btn-pink" target="_blank"
    href="https://product.dangdang.com/11974653727.html">
        Get the book from dangdang.com
    </a>
    <a class="btn btn-pink" target="_blank"
    href="https://item.m.jd.com/product/10136949561522.html">
        Get the book from jd.com
    </a>
</div>

## Walk through

Let's have a look at the different chapters in a high-level walk through.

### Part 1: Background knowledge

**Chapter 1**: Introduce the concept of OLAP (Online Analytical Processing),
provide comparsion among different engines like Trino, Impala, Doris and others.

**Chapter 2**: Provides a comprehensive introduction to the Trino engine,
covering its principles, architecture, enterprise use cases, compilation, and
execution. It also compares Trino with the Presto project and introduces the
SQL statements that are referenced throughout the book.

### Part 2: Core principles

**Chapter 3**: Offers an overview of the distributed SQL query process, serving
as a high-level introduction to the subsequent chapters.

**Chapter 4**: Begins with the generation of query execution plans, including
the transformation of SQL into abstract syntax trees, semantic analysis, and the
creation of initial logical plans. It then delves into the theoretical knowledge
of optimizers and the overall framework of the Trino optimizer.

### Part 3: Classic SQL

**Chapter 5**: Explains the generation and optimization of execution plans for
SQL statements involving only `TableScan`, `Filter`, and `Project` operations,
along with their scheduling and execution processes.

**Chapter 6**: Focuses on SQL statements with `Limit` and `Sort` operations,
detailing the generation and optimization of execution plans, as well as their
scheduling and execution.

**Chapter 7**: Introduces the basic principles of aggregate queries. It then
covers the generation and optimization of execution plans for grouped and
non-grouped aggregate SQL statements, along with their scheduling and execution
processes.

**Chapter 8**: Discusses SQL statements with count distinct and multiple
aggregate operations, explaining the generation and optimization of execution
plans, as well as their scheduling and execution. This includes the
`Scatter-Gather` model and `MarkDistinct` optimization. Finally, a complex SQL
statement is used to tie together the concepts from Chapters 5 to 8.

### Part 4: Data exchange mechanism

**Chapter 9**: Introduces the overall concept of data exchange mechanisms and
how data exchange is incorporated during the query optimization phase via the
`AddExchanges` optimizer, along with the design principles for scheduling and
execution.

**Chapter 10**: Explains how tasks establish connections during the query
scheduling phase and the mechanisms for upstream and downstream data flow during
execution. It also covers the principles of intra-task data exchange, RPC
interaction mechanisms, and analyzes backpressure, Limit semantics, and
out-of-order request handling.

### Part 5: Plugin mechanisms and connectors

**Chapter 11**: Begins with an introduction to Trino's plugin system and SPI
mechanism, including plugin loading and JVM's class loading principles. It then
dissects connectors, covering metadata modules, read modules, pushdown
optimization, and providing in-depth insights into connector design.

**Chapter 12**: Uses the example-http connector to help readers understand
connector design and implements a simple data source using Python's Flask
framework. 

### Part 6: Function principles and development

**Chapter 13**: Provides an overview of Trino's function system, including
function types, lifecycle, and several function development methods. It delves
into the data structures and annotations related to functions and explains the
function registration and parsing process during semantic analysis.

**Chapter 14**: Focuses on how to write a udf in practice. It covers
annotation-based development methods for scalar functions, as well as low-level
development methods using `codeGen` or `methodHandle` APIs. For aggregate
functions, it introduces annotation-based development methods and low-level
methods where developers handle serialization and state on their own.

### Why Trino?

In 2020, one of the authors, Yiteng Xu, encountered a scenario at work where
data needed to be read from two Hive instances, each modified by different
internal teams. The company's infrastructure team attempted a simple solution by
registering virtual tables and using MapReduce for federated queries. However,
this approach proved inadequate for the agile analysis needs of data analysts,
with complex queries taking nearly 12 hours to complete. One mistake per SQL
meant an entire day was wasted.

Later, another team researched and adopted Presto (before Trino became
independent). By adapting the Hive engine at the connector level, they enabled
federated queries across the two Hive instances without data migration or
extensive code changes. Users only needed to be aware of a catalog prefix,
making the process incredibly convenient. The author later had the opportunity
to participate in the project and developed a strong interest in its source
code. The elegance of the open-source project, its plugin design, and the inner
workings of connectors and Airlift framework sparked a deep curiosity, leading
the author on a journey of source code exploration. As the PrestoSQL project was
more active and receptive to developer feedback, the author chose to continue
following the Trino project when it emerged in late 2020.

## Get your copy

Now it is time for you to get your copy of **Core Principles and Design Practices of OLAP Engines**:

<div class="card-deck spacer-30">
    <a class="btn btn-pink" target="_blank"
    href="https://product.dangdang.com/11974653727.html">
        Get the book from dangdang.com
    </a>
    <a class="btn btn-pink" target="_blank"
    href="https://item.m.jd.com/product/10136949561522.html">
        Get the book from jd.com
    </a>
</div>
