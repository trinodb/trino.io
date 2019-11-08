---
layout: page
menu_id: development
title: Development - Vision and Philosophy
---

<div markdown="1" class="leftcol widecol">

## Project Values

Correct
: Presto is used for critical decisions (e.g., financial results for public markets), and results 
  must always be correct.

Secure
: Presto is a gateway to sensitive information, and must protect that information.

Long Term
: We expect that Presto will be used for at least the next 20 years.  We build for the long term.

Standards-Based
: These can be formal standards like ANSI SQL, JDBC or ODBC, or implicit conventions of industry 
  standard databases. This makes it easier for users and integrators, because their existing 
  skills transfer.

Just Works
: Simple to get started.  Presto should just work out of the box and provide good performance with
  minimal setup. Presto is a large complex system, so simplification makes everything better.

Supported
: Everything that ships with Presto is supported.  This means that features that cannot be tested 
  and supported are not added, e.g., PowerPC support is only being added now that test hardware
  is available.

Real World Uses
: Presto is designed and tuned for real world workloads over synthetic benchmarks.

Commercially Friendly
: We encourage enterprises to use Presto for their analytics needs, and we encourage vendors to
  base products on Presto.  We appreciate contributions back, but do not require them.

## What Presto Is and Is Not

A Server
: Presto is a standalone server, and only provides libraries for external applications to connect
  to Presto (e.g., JDBC, Python, etc).  Specifically, the internal details such as the parser, 
  planner, analyzer, optimizer, etc., are not public APIs, and are not supported as libraries.

For Analytics
: Presto is designed to perform queries over large segments of data, and is not designed for point
  reads and updates of single rows of data (i.e. OLAP not OLTP).

Big Analytics
: Presto is designed to process queries that are large with respect to the resources available and
  quality of service.  This includes traditional large long running batch workloads, but also 
  includes workloads that must be done quickly or with limited resources.

Distributed System
: Presto is designed for computations across many networked computers.  It is not designed for 
  single computer installations. If your analytics can be executed on a single computer, there 
  are many other excellent solutions available.

Trusted
: Presto performs authentication and authorization of requests, and therefore is assumed to be 
  a trusted environment.

## Development Philosophy

Opinionated Software
: There are many ways to develop software; this is the way that works for this specific project.

Guidelines, Not Rules
: We believe in having good programmers, who make high quality, thoughtful, decisions, not those 
  that just follow rules, because rules need to be broken from time to time.

Readability
: Our code is written for the readability of the next person. This takes longer, but eases 
  maintenance and improvements over the long term.

High Quality
: We have a high bar for changes, and carefully review each proposed change.  The change process
  is optimized to reduce the burden on end-users, admins, and future maintainers, and not the 
  productivity of the developer proposing the change.

Meticulous
: System-wide changes are carefully considered.  End user visible changes such as functions, 
  language changes, connectors, etc., are carefully selected to provide a consistent user 
  experience over the long term.  Library dependencies are carefully chosen based on quality, 
  reliability, and impact on other dependencies. System wide abstractions are carefully designed 
  to ease the development of the entire system.  Expect any change of this type to be discussed 
  and considered at length.

Java Software
: Presto is written in Java, and takes advantage of modern Java features.  Standard Java build 
  tools, libraries and development environments are used to ease the on-boarding of developers.

Complexity Balance
: There is a careful balance between the value a feature provides and the complexity introduced 
  to the system.  Similarly, the complexity of performance improvements must be justified by the 
  real world impact.  From the opposite side, real word requirements often necessitate complexity.

Multiple Use Cases
: Presto is designed for multiple use cases.  There are installations that exclusively run 
  multi-hour batch jobs, and others that run sub-second queries.  Some installations must be able 
  to share resources between interactive low latency queries and long running background queries. 
  Features cannot break one use case to better another case; all cases must be well supported in 
  one codebase.

Adaptation Over Configuration
: As a complex multi-tenant query engine that executes arbitrary user defined computation, Presto 
  must be adaptive not only to different query characteristics, but also combinations of 
  characteristics. Without adaptiveness, it would be necessary to narrowly partition workloads and 
  tune configuration for each workload independently. That approach does not scale to the wide 
  variety of query shapes seen in production.

</div>
