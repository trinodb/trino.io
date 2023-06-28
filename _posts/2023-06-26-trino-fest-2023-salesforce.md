---
layout: post
title: "Anomaly detection for Salesforce’s production data using Trino"
author: "Tuli Nivas, Geeta Shankar, Ryan Duan"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Salesforce.png
show_pagenav: false
---

Rolling into our next presentation from [Trino Fest 2023]({% post_url
2023-06-20-trino-fest-2023-recap %}), we're excited to bring you
Tuli Navas and Geeta Shankar's talk from the Performance Engineering Team at
Salesforce. They provide numerous reasons for why they need Trino and
further explain how it is essential for anomaly detection in
their data. It's an insightful talk about using a query engine to ensure data
quality and how switching to Trino has massively improved their performance.
You definitely don't want to miss it.

<!--more-->

{% youtube nFuqpb2GjVI %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Salesforce.pdf">
  Check out the slides!
</a>

## Recap

Salesforce provides customer relationship management software and applications
focused on sales, customer service, marketing automation, e-commerce, analytics,
and application development. They host hundreds of thousands of customers that
generate millions of transactions per day. For a company of this size, they
need a query engine that is fast and efficient. During the talk, Tuli made it
clear how much Salesforce relies on Trino, stating, "Trino has been a one-stop
shop for analytics." Trino is the perfect solution for them, as Tuli mentions,
"Because of how well Trino scales and how efficiently it has been able to
process even the most gnarly looking queries." It allows them to do everything
they need.

In addition, Trino has helped Salesforce get more value from their production
logging data by accelerating their access to it, speeding up their decision
making. For years, they used Splunk for all their production data, but after
switching to Trino, they have had numerous improvements:

* Reducing their team's analytics cost
* Improving their cost-to-serve
* Improving the time it takes to run the same query by 194%
* Providing an SLA of 20-minute latency on all production logs
* Retaining and accessing data up to 2 years compared to Splunk's 30 days
* Reducing the number of queries needed, which creates a smaller footprint
* Creating tables and views for temporary data storage and analytics

With this, they use specific heuristics to create an anomaly detection framework
with a very quick response time that they are able to constantly observe. This
also allows them to monitor customer behavior efficiently, allowing them to
respond to any urgent changes quickly. In the future, they plan to expand and
ramp up their usage of Trino throughout their teams.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!