---
layout: post
title: "Rewriting History: Migrating petabytes of data to Apache Iceberg using Trino"
author: "Marc Laforet, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-summit-2022/shopify.jpg
---

Rolling right along with another one of [our Trino Summit 2022 recap posts]({% post_url
2022-11-21-trino-summit-2022-recap %}), we're excited to bring you the engaging
talk from Marc Laforet at Shopify. He talked about the ordeal (or, if you look
at it in a positive light, the privilege) of migrating petabytes of data from
Hive to Iceberg table formats with the help of Trino. With details on why
Shopify chose to move to Iceberg, the various migration strategies that were
considered, and the ultimate process of moving all that data while the Trino
Iceberg connector was still in active development, it's an insightful talk that
you don't want to miss.

<!--more-->

{% youtube nJBBw-xnLU8 %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-summit-2022/Shopify@Trino.pdf">
  Check out the slides!
</a>

## Recap

Along with many other Trino users, it should come as no surprise that Shopify
has a lot of data to work with. First-party data comes in from a few different
sources, and there's a mountain of modelled data to go along with it. In
Shopify's case, one of the issues was that some data sets were built on top of
custom table formats. On top of that, the architecture wasn't scaled with a
careful plan in mind, leading to limited interoperability of datasets among
various tools. With data scientists unable to unify data across different tools
and storages, it was time for a change.

When you've got tons of data that isn't currently in one place, what's the fix?
Create a central lakehouse for all the data to be accessible from, a
single-service portal that could serve all users' needs. The first question was
which table format to use, and if the title of the blog post didn't already give
it away, they chose to go with Apache Iceberg. It was an easy, central vision
to work towards: all data in a centralized lakehouse stored in Iceberg, then
queryable by Trino.

Having a plan and putting that plan into action are two different things,
though. When nothing is already in Iceberg, moving it all there is a migration
on the scale of thousands of tables and petabytes of data. In Marc's words from
the talk, once Shopify committed to the migration and invested resources into
it, the realization was, "crap, now I have to build it." Even worse, because the
old data was primarily in gzipped JSON format, it all needed to be rewritten...
and so it was.

Then, enter Trino! With new Iceberg-based tables, Trino was identified as the
right tool for the job to process all that data. This wasn't without snags, as
the migration happened while the Iceberg connector was still being aggressively
worked on and developed. There were a few different incidents where Shopify hit
a snag or an issue, and an update or bugfix to Trino's Iceberg connector solved
those problems in a matter of days or weeks.

The result of all of this? Some incredible benchmark results. Large tables saw a
96% reduction in planning time, a 96% reduction in cumulative user memory, and a
95% reduction in query execution time. That's the difference between thousands
of terabytes of memory to under 100, and a query that would take an hour to run
only taking three minutes. For the absolute largest table at Shopify, some
queries saw a 99.9% reduction in execution time. Yes, that number is real.

Moral of the story? If you find yourself using an old Hive table with outdated
file formats, lamenting the resources you need and the time it takes, the
decision is easy. Migrate to Iceberg with Trino. Shopify has shown us the way,
and the full talk has plenty of useful advice for how to best go about it.

## Share this session

If you thought this talk was interesting, consider sharing this on
Twitter, Reddit, LinkedIn, HackerNews or anywhere on the web. Use the social
card and link to <{{site.url}}{{page.url}}>. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!

<img src="/assets/blog/trino-summit-2022/shopify-social.png"/>