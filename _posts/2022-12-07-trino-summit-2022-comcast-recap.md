---
layout: post
title: "Elevating data fabric to data mesh: Solving data needs in hybrid data lakes"
author: "Sajuman Joseph, Brian Olsen"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/comcast.jpg
---

Tune in for the next [post in the Trino Summit 2022 recap series]({% post_url
2022-11-21-trino-summit-2022-recap %}). In this post, we're joining Saj from
Comcast, to talk about their migration from a data fabric to data mesh. Saj
shows you that there is more to the buzzword than meets the eye. He gives a
solid overview of why Comcast is taking data mesh to heart.

<!--more-->

{% youtube sSWBi7bBotQ %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@Comcast.pdf">
  Check out the slides!
</a>

## Recap

Comcast engineer Sajuman Joseph brings us through Comcast's process to move from
their initial use case of using Trino to power their data fabric architecture to
include more governance features by leveraging Trino. Data fabric enables
querying data across distributed data sets, but importantly, it allows Comcast
to transparently migrate data across on-prem and cloud storage without impacting
users.

Despite offering query federation, data fabric still misses out on a
higher-quality experience that data mesh aims to solve. Not only does having
access to the data matter, but also adding data quality checks and a dedicated
owner to ensure the data is correct and consumable. The ownership is split by
domains defined by Comcast. It is the responsibility of the owners to ensure
data quality, compliance, and security on the data they own. This data can be
exposed internally or externally as a data product. While many of the drivers
for this are done through company policy, there are technical means to make this
possible. This includes improving metadata on the data, access logs, global
data catalogs, and managing data access.

Trino facilitates a single point of access and is the a primary location where
policies are enforced. Comcast created an engine called the Enterprise Policy
Hub which syncs with all data stores and compute engines to enforce company
policy and update metadata on all data across Comcast. Trino, along with other
query engines, consults this engine to determine what information a user has
access to, who owns the data, and creates an audit trail of what queries are
run.

There are still some open challenges Comcast is looking to overcome. Data
discovery is a large challenge for anyone looking to find a specific table and
who is responsible for updating it. Another interesting area Comcast is
researching is creating automated retention and minimization of data copies.
This talk was exciting and gives a pretty clear roadmap to some beneficial
changes many teams can make to improve the quality and governance of their data
sets.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social card and
link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/comcast-social.jpg"/>