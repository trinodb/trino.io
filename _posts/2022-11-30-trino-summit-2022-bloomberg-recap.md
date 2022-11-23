---
layout: post
title: "Enterprise-ready Trino at Bloomberg: One Giant Leap Toward Data Mesh!"
author: "Vishal Jadhav, Pablo Arteaga, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/bloomberg.jpg
---

This post continues [a larger series of posts]({% post_url
2022-11-21-trino-summit-2022-recap %}) on the Trino Summit 2022 sessions.
Following the [Trino at Apple talk]({% post_url
2022-11-22-trino-summit-2022-apple-recap %}), engineers from Bloomberg shared
the latest about their additions to Trino. Bloomberg uses Trino to federate huge
amounts of disparate financial data together. When you have many users with
different use cases and resource needs, you need something to ensure that the
huge workloads don't bully the small ones. Enter the Trino Load Balancer, a
privacy-aware solution to help maintain high availability while still treating
data security as the first-class citizen that it should be.

<!--more-->

{% youtube ePr-iVQ5ri4 %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino-at-Bloomberg.pdf">
  Check out the slides here!
</a>

## Recap

Bloomberg collects data, creates experimental data, and ingests data from
vendors. Its data analysts then refine, clean, and structure that data using
whatever their preferred method is, generating even more diverse data. Internal
teams and clients then want to look at and query that generated data, too. Sound
like a data mesh? That's because it is. Trino isn't new at Bloomberg, and it's
been in use to help federate all of those varying data sets into one unified
access point.

When trying to deploy multiple Trino clusters for such a wide array of users who
demand high uptime, high throughput, and fast response times, the Trino
coordinator becomes a single point of failure. There's the risk of
infrastructure outages, the need to shut things down for occasional upgrades,
and some users run high-throughput jobs for millions of rows while others are
expecting low-latency jobs for only hundreds. Keeping Trino up, running, and
meeting all users' expectations is no small task.

And that's where the Trino Load Balancer comes in! As a fork of the open-source
presto-gateway, it helps to do exactly what it says on the tin for Trino:
balance workloads. By being aware of what's running on each cluster and how many
resources are being used, it can direct traffic to the ideal clusters to meet
each user's needs. And with a brief demo, we get a look at how data owners
can set policies that are respected within the load balancer, ensuring that
users can only access and query what they're supposed to.

## Share this session

If you thought this talk was interesting, consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/bloomberg-social.png"/>