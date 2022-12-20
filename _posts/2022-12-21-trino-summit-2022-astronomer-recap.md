---
layout: post
title: "Using Trino with Apache Airflow for (almost) all your data problems"
author: "Philippe Gagnon, Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/astronomer.jpg
---

As we close in on the final talks from [Trino Summit 2022]({% post_url 
2022-11-21-trino-summit-2022-recap %}), this next talk dives into how to set up
Trino for batch processing. Trino has historically been well-known for
facilitating fast adhoc analytics queries as opposed to long-running, resource
intensive batch/ETL queries. This is due to the fact that Trino kills queries
that run out of resources in order to prioritize faster query execution. Earlier
this year, Trino added features to better support batch queries with a new 
[fault-tolerant execution mode](https://trino.io/blog/2022/05/05/tardigrade-launch.html).
This mode backs up intermediate data during execution time, allowing Trino to
restart individual query tasks on failure rather than a query stage or the query
itself.

Batch queries don't typically involve human intervention and run asynchronously.
These tasks may depend on each other and have a complex workflow. This talk
describes how to orchestrate this complexity using Airflow's new Trino
integration to run Trino batch queries to solve (almost) all your data problems.

<!--more-->

{% youtube xKDN7RUJ5i4 %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@Astronomer.pdf">
  Check out the slides!
</a>

## Recap

In this talk, we're going to hear from Philippe, a Trino contributor and
Solutions Architect at Astronomer, the company building a SaaS product around
Apache Airflow. Philippe describes a fictional trading scenario that initially
follows a traditional warehousing approach to storing data. This architecture
has data sources that are queried and submitted as raw data into a centralized
warehouse. Within the warehouse itself, the raw data is transformed into data
ready to be consumed.

This model enforces centralization, in which one team runs the platform and
builds the integration between producers and consumers. This team focuses on the
aspects of the data platform which further separates them from the business use
case. As source databases evolve, the central data team must keep up with these
changes. As the data consumers that rely on the data infrastructure grow, this
team commonly becomes a bottleneck.

Trino allows you to move the queries as close as possible to the federated data
sources, removing the labor-intensive process of moving data into stages
before ingesting it into a central warehouse. This doesn't mean that data
movement is no longer a necessity, but the necessity shifts from an availability
concern to a performance and scalability concern. 

Without investing into more resources, your data professionals are able to work
closely with producers and stakeholders with a shared understanding of the
domain. This increases data literacy and data availability throughout your
organization.

Trino is not only for fast adhoc analytics with a human in the loop, but now 
provides a fault-tolerant execution mode that enables it to run resource
intensive batch jobs. This, paired with the federation capabilities, make Trino
able to ingest any data that can be represented in a tabular format. Users can
implement user-defined functions and run transformations using SQL without
involving intermediate systems.

To run Trino batch queries at scale requires building complex interdependencies
between different tasks and often needs monitoring if there are any failures
that occur. This configuration also demands reactive automation to handle the
failing instances. Apache Airflow is an open-source platform for developing,
scheduling, and monitoring batch-oriented workflows on systems like Trino,
perfectly complementing the challenges of handling these intensive queries at 
scale.

Even before introducing fault-tolerant execution mode, [Trino was already being
used to run batch queries at scale](https://engineering.salesforce.com/how-to-etl-at-petabyte-scale-with-trino-5fe8ac134e36/).
In these scenarios, Trino and a tool like Airflow already work well together
because these jobs will take time and likely nobody wants to wait around to run
the pipeline components in sequence. The reason why fault-tolerant execution
mode brings the Trino and Airflow combination to the forefront, is due to the
anticipation of Trino being adopted as a batch query engine tool as the learning
curve to run ETL jobs on Trino becomes as trivial as other tools in the space.

Philippe dives into building out basic Airflow jobs to run over Trino and
introduces the concept of a directed acyclic graph (DAG). He then dives into
multiple useful features that help break down large jobs into manageable tasks,
and jobs that can adjust the schedule based on runtime execution. Sharded job 
creation splits large batch jobs into smaller tasks that can easily be retried.
Dynamic task mapping splits jobs into smaller tasks based on data observed at
runtime. Finally, a new features called data aware scheduling can schedule tasks
based on interdependencies between datasets.

To get started with Trino in Apache Airflow, check out the
[Airflow Trino provider documentation](https://airflow.apache.org/docs/apache-airflow-providers-trino/stable/index.html).

## Share this session

If you thought this talk was interesting, please consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome, 
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/astronomer-social.png"/>