---
layout: post
title: "Leveraging Trino to power data at Goldman Sachs"
author: "Sumit Halder, Siddhant Chadha, Suman-Newton, Ramesh Bhanan, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/goldman-sachs.png
---

Continuing with [the Trino Summit 2022 sessions posts]({% post_url
2022-11-21-trino-summit-2022-recap %}), we're diving into an insightful
lightning talk from [Goldman Sachs](https://www.goldmansachs.com). They explore
how they use Trino to help ensure data quality across the board for all users
and customers. By using Trino to federate their various data sources, querying
everything in one place provides them with the flexibility they need. With that
flexibility, they can validate that all data is as it should be where that data
lives, settling any concerns that may exist about data integrity.

<!--more-->

{% youtube g9fLA3tFG-Q %}

## Recap

Validating data quality can be a tricky and complicated process. Data resides
in many sources, with different rules and different processes for checking
quality. Goldman's data ingestion team may not have a detailed understanding
of all data sets. Despite that, there is a need to autonomously verify and
validate all data to be confident in its quality and integrity. The solution to
this challenge? A queryable data quality platform powered by Trino.

The underlying data quality platform's logic handles the validation. Resting
on top of it is Trino, the scalable, fast solution to ensure that users can
query what they need. Even when the platform is profiling the data, enforcing
various quality rules, and validating the data in different ways, Trino is there
to provide access to everything contained within, proving that quality, speed,
and accessibility don't need to be tradeoffs.

## Share this session

If you thought this talk was interesting, consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/goldman-social.png"/>