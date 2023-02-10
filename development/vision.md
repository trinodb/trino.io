---
layout: default
menu_id: development
title: Vision and philosophy
pretitle: Development
show_hero: true
---


<div class="container container__development">

  <div class="row spacer-60">
  <div class="col-md-12">
<div markdown="1" class="leftcol widecol">

## Project values

Correct
: Trino is used for critical decisions (e.g., financial results for public
  markets), and results must always be correct.

Secure
: Trino is a gateway to sensitive information, and must protect that
  information.

Long Term
: We expect that Trino will be used for at least the next 20 years.  We build
  for the long term.

Standards-based
: These can be formal standards like ANSI SQL, JDBC or ODBC, or implicit
  conventions of industry standard databases. This makes it easier for users and
  integrators, because their existing skills transfer.

Just works
: Simple to get started.  Trino should just work out of the box and provide good
  performance with minimal setup. Trino is a large complex system, so
  simplification makes everything better.

Supported
: Everything that ships with Trino is supported.  This means that features that
  cannot be tested and supported are not added, e.g., PowerPC support is only
  being added now that test hardware is available.

Real world uses
: Trino is designed and tuned for real world workloads over synthetic
  benchmarks.

Commercially friendly
: We encourage enterprises to use Trino for their analytics needs, and we
  encourage vendors to base products on Trino.  We appreciate contributions
  back, but do not require them.

## What Trino is, and is not

A server
: Trino is a standalone server, and only provides libraries for external
  applications to connect to Trino (e.g., JDBC, Python, etc).  Specifically, the
  internal details such as the parser, planner, analyzer, optimizer, etc., are
  not public APIs, and are not supported as libraries.

For analytics
: Trino is designed to perform queries over large segments of data, and is not
  designed for point reads and updates of single rows of data (i.e. OLAP not
  OLTP).

Big analytics
: Trino is designed to process queries that are large with respect to the
  resources available and quality of service.  This includes traditional large
  long running batch workloads, but also includes workloads that must be done
  quickly or with limited resources.

Distributed system
: Trino is designed for computations across many networked computers. It is not
  designed for single computer installations. If your analytics can be executed
  on a single computer, there are many other excellent solutions available.

Trusted
: Trino performs authentication and authorization of requests, and therefore is
  assumed to be a trusted environment.

## Development philosophy

Opinionated software
: There are many ways to develop software; this is the way that works for this
  specific project.

Guidelines, not rules
: We believe in having good programmers, who make high quality, thoughtful,
  decisions, not those that just follow rules, because rules need to be broken
  from time to time.

Readability
: Our code is written for the readability of the next person. This takes longer,
  but eases maintenance and improvements over the long term.

High quality
: We have a high bar for changes, and carefully review each proposed change. The
  change process is optimized to reduce the burden on end-users, admins, and
  future maintainers, and not the productivity of the developer proposing the
  change.

Meticulous
: System-wide changes are carefully considered.  End user visible changes such
  as functions, language changes, connectors, etc., are carefully selected to
  provide a consistent user experience over the long term.  Library dependencies
  are carefully chosen based on quality, reliability, and impact on other
  dependencies. System wide abstractions are carefully designed to ease the
  development of the entire system.  Expect any change of this type to be
  discussed and considered at length.

Java software
: Trino is written in Java, and takes advantage of modern Java features.
  Standard Java build tools, libraries and development environments are used to
  ease the on-boarding of developers.

Complexity balance
: There is a careful balance between the value a feature provides and the
  complexity introduced to the system.  Similarly, the complexity of performance
  improvements must be justified by the real world impact.  From the opposite
  side, real word requirements often necessitate complexity.

Multiple use cases
: Trino is designed for multiple use cases. There are installations that
  exclusively run multi-hour batch jobs, and others that run sub-second queries.
  Some installations must be able to share resources between interactive low
  latency queries and long running background queries. Features cannot break one
  use case to better another case; all cases must be well supported in one
  codebase.

Adaptation over configuration
: As a complex multi-tenant query engine that executes arbitrary user defined
  computation, Trino must be adaptive not only to different query
  characteristics, but also combinations of characteristics. Without
  adaptiveness, it would be necessary to narrowly partition workloads and tune
  configuration for each workload independently. That approach does not scale to
  the wide variety of query shapes seen in production.

</div>
</div>
</div></div>
