---
layout: post
title:  "Cinco de Trino recap: Learn how to build an efficient data lake"
author: Brian Olsen, Brian Zhan
excerpt_separator: <!--more-->
---

When Trino (formerly PrestoSQL) arrived on the scene almost 10 years ago, it
immediately became known as the much faster alternative to the data warehouse
of big data, Apache Hive. The use cases that you, as the community, have built
had far exceeded anything we had imagined in complexity. Together we’ve made 
Trino not only the fastest way to interactively query large data sets, but also
a convenient way to run federated queries across data sources to make moving all
the data optional.

At Cinco de Trino, we came full circle back to the next iteration of analytics 
architecture with the data lake.  This conference offers advice from industry 
thought leaders about how to use best lakehouse tools with Trino to manage that 
data complexity. Hear from industry thought leaders like Martin Traverso 
(Trino), Dain Sundstrom (Trino), James Campbell (Great Expectations), Jeremy 
Cohen (DBT Labs), Ryan Blue (Iceberg), Denny Lee (Delta Lake), Vinoth Chandar 
(Hudi). You can watch the talks on-demand on the 
[Cinco de Trino playlist](https://www.youtube.com/playlist?list=PLFnr63che7wYDHjUsmp43THLmAlqPDHlM). 

In this post, I’d like to cover the key items from each talk you won’t want to 
miss.

<!--more-->

### Starburst Galaxy lab

Starburst Galaxy enables you to get Trino up and running rather than spending
your time focusing on the setup, scaling, and maintaining the infrastructure.
Trino co-creator, Dain Sundstrom, walks you through a fun-filled lab that
demonstrates how to use Trino as a service solution, Starburst Galaxy, to
generate [database rankings](https://db-engines.com/en/ranking) by ingesting,
cleaning, and analyzing Twitter and Stack Overflow data.

<iframe width="720" height="405" src="https://www.youtube.com/embed/WQNqqkBd_Jo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

### Project Tardigrade
If you have one takeaway from the conference, let it be this: there’s a new way
in town to get 60% cost savings on your Trino deployment. Cory Darby walks
through how utilizing the fault-tolerant execution architecture has enabled
BlueCat to auto-scale their Trino clusters, and run over spot instances, which 
yielded massive cost savings. Zebing Lin goes through how this happens behind
the scenes, and how you can run resource-intensive ETL jobs using failure 
recovery delivered by the team behind Project Tardigrade. 

<iframe width="720" height="405" src="https://www.youtube.com/embed/MYBoeB_lQmo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

<a class="btn btn-pink btn-md waves-effect waves-light" href="https://trino.io/blog/2022/05/05/tardigrade-launch.html">Learn more in the Project Tardigrade blog >></a>

<a class="btn btn-pink btn-md waves-effect waves-light" href="https://github.com/bitsondatadev/trino-getting-started/tree/main/kubernetes/tardigrade-eks">Try Project Tardigrade Yourself >></a>

### Trino as a data lakehouse

Trino co-creator, Martin Traverso, covers where Trino fits into the data lake 
and brings you a sneak peak of the future of a Trino. Polymorphic Table 
Functions, adaptive query planning, are some of the many exciting features 
Martin walks us through.

<iframe width="720" height="405" src="https://www.youtube.com/embed/gwV3smFiGEg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

### Engineering data reliability with Great Expectations

Let’s be honest: when we claim to have run “tests” for our data pipelines, we 
usually mean we checked that `input !=NULL`, or that the dashboard isn’t broken. 
James Campbell showcases the Great Expectations connector for Trino. The
Great Expectations connector is officially launched as the new way to write
expectations (data quality checks) for your code.

What excites us the most? 

1. The ability to take advantage of far more sophisticated data quality tests
than what any of us would write.
2. Having a really awesome UI to manage expectations.
3. The data source view that makes it easy to dynamically test your custom
data quality checks against backends.

<iframe width="720" height="405" src="https://www.youtube.com/embed/9HE6LawCHP8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

### Bring your data into your data lake with Airbyte

The first step of doing any analytics is bringing your data into the data lake.
Ingestion engines are a gamechanger for centralizing your data in the data lake.
Up until recently, there were no open software to choose from in this category.
In just 10 minutes, Abhi Vaidyanatha takes us through the journey of taking in 
data from various places into your choice of data lake.

<iframe width="720" height="405" src="https://www.youtube.com/embed/3E0jb4d2p0U" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

<a class="btn btn-pink btn-md waves-effect waves-light" href="https://abhi-vaidyanatha.medium.com/an-opinionated-guide-to-consolidating-your-data-b09386b2b9b5">Read Abhi’s article about Airbyte + Trino >></a>

### Transforming your data with dbt
Ever had 300 lines of SQL in front of you, and wasted lots of time sifting 
through the code to find which part of the code to edit to check for duplicate 
customers?

Imagine having to update decimal precision used frequently throughout that SQL
statement? What we <3 the most about DBT is that data engineering becomes much 
more like software engineering, where you code in a much more modular way. Along
the way, you get many benefits: the one we love the most? Data lineage graph and
automatic documentation. That’s stuff we always say is important, but never do.

Even for dbt experts, there’s something new to learn. Jeremy Cohen goes through
new capabilities Trino brings to dbt, while showcasing cool features like
macros: a flexible alternative to SQL defined functions.

<iframe width="720" height="405" src="https://www.youtube.com/embed/UYS75sjTziU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

<a class="btn btn-pink btn-md waves-effect waves-light" href="https://github.com/dbt-labs/trino-dbt-tpch-demo">Check out Jeremy's demo repo >></a>

### Touch, talk, and see your data with Tableau
Tableau is our favorite data visualization tool, and in this session, Vlad 
Usatin of Tableau shares how to use Tableau to directly visualize your Trino 
data.

<iframe width="720" height="405" src="https://www.youtube.com/embed/b6kKqNIMvuM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

## Choosing the best data lakehouse format for you

Ever wonder about all the hype with the new table formats? Why is everyone 
choosing Iceberg, Delta Lake, Hudi, over Hive? The founders of each of these 
modern table formats showcase each of these table formats and let you be the
judge of which format makes more sense to your architecture. Below are the 
highlights:

### Iceberg

Ryan Blue dives into important elements of your data lakehouse architecture that
affect daily operations and slow down developer efficiency. He then covers how
Iceberg is the solution he realized to solve those issues.

The two special elements of Iceberg is that it intentionally breaks 
compatibility with the Hive format to bring you features like same table 
partition and schema evolution. I’m the surface this may seem trivial as we’ve 
conditioned our minds to accepting the limitations of hive-like formats.

The second special element is that Iceberg also builds a community-driven 
specification that enables anyone to build out the same calls to use Iceberg 
library.

<iframe width="720" height="405" src="https://www.youtube.com/embed/1oXmBbB77ak" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

### Delta Lake
    
90% of the time that our Trino data pipelines break, it was because someone 
committed a bad upstream change. With Delta Lake time travel (coming soon!), you
won’t need to spend a whole day pinpointing that bad change: just travel back in
time and identify which change that was. Denny Lee gives us a compelling 
argument for why users desire ACID guarantees in their data lakehouse and how
Delta Lake solves for that.

Similar to Iceberg, Delta lake offers optimistic concurrency, which allows there
to be multiple writers to the same Delta Lake table while maintaining ACID
constrains on the data.

<iframe width="720" height="405" src="https://www.youtube.com/embed/TB9Dxv71LxQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

### Hudi [Coming Soon to Trino]
    
The coolest part of the talk? Open up a world of new possibilities with near 
real-time analytics in Trino with Hudi. With Hudi, you get to serve real-time 
production systems, debug live issues, and more.

Vinoth Chandar showcasing the compelling use cases that drove innovation around
Hudi at Uber. He then covers how he views the architecture of data lakes and
lakehouses are starting to merge and the implications this has on the open 
versus proprietary architectures.

<iframe width="720" height="405" src="https://www.youtube.com/embed/r-fF9uqzUdE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 

Thank you to all who attended or viewed, we hope to see you again at our
upcoming events later this year. Continue the conversation in our 
[Trino Slack](https://join.slack.com/t/trinodb/shared_invite/zt-18acr4bvr-0DtaCwiLOrv1zetGnV_w~w).