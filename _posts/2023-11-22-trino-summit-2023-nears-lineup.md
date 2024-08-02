---
layout: post
title: "Trino Summit 2023 nears with an awesome lineup"
author: "Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2023/lineup-blog-banner.png
---

As winter nears, the days may be getting shorter, but so is the wait until
Trino Summit 2023! It'll be here before you know it on December 13th and 14th.
We've got a packed speaker lineup full of exciting talks, and we're ready to
share some details with the Trino community today. Read on for a preview of some
talks, and if you're interested in attending, make sure to...

<div class="card-deck spacer-30">
    <a class="btn btn-pink" href="https://www.starburst.io/info/trinosummit2023/?utm_source=trino&utm_medium=website&utm_campaign=NORAM-FY24-Q4-EV-Trino-Summit-2023&utm_content=blog-lineup-announcement">
        Register!
    </a>
</div>
<div class="spacer-30"></div>

<!--more-->

So, who's going to be talking at Trino Summit? Here's a quick rundown of the
talks coming in from various companies.

## Starburst: The mountains Trino climbed in 2023

As always, our keynote will come from Martin Traverso, Trino co-founder and
co-CTO at Starburst. He'll be giving a project update on everything exciting
that's happened in Trino since
[Trino Fest]({% post_url 2023-06-20-trino-fest-2023-recap %}), as well as a
sneak peek at the roadmap for features coming to Trino in 2024. It's one of the
best ways to keep up with the ongoing developments in the Trino community, and
you won't want to miss it.

## Starburst, Bloomberg, and Naver: Many clusters and only one gateway

