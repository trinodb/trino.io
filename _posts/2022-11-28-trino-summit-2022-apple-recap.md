---
layout: post
title: "Trino at Apple"
author: "Vinitha Gankidi, Yathi Peddyshetty, Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/apple.jpg
---

This post continues [a larger series of posts]({% post_url 
2022-11-21-trino-summit-2022-recap %}) on the Trino Summit 2022 sessions.
Following the [Keynote: State of Trino session]({% post_url
2022-11-22-trino-summit-2022-state-of-trino-keynote-recap %}), engineers from Apple shared the
current usage of Trino at Apple. They discuss how they support Trino as a
service for multiple end-users, and the critical features that drew Apple to
Trino. They wrap up with some challenges they have faced and some development
they have planned to contribute to Trino.

<!--more-->

{% youtube 3afcRK6Yvio %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@Apple.pdf">
  Check out the slides!
</a>

## Recap

> Trino is deployed at scale in Apple, and it continues to see tremendous
> adoption across multiple teams at Apple. *Yathi Peddyshetty, Software Engineer @ Apple*

The commonplace adhoc and BI analytics use cases make up a lot of how Apple uses
Trino today. They also have increasing uses in federated querying and A/B 
testing. 

To deploy Trino as a service, Apple has an in-house Kubernetes operator to
manage the Trino cluster lifecycles. They also created an orchestrator to
provision and simplify cluster creation and management. They make this a
self-service console that allows users to provision their own clusters per
request. Their custom orchestrator also takes care of autoscaling and other
technical complexities of maintaining a scalable Trino system.

Apple primarily uses Iceberg, Hive, and Cassandra connectors. They have a heavy
focus on Apache Iceberg as their table format and have contributed a significant
amount of PRs to improve interoperability between Trino and Spark, and increased
coverage of Iceberg APIs. Other challenges Apple face stem from the lack of
flexible routing of queries to achieve zero downtime, and having pluggable
optimizer rules and operators.

Apple has various features on their roadmap to eventually contribute to the
community. This includes, exposing remaining functionality in the Iceberg APIs,
support all partition transforms, predicate pushdowns, bucketed joins, simple
aggregate pushdowns, Iceberg native views in Trino, and more.

## Share this session

If you thought this talk was interesting, please consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome, 
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/apple-social.png"/>