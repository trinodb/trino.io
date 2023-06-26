---
layout: post
title: "Trino for lakehouses, data oceans, and beyond"
author: "Martin Traverso, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Keynote.png
show_pagenav: false
---

[Trino Fest 2023]({% post_url 2023-06-20-trino-fest-2023-recap %}) got off to a
bang, as Trino co-creator and maintainer Martin Traverso gave an update on all
the amazing things that have happened to Trino since
[Trino Summit last year]({% post_url 2022-11-21-trino-summit-2022-recap %}). He
also provided some insight into what's coming down the pipeline for Trino, with
a brief look at the project's roadmap. You can watch the recording of the talk
if you want to see for yourself, or you can read on for the highlights.

<!--more-->

{% youtube SJ1h-I7HoII %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Keynote.pdf">
  Check out the slides!
</a>

## Recap

It's only been about 7 months since Trino Summit in 2022, but Trino moves
quickly. In the words of Martin, "the project is on fire" and "is as active as
it's ever been," leaving us a lot to catch up to since then:

* 16 releases and 2,250 commits
* [Two new maintainers]({{site.url}}/episodes/47.html)
* Several new table functions
* Simplified configuration and improved performance for fault-tolerant execution
* Better support for schema evolution and lakehouse migration
* 45 bullet points worth of performance improvements
* Tracing with OpenTelemetry
* An improved Python client and dbt Cloud support

And keep in mind that these are the highlights of the highlights! In the talk,
Martin goes into depth on all of the above, making it a worthwhile watch or
listen. There's also a lot to look forward to, which you'll hear more about as
they roll out in the coming months:

* SQL 2023, including enhancements to JSON functions and numeric literals
* A new Snowflake connector and an improved Redis connector
* Java 21
* Project Hummingbird, the ongoing effort to incrementally make Trino faster
  than ever before

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!