---
layout: post
title: "Trino optimization with distributed caching on data lakes"
author: "Kevin Kho and Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Fugue.png
show_pagenav: false
---

Fugue may be an unfamiliar name to those in the Trino ecosystem. It's another
Python tool, a programming model built to enhance interoperability between
Python and SQL. On the Python side of things, it's a wrapper around common tools
like pandas and Polars that convert code into SQL for high-performance,
large-scale query execution. So why are we talking about it at Trino Fest?
Because Fugue recently launched an integration with Trino, enabling you to write
Python code that can be converted to SQL to run on a high-powered Trino backend.

<!--more-->

{% youtube aKhI1Phfn-o %}

Though Trino users are quite familiar with SQL, it does present some challenges.
Iterating on a SQL query and improving it can be difficult, and finding ways to
optimize or speed things up can be a challenge that requires sophisticated
external tools or working on hunches. Testing queries, especially incrementally,
has never been super easy, either. Compare that to Python, which does not have
those problems, but has issues of its own. Python, especially at scale, is not
very performant. So it's natural to try to take the advantages of both, which is
what Fugue is aiming to do.

After that brief intro into Fugue, the rest of the talk consists of technical
demos of the many various things that you can do with Fugue. This includes
setting a query up, breaking it up into smaller parts, bringing it to pandas,
and demonstrating extensions that are built into Fugue. With all of these
intermediate steps, it becomes easier to unit test queries before sending them
into production, making sure that everything works as expected.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!