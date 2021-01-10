---
layout: post
title:  "A Report about Presto Conference Tokyo 2020 Online"
author: Toru Takahashi, Treasure Data
excerpt_separator: <!--more-->
---

On Nov 11th, 2020, Japan Presto Community held the 2nd Presto Conference 
welcoming Martin Traverso and Brian Olsen.
The conference was hosted at Youtube Live.
This article is the summary of the conference aiming to share their great talks. 

<!--more-->

# Presto Community Updates

First of all, Martin introduced recent Presto updates in these days. 
It covers recent changes and enhancements achieved by the community activities.
Attendees also learned several new functions that will be available soon.

- Update / Merge (https://github.com/prestosql/presto/issues/3325)
- Materialized Views (https://github.com/prestosql/presto/pull/3283)
- Dynamically resolved functions
- Optimized Parquet reader

In addition, at Q&A, he suggests new developers who want to contribute to PrestoSQL 
to check "good first issue" tag on Github. The tag is a good first step for a new joiner to contribute. 
Ref. [link](https://github.com/prestosql/presto/labels/good%20first%20issue)

{% youtube NxDBBEA67Ws %}

# Presto Community - How to get involved

To make attendees get used to Presto Community, Martin provided a guide for walking around Presto community. 
He gives us their team's principles about the Presto community, and talk about their education strategy for new Presto users.
I would like to quote the pricinpals here.

- We are passionate about open source
- We help others be succesfful with what we create
- We create robust long-lasting software
- We are egalitarian (nobody is more important than the other)

# Support Presto as a feature of SaaS

Then, Satoru Kamikaseda, Technical Support Engineer at Treasure Data, provides an overview of how Treasure Data supports Presto in their service. 
Presto is heavily used to support many enterprise use cases as a customer data platoform, 
and it is becoming the hub component processing high throughput workload from many kinds of clients such as Spark, ODBC and JDBC.

He described statistics about Presto queries on their platform, and how to support each cases. 
In the stats, 1/3 is any investigation of job failure and query result, 1/3 is a request to help their client's SQL, 
and others are a sort of notifications to their clients and performance investigation. 
His talk must be useful for any SaaS companies that provides a query engine to their clients to learn how difficult it is to support a distibuted query engine.

<iframe src="//www.slideshare.net/slideshow/embed_code/key/GR6e3dfKKJ8w4c" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/SatoruKamikaseda/support-presto-as-a-feature-of-saas" title="Support Presto as a feature of SaaS" target="_blank">Support Presto as a feature of SaaS</a> </strong> from <strong><a href="https://www.slideshare.net/SatoruKamikaseda" target="_blank">SatoruKamikaseda</a></strong> </div>

# How to use Presto with AWS efficiently

We could learn how to use Presto with AWS including Presto on EMR, Presto on EC2, Presto by Athena and AWS Glue.
Noritaka Sekiyama, Sr. Big Data Architect at Amazon Web Service, Japan, also shares a comparison of Presto on AWS (EC2, EMR, Athena). 
If you are a new to Presto, his talk gives you an insight to choose your first Presto environement.

<iframe src="//www.slideshare.net/slideshow/embed_code/key/kWzJ1XqR96A9di" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/ssuserca76a5/aws-presto" title="AWS で Presto を徹底的に使いこなすワザ" target="_blank">AWS で Presto を徹底的に使いこなすワザ</a> </strong> from <strong><a href="https://www.slideshare.net/ssuserca76a5" target="_blank">Noritaka Sekiyama</a></strong> </div>

# Presto @ LINE 2020

LINE is the biggest company providing the mobile communication tool in Japan (say WhatsApp in Japan). HYuya Ebihara, one of Presto maintainers, 
gives us how they improve Presto at their platform since they presented in [the previous conference]({% post_url 2019-07-11-report-for-presto-conference-tokyo %}). 
Their Presto usage significantly increases from 2019. Num of Presto workers from 100 to 300 and Num of daily queries reaches to 50,000 queries from 20,000 queries. 
We could learn how to upgrade Presto from 314 to 339 and how they resolved issues through Presto upgrade.

<iframe src="https://docs.google.com/presentation/d/e/2PACX-1vS2QdQjhLsiSuVdWlEmT23ixqoZXkRrKKMRGa1hrZHg65OpcH18RpzARotOMYvIBSwP57lPPAHkUQOx/embed" frameborder="0" width="595" height="485" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

# Dive into Amazon Athena - Serverless Presto, 2020

Makoto Kawamura, Solution Architect at Amazon Web Service Japan, 
introduces the latest features of AWS Athena and performance tuning tips. It must be helpful for developers who tied to AWS to explore Amazon Athena.

<div style="width: 90%"><script async class="speakerdeck-embed" data-id="92a399aad5344df197279cd4195d9464" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script></div>

# Presto Cassandra Connector Hack at Repro

Repro provides Customer Engagement Platform that enables companies to personalize their communication strategies with the right message at the right time to drive better retention and lifetime value. 
They use Presto for a segmentation backend system in their service to make a list of audiences with a certain condition. 

Takeshi Arabiki gives us an in-depth presentation on the modification of Presto Casandra to stabilize and improve the performance of Presto, 
in addition to the use of Presto in Repro.
His talk covers a wide range of topics from investigation of the bottleneck to its resolution.

<script async class="speakerdeck-embed" data-id="9289d942805a4bf2be908cf42a122a29" data-ratio="1.77777777777778" src="//speakerdeck.com/assets/embed.js"></script>

# Testing Distributed Query Engine as a Service

At the end, Naoki Takezoe from Treasure Data, talks their challenges towards Presto upgrade and 
how hard to migrate variety of workload with performance stability. 
In actual production-scale enviroment that are running multiple client, testing is one of big challenges. 
He shows how they simulate their client workload with theier developed query simulator to cover various corner cases and to verify data correctness.

<iframe src="//www.slideshare.net/slideshow/embed_code/key/yCrep8qbYUzNzh" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/takezoe/testing-distributed-query-engine-as-a-service" title="Testing Distributed Query Engine as a Service" target="_blank">Testing Distributed Query Engine as a Service</a> </strong> from <strong><a href="https://www.slideshare.net/takezoe" target="_blank">takezoe</a></strong> </div>

# Wrap Up

This conference was the first online Presto conference in Tokyo. 
Unfortunately, We couldn't have a chance to discuss with the community developers and creators in face-to-face. We hope we'll get such a great opportunity in the near future.
However, that was a great time to have many presentations with the community members to learn a lot of new things from their wornderful experience.
During the conference, the average number of Youtube Live viewers are over 100 people, 
and the total of attendees are around 180 people. 
In the previous conference, there were 89 attendees. I think the number of Presto developers/users in Japan has been increasing gradually. 
We really appreciate developers in the community and creators. Thank you so much for coming to the conference and see you next time!

# Youtube Live link

The event is mainly talked in Japanese.

- [Presto Conference Tokyo 2020 Online](https://youtu.be/NxDBBEA67Ws)

