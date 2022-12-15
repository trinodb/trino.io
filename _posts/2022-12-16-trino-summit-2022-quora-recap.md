---
layout: post
title: "Trino at Quora: Speed, cost, reliability challenges, and tips"
author: "Yifan Pan, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/quora.jpg
---

As we near the end of the [Trino Summit 2022 recap series]({% post_url
2022-11-21-trino-summit-2022-recap %}), it's time to take a stop at Quora. At
Quora, being an engineer responsible for maintaining Trino comes with its fair
share of challenges. With concerns about cost, performance, and reliability,
Quora has taken several creative steps to ensure that they get the most out of
Trino. Other Trino users may be able to learn a few neat tips and tricks to
do the same by tuning in.

<!--more-->

{% youtube Q03DzL_fm-I %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@Quora.pdf">
  Check out the slides!
</a>

## Recap

Trino at Quora is used in the big ways that we're all familiar with. It receives
queries from a variety of clients and services, then executes those queries
on an S3 data lake and Hive metastore to return results at high speeds. With a
wide variety of clients, Quora gets the most out of Trino, using it for ad-hoc
analysis, but also for ETL, backfill jobs, A/B testing, and time series queries.
But as with any large system being used for so many things, this isn't without a
few challenges.

The first challenge is a universal one - how can Quora keep the costs of running
Trino to a minimum? One of the biggest strategies was to migrate to AWS Graviton
instances to run Trino clusters, as they have proven to be more cost-efficient
than other AMD and Intel-based EC2 instances at Quora. Graviton does have lower 
availability, though, so they sometimes must be complemented with some AMD/Intel
instances in order to avoid any downtime. Auto-scaling also led to great cost
savings, as the workloads varied based on time of day. By checking usage and
anticipating it by ramping up the number of machines during the busy workday and
ramping it back down when fewer jobs are in progress, Quora was able to minimize
idle machines and cut back on unnecessary spending. Finally, and perhaps most
obviously, the team at Quora worked to make ETL queries more efficient. By using
partitions effectively and creating a tool to detect inefficient queries
scanning too many partition keys, the result is efficient queries that take less
time and use fewer resources, saving on cost.

Up next - how could Quora maximize Trino's performance? With data analysts
expecting quick runtimes and occasionally running into problems, fine-tuning
Trino to run as well as it possibly can isn't always an easy task. One
particular major issue they found at Quora was that some worker nodes which ran
for 24 hours or more straight would utilize less CPU and run slow, bogging
things down. The fix? Gracefully restart worker nodes that run for over a day,
and implement a detector to flag and restart any nodes which showed signs of
behaving slowly.

The final big concern at Quora is reliability, as users expect Trino to be up
and running whenever they need it. In one instance, they found that overwriting
a specific configuration option caused a cluster to crash repeatedly and
slow down to a crawl. The issue was that they'd steadily been bumping the value
of the `query.min-expire-age` configuration property up and up and up from the
default value of 15 minutes, until eventually, unexpired query history was using
up too much memory and causing the cluster to falter. Lowering the value back
down to something more advisable saved the day in that situation. But wanting to
avoid similar situations from happening again, Quora built extensive monitoring
tools to track the health of their Trino clusters. They ensure that even when
user error does cause problems, those problems can be flagged and send out
alerts, bringing the data engineering team to the rescue.

## Share this session

If you thought this talk was interesting, please consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/quora-social.jpg"/>