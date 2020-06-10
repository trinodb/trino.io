---
layout: post
title:  "Analyze your data with Presto"
author: Piotr Findeisen, Starburst Data
excerpt_separator: <!--more-->
---

One of the less knows facts about Presto is that it provides the ``ANALYZE``
statement. It's very much like Hive's ``ANALYZE``, but yet quite different. Let's see why you should care.

<!--more-->

# What does the ``ANALYZE`` do?

[``ANALYZE``](/docs/current/sql/analyze.html) is the statement for collecting statistics about the data. The statistics collected
are:

- table statistics: basically, number of rows in the table
- column statistics: for each column we want to know:
  - what is the percentage of tne ``NULL`` values
  - what are the minimum and maximum value of the given column
  - what is the number of distinct values (NDV)
  - what is the average data length of the column (naturally, this is applicable, to variable-width
    columns, like ``varchar`` or ``varbinary``).
    
These statistics are very important for getting most of the Presto performance.
You can learn more about how the statistics are used by Presto in
[Introduction to Presto Cost-Based Optimizer](/blog/2019/07/04/cbo-introduction.html).

# Getting your data analyzed

Let's consider you have large data set that you access via Presto Hive connector.
If you have Hive runtime somewhere around, you can analyze the data and collect the statistics using 
Hive's [``ANALYZE``](https://cwiki.apache.org/confluence/display/Hive/StatsDev#StatsDev-ExistingTables) commands:

```
hive> ANALYZE sales COMPUTE STATISTICS;
hive> ANALYZE sales COMPUTE STATISTICS FOR COLUMNS;
```

Can you do this with just one run? Not really. Not to the best of my knowledge.

Now, if your table is partitioned on ``state`` and ``city``, things get even more tricky.
In Hive, you would need to... remind Hive that the table is partitioned:

```
hive> ANALYZE sales PARTITION (state, city) COMPUTE STATISTICS;
hive> ANALYZE sales PARTITION (state, city) COMPUTE STATISTICS FOR COLUMNS;
```

Now, if your table is in another schema, do not try to qualify the table name in Hive's ``ANALYZE``.
Depending on Hive version, it may work, or it may take time analyzing the data, but not
preserving the results anywhere. You need to use ``USE another_schema`` first. Sigh.

# Presto ``ANALYZE`` to the rescue!

With Presto's [``ANALYZE``](/docs/current/sql/analyze.html) things get way simpler.
This is One Command to Analyze Them All!

```
presto> ANALYZE sales;
```

That's it. That's just all you need for most of the cases. 

If you want to hive tighter control, you still have it.
You can analyze selected partition only, by providing the values of the partitioning columns:

```
presto> ANALYZE sales WITH (partitions = ARRAY[ARRAY['CA', 'San Francisco']]);
```

You can also select the desired columns you want to analyze. This is especially useful for very
wide tables:

```
presto> ANALYZE sales WITH (columns = ARRAY['department', 'product_id']);    
```

# Devil is in the details

I find Presto's ``ANALYZE`` syntax much more pleasant to work with. Summing up the above, here are the key
points:

- Presto's Analyze Just Works™
- It is one command, not two, and with easy syntax.
- You don't need to remind Presto that your table is partitioned. Same syntax regardless.
 
However, the actual value and ultimate power of Presto Analyze statement is hidden below the surface.

- Presto's Analyze benefits from unmatched Presto processing speed.
- In my testing, Presto was computing way better cardinality (NDV) estimates. The quality of
  this estimates is especially important for guiding the Cost-Based Optimizer's decisions. 

# Analyze on the fly

You could think now: "why would I need to analyze my data at all?". If you just want to run Presto
and get useful insights from your data sets, you want all the mundane tasks be carried out by _something_, 
so that you do not need to care about. And indeed, when you write data with Presto, you do not need to
analyze it again! By default, when writing data with Presto Hive connector, the data gets analyzed on the fly.
This is possible thanks to the fact that estimate aggregations are very cheap (and yet very accurate thanks to
HyperLogLog) and they do not incur significant overhead on top of processing and writing the data.

For those curious, this is controlled by the ``hive.collect-column-statistics-on-write`` configuration
property and is enabled since Presto 316 by default.

# Conclusions

Add Presto's [``ANALYZE``](/docs/current/sql/analyze.html) command to your toolbelt and never look back.
Write your data with Presto, so that you do not need to analyze it explicitly. And query on! 

□
