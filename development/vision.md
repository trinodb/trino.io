---
layout: page
menu_id: development
title: Development - Vision and Philosophy
---

<div class="leftcol widecol">
    <h2>Project Values</h2>

    <p>
    <dl>
        <dt>Correct</dt>
        <dd>Presto is used for critical decisions (e.g., financial results for public markets), and results must always be correct.</dd>
        <dt>Secure</dt>
        <dd>Presto is a gateway to sensitive information, and must protect that information.</dd>
        <dt>Long Term</dt>
        <dd>We expect that Presto will be used for at least the next 20 years.  We build for the long term.</dd>
        <dt>Standards Based</dt>
        <dd>These can be formal standards like ANSI SQL, JDBC or ODBC, or implicit conventions of industry standard databases. This makes it easier for users and integrators, because their existing skills transfer.</dd>
        <dt>Just Works</dt>
        <dd>Simple to get started.  Presto should just work out of the box and provide good performance with minimal setup. (Presto is a large complex system, so simplification makes everything better).</dd>
        <dt>Supported</dt>
        <dd>Everything that ships with Presto is supported.  This means that features that cannot be tested and supported will not be added (e.g., PowerPC support is only being added now that test hardware is available).</dd>
        <dt>Real World Uses</dt>
        <dd>Presto is designed and tuned for real world workloads over synthetic benchmarks.</dd>
        <dt>Commercially Friendly</dt>
        <dd>We encourage enterprises to use Presto for their analytics needs, and we encourage vendors to base products on Presto.  We appreciate contributions back, but do not require them.</dd>
    </dl>
    </p>

    <h2>What Presto Is and Is Not</h2>

    <p>
    <dl>
        <dt>A Server</dt>
        <dd>Presto is a standalone server, and only provides libraries for external applications to connect to Presto (e.g., JDBC, Python, etc).  Specifically, the internal details such as the parser, planner, analyzer, optimizer, etc., are not public APIs, and are not supported as libraries.</dd>
        <dt>For Analytics</dt>
        <dd>Presto is designed to perform queries over large segments of data, and is not designed for point reads and updates of single rows of data (i.e. OLAP not OLTP).</dd>
        <dt>Big Analytics</dt>
        <dd>Presto is designed to process queries that are large with respect to the resources available and quality of service.  This includes traditional large long running batch workloads, but also includes workloads that must be done quickly or with limited resources.</dd>
        <dt>Distributed System</dt>
        <dd>Presto is designed for computations across many networked computers.  It is not designed for single computer installations. If your analytics can be executed on a single computer, there are many other excellent solutions available.</dd>
        <dt>Trusted</dt>
        <dd>Presto performs authentication and authorization of requests, and therefore is assumed to be a trusted environment.</dd>
    </dl>
    </p>

    <h2>Development Philosophy</h2>

    <p>
    <dl>
        <dt>Opinionated Software</dt>
        <dd>There are many ways to develop software; this is the way that works for this specific project.</dd>
        <dt>Guidelines, not rules</dt>
        <dd>We believe in having good programmers, who make high quality, thoughtful, decisions, not those that just follow rules, because rules need to be broken from time to time.</dd>
        <dt>Readability</dt>
        <dd>Our code is written for the readability of the next person. This takes longer, but eases maintenance and improvements over the long term.</dd>
        <dt>High Quality</dt>
        <dd>We have a high bar for changes, and carefully review each proposed change.  The change process is optimized to reduce the burden on end-users, admins, and future maintainers, and not the productivity of the developer proposing the change.</dd>
        <dt>Meticulous</dt>
        <dd>System-wide changes are carefully considered.  End user visible changes (e.g., functions, language changes, connectors, etc.) are carefully selected to provide a consistent user experience over the long term.  Library dependencies are carefully chosen based on quality, reliability, and impact on other dependencies. System wide abstractions are carefully designed to ease the development of the entire system.  Expect any change of this type to be discussed and considered at length.</dd>
        <dt>Java Software</dt>
        <dd>Presto is written in Java, and takes advantage of modern Java features.  Standard Java build tools, libraries and development environments are used to ease the on-boarding of developers.</dd>
        <dt>Complexity Balance</dt>
        <dd>There is a careful balance between the value a feature provides and the complexity introduced to the system.  Similarly, the complexity of performance improvements must be justified by the real world impact.  From the opposite side, real word requirements often necessitate complexity.</dd>
        <dt>Multiple Use Cases</dt>
        <dd>Presto is designed for multiple use cases.  There are installations that exclusively run multi-hour batch jobs, and others that run sub-second queries.  Some installations must be able to share resources between interactive low latency queries and long running background queries.  Features cannot break one use case to better another case; all cases must be well supported in one codebase.</dd>
        <dt>Adaptation Over Configuration</dt>
        <dd>As a complex multi-tenant query engine that executes arbitrary user defined computation, Presto must be adaptive not only to different query characteristics, but also combinations of characteristics. Without adaptiveness, it would be necessary to narrowly partition workloads and tune configuration for each workload independently. That approach does not scale to the wide variety of query shapes seen in production.</dd>
    </dl>
    </p>
</div>
