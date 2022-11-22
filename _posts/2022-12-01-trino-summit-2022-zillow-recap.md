---
layout: post
title: "Optimizing Trino using spot instances with Zillow"
author: "Santhosh Venkatraman, Rupesh Kumar Perugu, Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/zillow.jpg
---

In this installment of [the Trino Summit 2022 sessions posts]({% post_url
2022-11-21-trino-summit-2022-recap %}), we jump into an exciting topic by folks
from [Zillow](https://www.zillow.com) about running Trino on spot instances.
Spot instances are cheap and ephemeral nodes that lead to reduced overall
compute costs. Spot instances are cheaper as they are not guaranteed to remain
available.

In this session, Zillow engineers talk about how they use Trino on spots to take
advantage of the cost savings while handling the transitory nature of spots.

<!--more-->

{% youtube vz9reBUgQTE %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@Zillow.pdf">
  Check out the slides here!
</a>

## Recap

Zillow's BI platform team is tasked with enabling access to data and metrics
from their data lake in a self-serving and performant manner. The platform must
handle generating up-to-date reports and metrics to unlock time-critical
opportunities. They also need to enable adhoc analytics across multiple domains
within Zillow. 

There are close to 600 data pipelines and 65,000 queries running daily. The
average read covers 600 terabytes of data, and the average P95 time is around
20 seconds. They have six Trino clusters that service various workflows based on
load. These are all deployed on Amazon EKS with a range of eight to 60 workers
based on CPU utilization.

When deploying Trino on EKS, Zillow uses worker groups, which enables them to
collocate nodes in AWS local zones. It also made it possible to choose spot 
instances, which are 90% cheaper than regular on-demand instances. A critical
aspect they needed to cover was to correctly tune the percentage of nodes that
were spot instances. They created pools of nodes that were entirely on-demand
for coordinators since a coordinator going down, brings down the entire cluster.
Other pools used for workers are tuned to an optimal blend of spot and
on-demand.

Watch this session to learn how to properly optimize the number of spot
instances running for your Trino clusters, without losing reliability of your
service. Also learn some ways that Zillow is planning on using the
fault-tolerant execution mode.

## Share this session

If you thought this talk was interesting, please consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/zillow-social.png"/>