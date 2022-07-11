---
layout: post
title: "Diving into polymorphic table functions with Trino"
author: "Kasia Findeisen, Brian Olsen, and Cole Bowden"
excerpt_separator: <!--more-->
---

In the Trino community, we know that being the coolest query engine is a tough
job. We boldly face the intricacies of the SQL standard to bring you the newest
and most powerful features. Today, we proudly announce that as of release 381,
Trino is on its way to full support for polymorphic table functions (PTFs).

In this blog post, we are explaining the concept of table functions and 
exploring how they can be leveraged. We also look at what we have already 
implemented, and take a sneak peek into the future.

<!--more-->

### Definition time

There are several kinds of functions you can call in a SQL query: scalar
functions, aggregate functions, and window functions. They might process the
input row by row (scalar) or all at once (aggregate). One thing they have in
common is that they return scalar values. Table functions are different. They
return tables. In a query, they can appear in any place where a table reference
shows up such as a `FROM` clause:

```sql
SELECT
  *
FROM
  TABLE(my_table_function('foo'));
```

You can also use table functions in joins:

```sql
SELECT
  *
FROM
  TABLE(my_table_function('bar'))
JOIN
  TABLE(another_table_function(1, 2, 3))
ON true;
```

Polymorphic table functions (PTFs) are a subset of table functions where the
schema of the returned table is determined dynamically. The returned table
schema can depend on the arguments you pass to the function.

### OK, but why are we so excited?

We are excited because this feature is a real game changer! Polymorphic table
functions make SQL extensible, provide a framework for processing data in
previously impossible ways, and can act as a bridge between the Trino engine and
external systems or resources you might need for processing your data.
Additionally, polymorphic table functions are standard SQL, and they are very
convenient to use.

### What is available in Trino today?

So far, we have added a framework for table functions which can be executed by
the connector. Although this is not the full PTF feature yet, we couldn't wait
to bring it to life. We added query pass-through table functions for JDBC-based
connectors and ElasticSearch. They mostly go by the name `query`, and they take
a single argument, that being the query text:

```sql
SELECT
  *
FROM
  TABLE(
    postgresql.system.query(query =>
        'SELECT
          name
        FROM
          tpch.nation
        WHERE
          nationkey = 0'
    )
  );
```

And this will return:

```sql
  name
---------
 ALGERIA
(1 row)
```

Something you can’t notice from that example is that when you’re passing that
“query” argument, it’s taking the entire query and having PostgreSQL execute it.
Whatever connector you’re using, the query argument you pass needs to be written
so that it works on the underlying database. On the opposite and more exciting
side of that, if you have a legacy query specific to a database which has
non-standard SQL syntax and would be difficult to rewrite for Trino, now you can
pass that entire query down to the connector by wrapping it in the `query`
function, skipping the need to migrate it.

Besides PostgreSQL, the `query` table function has equivalent implementations
for Druid, MySQL, Oracle, Redshift, SQL Server, MariaDB, and SingleStore.
ElasticSearch has a similar function called `raw_query`. You can check out the
[Trino docs for each supported connector](https://trino.io/docs/current/connector.html)
for full details.

But while we’re here, another cool example to showcase is using query
pass-through to take advantage the `MODEL` clause in Oracle:

```sql
SELECT
  SUBSTR(country, 1, 20) country,
  SUBSTR(product, 1, 15) product,
  year,
  sales
FROM
  TABLE(
    oracle.system.query(
      query => 'SELECT
        *
      FROM
        sales_view
      MODEL
        RETURN UPDATED ROWS
        MAIN
          simple_model
        PARTITION BY
          country
        MEASURES
          sales
        RULES
          (sales['Bounce', 2001] = 1000,
          sales['Bounce', 2002] = sales['Bounce', 2001] + sales['Bounce', 2000],
          sales['Y Box', 2002] = sales['Y Box', 2001])
      ORDER BY
        country'
    )
  );
```

You can pass an entire query through to leverage a feature that isn’t a part of
the SQL standard, and with that `MODEL` clause, Oracle can do some fancy
multidimensional array processing for you right then and there, returning the
results as a table back into Trino. We don’t want to get too sidetracked delving
into the specifics of non-Trino tech, so if you want to learn more about what
you can do, check out the connectors you use, and see what cool possibilities
are out there!

## What’s next?

Now that we’ve discussed what PTFs are, how they work in Trino, and what they do
today, it’s useful to look forward to what’s coming next. The next thing we’re
working on is adding the `query` function to BigQuery.

### Big ideas

Beyond what’s currently planned, there’s a lot that polymorphic table functions
can do for us. One common function that engineers and analysts commonly request
in Trino is `PIVOT`. This is a capability that dynamically groups different
values of an input column and converts each value as a set of columns in the
output table. A potential use of PTFs would enable a PIVOT-like transformation
on data, which otherwise isn’t included in the standard SQL specification.

Another exciting potential is the ability to write scripts to transform or
generate tables in popular languages like Python, Scala, or Javascript. These
can be used to add even more new capabilities that SQL is missing.

### Looking forward

The journey to full PTF support in Trino has just begun. A dedicated operator
for table functions is the next big thing. Right now, Trino can handle PTFs, but
they must be pushed down to the connector and executed there. The Trino engine
does not yet know how to execute them. With an operator, the Trino engine will
be able to control and handle table function execution, and we will be able to
pass tables as arguments to table functions. This will unlock the full potential
of PTFs in Trino, and empower Trino to solve a new class of problems and expand
its potential for application in many new domains.

If you have any questions or ideas for table functions that you would find
useful, reach out to us on the [Trino Slack](https://trino.io/slack.html), and
we would love to hear your thoughts and feedback. We’ll also be doing a Trino
Community Broadcast on PTFs on July 28th @ 1pm EDT, so tune in then to have your
questions answered live!

If you want to learn more about how to implement PTFs, we are working on another
blog post for you already.

Happy querying!



