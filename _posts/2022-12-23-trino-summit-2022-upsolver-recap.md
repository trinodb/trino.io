---
layout: post
title: "Using Trino to analyze a product-led growth (PLG) user activation funnel"
author: "Mei Long, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/upsolver.jpg
---

As the holiday season approaches, we have reached the end of our
[Trino Summit 2022 recap posts]({% post_url 2022-11-21-trino-summit-2022-recap %}).
With the last talk of the summit, Mei Long from Upsolver gave an insightful
overview of how they use data to inform product decisions.

<!--more-->

{% youtube MCB_1furnAo %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Trino@Upsolver.pdf">
  Check out the slides!
</a>

## Recap

When talking about product-led growth (PLG), it helps to start by defining what
it even means. The core idea is simple: see how users engage with your product,
and make decisions based on how you can improve the product to better serve
those users. At Upsolver, the goal of PLG is to maximize user value. The issue
is that while this can be simple in some situations, when you're delivering
complicated analytics tools, it's not always immediately clear what features
would be the most valuable or useful. You need a lot of data to glean a lot of
insight, and you need to make sure your insights that can lead to action. And of
course, you need to be absolutely certain that your data is high-quality,
accurate, and trustworthy, lest you end up accidentally giving a customer a
ten million dollar discount.

Mei explores the initial pass at using analytics to drive PLG at Upsolver,
letting her intern use a tool called Amplitude that worked for a time and for
limited use cases. As Upsolver grew, the analytics requirements did, too, and
Amplitude wasn't powerful enough for Upsolver's use case, nor for the more
complicated queries and analysis that needed to be run.

Want to guess what query engine they swapped to using? Trino. Mei dives into a
quick demo that shows how Upsolver ingests all of its streaming data and stores
it for Trino to query, driving down time-to-insight to make it quick and
efficient to ask questions and make decisions based on those answers. With Trino
at the ready, Upsolver has never been better-equipped to work towards PLG.

## Share this session

If you thought this talk was interesting, please consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/upsolver-social.png"/>