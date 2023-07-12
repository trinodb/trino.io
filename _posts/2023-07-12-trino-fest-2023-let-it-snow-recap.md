---
layout: post
title: "Let it snow for Trino"
author: "Yu Teng, Erik Anderson, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/ForePaaS and Bloomberg.png
show_pagenav: false
---

In this recap, we can skip right to the exciting part: through the joint efforts
of engineers at ForePaaS and Bloomberg, there is a Snowflake connector coming
to Trino! Though it hasn't landed yet, it has been tested and run in production
at both companies, and a pull request is open and working its way towards
completion as this blog post goes up. In the talk, Yu and Erik talk about
difficulties in developing the connector, the motivations to make it happen, and
the new features that come as part of it for Trino users to take advantage of.
Sound interesting? Give the talk a listen, or read on for more details.

<!--more-->

{% youtube kmpO_yM8OAs %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023LetItSnow.pdf">
  Check out the slides!
</a>

For those unfamiliar, Snowflake is a cloud-based data warehousing and analytics
platform. It offers a great combination of scale, flexibility, and performance,
with the downside of being a proprietary software that is vendor-locked, and in
order to use Snowflake, you must go through Snowflake, Inc. ForePaaS and its
customers store data in Snowflake, but they also store data in many other 
formats and systems, and they rely on Trino to run their analytics. With no
Snowflake connector in Trino, this meant that while they could run analytics and
queries on most data, Trino had a blind spot. They needed to develop a Snowflake
connector in order to see and query 100% of their data. Bloomberg was in a
similar boat, having data in Snowflake, using Trino for analytics, and needing a
way to join those two together. With a shared need, ForePaaS and Bloomberg
joined forced and made the connector happen.

The connector has been in use at both companies for some time, and it comes with
the full feature set one would expect from a Trino connector. With the connector,
you can query Snowflake directly from Trino, taking advantage of Trino's
lightning-fast speeds and the underlying features of Snowflake with no issue.

Curious to see more? For the rest of the talk, Erik Anderson at Bloomberg gives
a demo of the connector in action. Give the talk a watch, and you can check out
progress on how adding the connector to Trino is coming along on
[the pull request contributing it](https://github.com/trinodb/trino/pull/17909).

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!