---
layout: post
title: "Ibis: Because SQL is everywhere and so is Python"
author: "Phillip Cloud, Cole Bowden"
excerpt_separator: <!--more-->
image: /assets/blog/trino-fest-2023/Ibis.png
show_pagenav: false
---

The PyData stack has been described as "unreasonably effective," empowering its
users to glean insights and analyze moderate amounts of data with a high level
of flexibility and excellent visualization. The large-scale, production data
stack using a query engine like Trino sits on the other side of the world,
capable of handling petabytes and exabytes, but perhaps not integrating as
seamlessly with the Python ecosystem as one would hope. SQL has been a means of
bridging this gap, but we've now got an exciting solution to bridge it even
better: Ibis.

<!--more-->

{% youtube JMUtPl-cMRc %}

<a class="btn btn-pink btn-md" target="_blank" href="/assets/blog/trino-fest-2023/TrinoFest2023Ibis.pdf">
  Check out the slides!
</a>

A major problem with bridging the gap between Python and SQL engines has been
the lack of standardization in SQL. Though Trino prides itself on being
ANSI-compliant and many other SQL dialects strive to be similar, the reality is
that every SQL engine is different, and a complicated SQL query will error out
or return different results based on what engine you're using. So if you want to
convert some Python code to SQL, the question is... which SQL? If you're doing
your data analysis in Python because you prefer to use it, spending time
scratching your head and trying to work out a SQL conversion can be frustrating,
time-consuming, and painful. But SQL is everywhere, and for large, performant,
efficient queries, you may need a SQL engine like Trino.

Enter Ibis, a lightweight Python library for "data wrangling." It can easily
convert your Python code into SQL queries for 16 different engines, including
Trino. With Ibis, you can leverage the ease of writing Python code with the
power and performance of running queries in Trino, getting the best of both
worlds in both the Python and SQL ecosystems. Want to learn more? Check out
[the Ibis project website](https://ibis-project.org/), give the talk a listen,
and tune into the Trino Community Broadcast on July 6th, where we'll be going
into even more detail about Ibis.

## Share this session

If you thought this talk was interesting, consider sharing this on Twitter,
Reddit, LinkedIn, HackerNews or anywhere on the web. If you think Trino is awesome,
[give us a 🌟 on GitHub <i class="fab fa-github"/>](https://github.com/trinodb/trino)!