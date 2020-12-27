---
layout: post
title:  "Beyond LIMIT, Presto meets OFFSET and TIES"
author: Piotr Findeisen, Starburst Data
excerpt_separator: <!--more-->
---

Presto follows the SQL Standard faithfully. We extend it only when it is well justified,
we strive to never break it and we always prefer the standard way of doing things.
There was one situation where we stumbled, though. We had a non-standard way of limiting
query results with `LIMIT n` without implementing the standard way of doing that first.
We have corrected that, adding ANSI SQL way of limiting query results, discarding initial
results and -- a hidden gem -- retaining initial results in case of ties.

<!--more-->

# Limiting query results

Probably everyone using relational databases knows the `LIMIT n` syntax for limiting query
results. It is supported by e.g. MySQL, PostgreSQL and many more SQL engines following
their example. It is so common that one could think that `LIMIT n` is the standard way
of limiting the query results.  Let's have a look at how various popular SQL engines
provide this feature.

* DB2, MySQL, MariaDB, PostgreSQL, Redshift, MemSQL, SQLite and many others provide the `... LIMIT n` syntax.
* SQL Server provides `SELECT TOP n ...` syntax.
* Oracle provides `... WHERE ROWNUM <= n` syntax.

And what does the SQL Standard say?

```sql
SELECT *
FROM my_table
FETCH FIRST n ROWS ONLY 
```

If we look again at the database systems mentioned above, it turns out many of them support the standard
syntax too: Oracle, DB2, SQL Server and PostgreSQL (although that's not documented currently).

And Presto? Presto has `LIMIT n` support since 2012. In [Presto 310]({{site.url}}/docs/current/release/release-310.html),
we added also the `FETCH FIRST n ROWS ONLY` support.

Let's have a look beyond the limits.

# Tie break

Admittedly, `FETCH FIRST n ROWS ONLY` syntax is way more verbose than the short `LIMIT n` syntax Presto
always supported (and still does). However, it is also more powerful: it allows selecting rows "top n,
ties included". Consider a case where you want to list top 3 students with highest score on an exam.
What happens if the 3<sup>rd</sup>, 4<sup>th</sup> and 5<sup>th</sup> persons have equal score? Which
one should be returned? Instead of getting an arbitrary (and indeterminate) result you can use
the `FETCH FIRST n ROWS WITH TIES` syntax:

```sql
SELECT student_name, score
FROM student s JOIN exam_result e ON s.id = e.student_id
ORDER BY score
FETCH FIRST 3 ROWS WITH TIES
```

The `FETCH FIRST n ROWS WITH TIES` clause retains all rows with equal values of the ordering keys (the `ORDER BY` clause) as
the last row that would be returned by the `FETCH FIRST n ROWS ONLY` clause.

# Offset

Per the SQL Standard, the `FETCH FIRST n ROWS ONLY` clause can be prepended with `OFFSET m`, to skip `m` initial rows.
In such a case, it makes sense to use `FETCH NEXT ...` variant of the clause -- it's allowed with and without `OFFSET`,
but definitely looks better with that clause.

```sql
SELECT student_name, score
FROM student s JOIN exam_result e ON s.id = e.student_id
ORDER BY score
OFFSET 5
FETCH NEXT 3 ROWS WITH TIES
```

As an extension to SQL Standard, and for the brevity of this syntax, we also allow `OFFSET` with `LIMIT`:

```sql
SELECT student_name, score
FROM student s JOIN exam_result e ON s.id = e.student_id
ORDER BY score
OFFSET 5
LIMIT 3
```

# Concluding notes

`LIMIT` / `FETCH FIRST ... ROWS ONLY`, `FETCH FIRST ... WITH TIES` and `OFFSET` are powerful and very useful clauses
that come especially handy when writing ad-hoc queries over big data sets. They offer certain syntactic freedom beyond
what is described here, so check out documentation of [OFFSET Clause](/docs/current/sql/select.html#offset-clause) and
[LIMIT or FETCH FIRST Clauses](/docs/current/sql/select.html#limit-or-fetch-first-clauses) for all the options.
Since semantics of these clauses depend on query results being well ordered, they are best used with `ORDER BY` that
defines proper ordering. Without proper ordering the results are arbitrary (except for `WITH TIES`) which may or may
not be a problem, depending on the use case.

For scheduled queries, or queries that are part of some workflow (as opposed to ad-hoc), we recommend using query
predicates (where relevant) instead of `OFFSET`. Read more at
[https://use-the-index-luke.com/sql/partial-results/fetch-next-page](https://use-the-index-luke.com/sql/partial-results/fetch-next-page).

□