A second talk, which is a collaboration among Starburst, Bloomberg, and Naver,
will be exploring the new [Trino Gateway](https://github.com/trinodb/trino-gateway),
a proxy and load-balancer that has been in the works for a long while in the
Trino community. There's no more need to worry about noisy neighbors or huge
queries bullying out the quick and small workloads - with multiple clusters and
the Trino Gateway on top, users interact with Trino like normal, but under the
hood, queries get routed to available clusters to ensure that the time it takes
to get your insights are shorter than ever before.

## Airbnb: Trino workload management

Trino is the main interactive compute engine for offline ad-hoc analytics at
Airbnb. Recently, they've redesigned their query workload processing on Trino
clusters, introducing query cost forecasting and workload awareness scheduling
systems. This helps them deliver a more stable and consistent analytics query
service to offline data users at Airbnb, with improved performance and speed.
And they'll be explaining how they did it!

## Pinterest: Journey to achieving 2x efficiency improvement on Trino

Trino usage has been growing at Pinterest each year, which comes with growing
costs and increased demand on the existing Trino clusters. To help reduce costs
and serve their Trino users, the engineering team there has migrated to AWS
Graviton, taken advantage of Trino improvements, consolidated traffic, improved
job scheduling, and worked to optimize their data and metadata formats. The end
result has been a reduction in cost *and* an increase in query throughput.
They'll be sharing the details on the effort it took to make Trino faster and
cheaper at the same time.

## Quora: Adopting Trino's fault-tolerant execution mode

Quora will be covering how they adopted Trino's fault-tolerant execution mode
to run some of their heaviest ETL jobs. They separate Trino queries
from their main data pipelines in two clusters, one running the FTE mode for
memory-intensive and longer jobs and another without it for lighter, general
pipelines. This separation helped achieve better query failure rates, improved
the execution time of long queries due to the more flexible autoscaling in
FTE, and provided an alternative to run queries that would otherwise run out of
memory without scaling up the cluster.

## LinkedIn: Trino upgrades at exabyte scale

LinkedIn has been keeping up with Trino releases at an impressive rate, but
getting to that point has required a lot of time, effort, and work on
streamlining the update process. They'll be discussing the challenges of
breaking changes, applying internal patches, and ensuring that there are no
meaningful performance regressions. They've automated much of this, including
implementing a post-commit integration test suite that ensures nothing has
broken, and creating an automated test framework that can validate the
performance of each new Trino release before it deploys to users.

## EA: Migrating 120 million HMS metadata records without customer impact

Migrating production databases is a scary task no matter who you are. It's
scarier when you're talking about 600+ databases, 35,000+ tables, and over 120
million partitions, all of which you need to migrate while avoiding any customer
impact. EA managed to pull it off with the help of Trino, and they'll be at
Trino Summit to share how they made it work and what they learned along the way.

## SK Telecom: Efficient Kappa architecture with Trino

SK Telecom is bringing us two talks this year, as they've got a lot going on and
some unique Trino stories to share!

The first talk will dive into Kappa architecture and the challenges
involved in getting it to run in real-time at the massive scale SK Telecom
needs. They started with Trino's Kafka connector, but the limitations of that
architecture steered them towards a solution with Flink and Trino's Iceberg
connector, which they'll explain. They'll also be sharing some tips and tricks
for tuning Flink and Iceberg to get the most out of your Trino deployments.

## SK Telecom: Unstructured data analysis using polymorphic table functions in Trino

The second talk will discuss the challenges of dealing with unstructured data.
Pre-processing is essential for analyzing unstructured data, and it's difficult
for ordinary users and analysts to distribute large amounts of unstructured
data. With the power of a custom-built polymorphic table function,
they were able to invoke Python code within Trino to help structure that data
for analysis, solving the problem in a powerful and fascinating way. We'll get
to hear about polymorphic table functions, how they work in Trino, and how
anyone else may be able to leverage them to solve problems.

## Raft: Avoiding pitfalls with query federation in data lakehouses

Raft has partnered with the US Department of Defense to build a data fabric that
is built on top of Delta Lake, Trino, Apache Kafka, and Open Policy Agent (OPA).
This talk will discuss the challenges involved, provide solutions and
considerations for each, and end with a demo of Raft’s data fabric. The talk
will focus on a plugin for Trino, developed by Raft, that uses OPA as a policy
engine to provide fine-grained access control at query time based on a user’s
JWT passed along with the query.

## Treasure Data: Secure exchange SQL

Secure Exchange SQL is a production data clean room service deployed at Treasure
Data, which leverages Trino and differential privacy technology to enable
cross-company data analysis while mitigating the risk of privacy breaches.
In their session, they'll introduce the concept of differential privacy and
discuss the privacy protection methods that need to be implemented during SQL
processing. To minimize changes to Trino's codebase, they employed approaches of
SQL rewriting and validation at the logical plan level. They'll explain these
methods and provide some practical use cases of their data clean room.

## Zomato: Powering data marts through the Trino Iceberg connector

It's a common theme in the Trino community - Zomato recently migrated from a
traditional data warehouse to a Trino-powered data lakehouse in conjunction with
Iceberg. They'll be discussing how this has enabled their analytics to run
better than ever, including periodic updates to their data marts and tackling
the challenges involved in maintaining Iceberg tables.

## Bazaar: Powering Bazaar`s business operations using Trino

Bazaar's talk will discuss how they leverage Trino's capabilities to optimize
data analysis and support data-driven decision-making. The talk specifically
explores including real-time data querying across multiple sources and
performance optimization, illustrating Trino's role in Bazaar's data-centric
strategies. This presentation provides in-depth insights for individuals
well-versed in Trino, shedding light on the platform's transformative impact on
enhancing e-commerce operations.

## Preset: Visualizing Trino with Superset

Preset will be diving into the "last mile" of the modern data stack and
show you how to query and visualize data pulled from Trino with Apache Superset
and/or Preset. Specifically, they'll discuss things like Trino's federated query
support (a common wish for Superset users) and how Superset can support
near-real-time analytics for Trino users. They'll also give a demo of connecting
to Trino, building SQL queries, designing charts and dashboards, and other ways
to gain insight and stay on top of your data.

## VAST: The VAST database catalog

The VAST Database connector for Trino was open-sourced this year! They'll be
discussing the architecture of VAST and the connector, the purpose and major use
cases for it, and demonstrate the workflows surrounding the VAST Database in the
Trino ecosystem.

## And still more to come!

Believe it or not, the great lineup we've gone over here still isn't every talk.
Stay tuned here or on the [Trino Slack]({{site.url}}/slack) to hear about the
other speakers as they're announced. And of course, if you want to catch all
these talks live, engage in chat, and have an opportunity to ask questions, make
sure to [register to attend](https://www.starburst.io/info/trinosummit2023/?utm_source=trino&utm_medium=website&utm_campaign=NORAM-FY24-Q4-EV-Trino-Summit-2023&utm_content=blog-lineup-announcement).