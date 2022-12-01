---
layout: post
title: "Trino for large scale ETL at Lyft"
author: "Charles Song, Ritesh Varyani, Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/lyft.jpg
---

Buckle up, for the next [post in the Trino Summit 2022 recap series]({% post_url
2022-11-21-trino-summit-2022-recap %}). In this post, we're covering the talk
given by Lyft engineers, Charles and Ritesh, on how they have not only scaled
Trino as adoption grew, but with less nodes and more effective usage. They
also started moving to utilizing Trino more for ETL rather than just interactive
analytics. Get ready for a smooth ride as Lyft brings you large scale ETL with
Trino.

<!--more-->

{% youtube FL3c1Ue7YWM %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@Lyft.pdf">
  Check out the slides here!
</a>

## Recap

Lyft uses Trino to perform ETL jobs reading 10 petabytes of data per day and
writing 100 terabytes per day. They run 250,000 queries per day, with around
2,000 unique users. This requires approximately 750 EC2 instances scaling up or
down with an autoscaler. Over 90 percent of queries complete within a one to
three minutes. 

In the last year, Lyft cut their number of Trino nodes in half, while increasing
their workloads. This is possible due to recent improvements in Trino and
upgrades in Java versions. Lyft is not using fault-tolerant execution, but has
started seeing interest in using Trino for ETL jobs due to the faster
turnaround. Some issues Lyft has faced has been around how resource hungry Trino
is, as well as, the issue where the coordinator can be a single point of failure
for queries executing on a cluster.

Lyft was one of the earliest companies to really push using Trino for ETL use
cases. They built custom best effort rollback code in Apache Airflow. If a query
fails, the operation reverts to the state before the operation began. Lyft runs
four Trino clusters split by the type of workload used on that cluster. The best
practices are careful usage around broadcast joins, query sharding, and scaling
writers for ETL loads.

One final point Lyft pointed out is keeping up with the rapid release cycle of
Trino was a challenge. Lyft showcases their regression testing using their query
replay framework. This session is a smooth five out of five ride. Enjoy!

## Share this session

If you thought this talk was interesting, please consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome, 
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/lyft-social.png"/>