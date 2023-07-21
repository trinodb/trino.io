---
layout: post
title: "Starburst Galaxy: A romance of many architectures"
author: "Benjamin Jeter, Ryan Duan"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Datto.png
show_pagenav: false
---

Let's cut straight to the chase with this lightning talk from Benjamin Jeter, a
data architect, platform manager, and data engineer at Datto. For those that are
not familiar with Datto, they are an American cybersecurity and data backup
company. They're the leading global provider of security and cloud-based
software solutions purpose-built for Managed Service Providers (MSPs). In
Benjamin's talk, he goes through some of the considerations and design goals of
a reference architecture pattern that they use and why they chose to use Trino
with Starburst Galaxy.

<!--more-->

{% youtube K3AlAWB-Gmg %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Datto.pdf">
  Check out the slides!
</a>


## Recap

But you might be wondering: what does Ben mean when he says "reference
architecture"? A reference architecture pattern is a pattern for making
arbitrary data available to end users in a reproducible and modular way. It's an
opinionated representation of what best practices look like for a given class of
use cases. You can almost think of it as a conceptual tool for thinking
critically about specific patterns through a pragmatic balance of simplicity and
effectiveness. However, it is not something that will work for every use case
and not necessarily the best solution.

The main design goal that Benjamin had was to facilitate near real-time data
access while using only Trino. In addition, he wanted it to be simple, easy to
understand, flexible, and adaptable. Accomplishing this design goal requires
many steps, such as first having a daily batch transform that transforms JSON
into Iceberg and serve as [T-1
data](https://www.investopedia.com/terms/t/tplus1.asp). Then he created an
unpartitioned external table that is rebuilt every day as part of the daily
batch transform. Using the [Great Lakes
connectivity](https://docs.starburst.io/starburst-galaxy/sql/great-lakes.html)
with this table allows Datto to have scan on query semantics, which enables data
access about as real-time as you can get it without a streaming solutions like
Kafka or Kinesis. Benjamin shows how easy it is to design a use case with just a
couple lines of code using Trino with Starburst Galaxy.

Interested? Check out the video where Benjamin shows the code and explains how
it works!

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!