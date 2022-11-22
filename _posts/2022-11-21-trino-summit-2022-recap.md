---
layout: post
title: "Trino Summit 2022 recap"
author: "Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/stage.jpg
---

Trino Summit 2022 was in a word, invigorating. I’m still coming off the high 
from the amount of energy I gained from being at this summit, meeting many of
you face-to-face for the first time. Most surprisingly, I learned that Trino
contributor James Petty from AWS was actually not famous painter
[Bob Ross](https://en.wikipedia.org/wiki/Bob_Ross).

<!--more-->

<img src="/assets/blog/trino-summit-2022/james-petty.png"/>

If you’ve ever planned a conference, you know that there are a lot of details to
iron out, and you can be left exhausted by the end. After this year’s Trino
Summit though, rather than being worn out, I felt like it ended too quickly and
I simply wanted more time to chat with everyone. A single day was simply not
enough, and now all I can think about is the next summit. We not only got to
hear an incredible lineup of talks and discussions from first-time Trino Summit
speakers like Apple, Shopify, and Lyft, but also had many engaging discussions
outside the auditorium.

<img src="/assets/blog/trino-summit-2022/swag.jpg"/>
<img src="/assets/blog/trino-summit-2022/authors.jpg"/>
<img src="/assets/blog/trino-summit-2022/talking-1.jpg"/>
<img src="/assets/blog/trino-summit-2022/talking-2.jpg"/>

There were cross-community discussions between Delta Lake, Airflow, and Alluxio
about how to turbo-charge Trino integrations with these communities. There were
many companies talking about best practices and gotchas while migrating from
Hive to Iceberg or Delta Lake. Others wanted to learn how to use fault-tolerant
execution. I spoke with managers of companies like LinkedIn and Bloomberg who
wanted to help develop their engineers to get more involved with contributing to
Trino. We all finally got to see the faces of people we had been talking to for
the past two to three years for the first time. People were getting their free
copies of Trino: The Definitive Guide signed by Manfred, Matt, and Martin and
brought home other swag. After a long day of talks, we wrapped Trino Summit up
with two happy hours on the roof of the Commonwealth club watching the sunset
over the San Francisco bay bridge.

<img src="/assets/blog/trino-summit-2022/speech.jpg"/>
<img src="/assets/blog/trino-summit-2022/happy-hour.jpg"/>

## Session summaries

I would like to quickly summarize a few short takeaways I had from each talk at
the summit. I highly recommend you watch the full videos on the Trino YouTube
which are linked in the titles:

[<i class="fab fa-youtube" style="color: red;"/> Keynote: State of Trino](https://www.youtube.com/watch?v=mUq_h3oArp4)
([Read more]({% post_url 2022-11-22-trino-summit-2022-state-of-trino-keynote-recap %}))
* Trino co-creator, Martin, covers recently developed features, community 
  statistics, and discusses roadmap features like Project Hummingbird.
* Dain and David join Martin on the stage to answer audience questions.
  
  <a href="https://www.youtube.com/watch?v=mUq_h3oArp4"><img width="40%" src="/assets/blog/trino-summit-2022/keynote.jpg"/></a>

[<i class="fab fa-youtube" style="color: red;"/> Trino at Apple](https://www.youtube.com/watch?v=3afcRK6Yvio)
* Apple has an in-house k8s operator to manage Trino cluster lifecycles, and an
  orchestrator to provision and simplify cluster creation and management.
* Apple has a heavy focus on Apache Iceberg as their table format and has
  contributed a significant amount of PRs to improve interoperability between
  Trino and Spark and increased coverage of Iceberg APIs.

  <a href="https://www.youtube.com/watch?v=3afcRK6Yvio"><img width="40%" src="/assets/blog/trino-summit-2022/apple.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Enterprise-ready Trino at Bloomberg: One Giant Leap Toward Data Mesh!](https://www.youtube.com/watch?v=ePr-iVQ5ri4)
* Bloomberg uses Trino to centralize access to their massive amounts of catalogs
  under many different departments.
* To offer Trino-as-a-Service for varying workloads, they use a Trino Load
  Balancer which forks from the popular presto-gateway project at Lyft. This
  adds new functionality and Bloomberg wants to open source this work to the
  community as a more generalized solution than the gateway project.

  <a href="https://www.youtube.com/watch?v=ePr-iVQ5ri4"><img width="40%" src="/assets/blog/trino-summit-2022/bloomberg.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Optimizing Trino using spot instances](https://www.youtube.com/watch?v=vz9reBUgQTE)
* In an attempt to minimize costs, Zillow is measuring the efficacy of running
  Trino ETL jobs on spot instances.
* This currently runs the risk of retries for failure but future work will look
  at utilizing the new fault-tolerant execution method to mitigate retries in
  the event of failure.

  <a href="https://www.youtube.com/watch?v=vz9reBUgQTE"><img width="40%" src="/assets/blog/trino-summit-2022/zillow.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Leveraging Trino to Power Data at Goldman Sachs](https://www.youtube.com/watch?v=g9fLA3tFG-Q)
* Goldman Sachs uses Trino to power their data quality service, taking advantage
  of the fact that Trino centralizes all visibility across their platform.
  
[<i class="fab fa-youtube" style="color: red;"/> Elevating Data Fabric to Data Mesh: Solving Data Needs in Hybrid Datalakes](https://www.youtube.com/watch?v=sSWBi7bBotQ)
* Comcast takes us through their Trino architecture journey by providing the
  history of their Data Fabric service, and now discusses the data governance
  and culture changes required to realize a Data Mesh with Trino.

  <a href="https://www.youtube.com/watch?v=sSWBi7bBotQ"><img width="40%" src="/assets/blog/trino-summit-2022/comcast.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Rewriting History: Migrating petabytes of data to Apache Iceberg using Trino](https://www.youtube.com/watch?v=nJBBw-xnLU8)
* Shopify has recently migrates of its workloads to Trino. One of the first
  hurdles was dealing with many issues in the Hive table format, so they quickly
  upgraded to the Iceberg table format.
* They initially encountered numerous issued, but experienced incredibly fast
  turnaround of fixes from the Trino project that resolved their issues during
  the migration.
* There’s also a benchmark of how updating to a columnar format and Iceberg
  table format drastically improves the results.

  <a href="https://www.youtube.com/watch?v=nJBBw-xnLU8"><img width="40%" src="/assets/blog/trino-summit-2022/shopify.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Trino for Large Scale ETL at Lyft](https://www.youtube.com/watch?v=FL3c1Ue7YWM)
* Lyft is using Trino to perform ETL jobs scanning 10PB of data per day, and
  writing 100TB per day. They are not using fault-tolerant execution.
* In the last year, Lyft cut their number of Trino nodes in half, while
  increasing the volume of their workloads due to recent improvements in Trino
  and upgrades in Java versions.
* Keeping up with the rapid release cycle of Trino was a challenge and Lyft
  showcases their regression testing using their query replay framework.

  <a href="https://www.youtube.com/watch?v=FL3c1Ue7YWM"><img width="40%" src="/assets/blog/trino-summit-2022/lyft.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Federating them all on Starburst Galaxy](https://www.youtube.com/watch?v=Zfmxwu0m98k)
* Running and scaling Trino is difficult. Starburst showcases Starburst Galaxy,
  a SaaS data platform built around the Trino query engine.
* This demoes running federated queries over Pokémon data scattered across
  MongoDB and Iceberg tables.

  <a href="https://www.youtube.com/watch?v=Zfmxwu0m98k"><img width="40%" src="/assets/blog/trino-summit-2022/starburst.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Trino at Quora: Speed, Cost, Reliability Challenges and Tips](https://www.youtube.com/watch?v=Q03DzL_fm-I)
* Quora uses a large number of Trino clusters for ad-hoc, ETL, time series, A/B
  testing, and backfill data.
* Quora faced some initially high costs on Trino due to inefficient uses of
  resources.
* To address this they migrated to use Graviton instances, implemented
  autoscaling, and optimized query efficiency.

  <a href="https://www.youtube.com/watch?v=Q03DzL_fm-I"><img width="40%" src="/assets/blog/trino-summit-2022/quora.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Journey to Iceberg with SK Telecom](https://www.youtube.com/watch?v=V9_aPLXATh8)
* The speakers travelled all the way from South Korea to join us in person.
* SK Telecom had a multitude of performance issues that all stemmed from the
  lack of flexibility in the Hive model and metastore.
* They migrated to Iceberg to address performance issues and had added benefits
  of Iceberg’s table format to improve developer workflow.
* Housekeeping operations like optimize were already addressed by the Iceberg
  community and quickly added to Trino.
* This reduced query processing time by 80%.

  <a href="https://www.youtube.com/watch?v=V9_aPLXATh8"><img width="40%" src="/assets/blog/trino-summit-2022/sk-telecom.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> Using Trino with Apache Airflow for (almost) all your data problems](https://www.youtube.com/watch?v=xKDN7RUJ5i4)
* Airflow is a highly functional and well-adopted workflow management platform
  to schedule jobs on your data platform.
* The Trino integration for Airflow recently landed and this coincided with the
  GA arrival of fault-tolerance execution mode in Trino.

  <a href="https://www.youtube.com/watch?v=xKDN7RUJ5i4"><img width="40%" src="/assets/blog/trino-summit-2022/astronomer.jpg"/></a>
  
[<i class="fab fa-youtube" style="color: red;"/> How we use Trino to analyze our Product-led Growth (PLG) user activation funnel](https://www.youtube.com/watch?v=MCB_1furnAo)
* Upsolver solves a lot of common data problems on their platform.
* One such problem is measuring activation rates in a product-led growthteam. This requires taking action on many sources of data.
* Trino makes a natural fit to address the issues of joining this data together.

  <a href="https://www.youtube.com/watch?v=MCB_1furnAo"><img width="40%" src="/assets/blog/trino-summit-2022/upsolver.jpg"/></a>

## Federate 'em all

After a whole day of throwing Trino balls out to the crowd, we got to see a
nice metaphor for federated data by throwing them all in the air and yelling,
"Federate 'em all!"

<img src="/assets/blog/trino-summit-2022/balls.jpg"/>

## Trino Contributor Congregation

The day after the summit, we invited a relatively small group of our
contributors to meet for the inaugural Trino Contributor Congregation (TCC).
This gathered many of our long-time and heavy Trino contributors. We had folks
from companies like Starburst, AWS, Apple, Bloomberg, Lyft, Comcast, LinkedIn,
Treasure Data, and others. Let’s dive into some of the topics we discussed.

<img src="/assets/blog/trino-summit-2022/contributor-congregation.jpg"/>

We discussed feature proposals like:

* The Trino loadbalancer which is an adaption of the popular gateway project from Lyft.
* A Ranger plugin to be maintained by the Trino community rather than rely on the Ranger project.
* A Snowflake connector that was traditionally held back by the lack of infrastructure.

We discussed the need for better shared testing datasets outside of the TPC-H
and TPC-DS that are more representative of real workloads that many are using.

We discussed the need for a clearer process for contributors to follow to
minimize the time to get features merged and avoid stale PRs. This is being
addressed by the backlog grooming performed by the developer relations team, and
assigning maintainers to own various PRs. While there is never a promise to
merge a PR, improving the turnaround and communication on PRs is crucial to keep
happy contributors and improve the health of the project.

While we were sad that not everyone could make the in-person TCC, we plan to
have virtual TCCs on a more frequent cadence and have the in-person TCCs
alongside larger in-person events. Getting these TCCs right is core to growing
the maintainership and continued success of the Trino project.

We hope all of you who could join us in-person and online enjoyed yourselves. We
all had such a blast! Stay tuned for updates on the next Trino Summit location!


<img src="/assets/blog/trino-summit-2022/bun-bun-bye.jpg"/>