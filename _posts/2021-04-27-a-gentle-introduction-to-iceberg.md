---
layout: post
title:  "Trino On Ice I: A Gentle Introduction To Iceberg"
author: Brian Olsen
excerpt_separator: <!--more-->
canonical_url: https://blog.starburstdata.com/trino-on-ice-i-a-gentle-introduction-to-iceberg
---

<p align="center">
 <img align="center" width="100%" height="100%" src="/assets/blog/trino-on-ice/trino-iceberg.png"/>
</p>

Originally published on [the Starburst engineering blog](https://blog.starburstdata.com/trino-on-ice-i-a-gentle-introduction-to-iceberg).

Back in the [Gentle introduction to the Hive connector]({{ site.url }}{% post_url 2020-10-20-intro-to-hive-connector %}) 
blog post, I discussed a commonly misunderstood architecture and uses of the 
Trino Hive connector. In short, while some may think the name indicates Trino 
makes a call to a running Hive instance, the Hive connector does not use the 
Hive runtime to answer queries. Instead, the connector is named Hive connector 
because it relies on Hive conventions and implementation details from the Hadoop
ecosystem - the invisible Hive specification.

<!--more-->

I call this specification invisible because it doesn’t exist. It lives in the 
Hive code and the minds of those who developed it. This is makes it very 
difficult for anybody else who has to integrate with any distributed object 
storage that uses Hive, since they had to rely on reverse engineering and 
keeping up with the changes. The way you interact with Hive changes based on 
[which version of Hive or Hadoop](https://medium.com/hashmapinc/four-steps-for-migrating-from-hive-2-x-to-3-x-e85a8363a18) 
you are running. It also varies if you are in the cloud or over an object store.
Spark has even [modified the Hive spec](https://spark.apache.org/docs/2.4.4/sql-migration-guide-hive-compatibility.html)
in some ways to fit the Hive model to their use cases. It’s a big mess that data 
engineers have put up with for years. Yet despite the confusion and lack of 
organization due to Hive’s number of unwritten assumptions, the Hive connector 
is the most popular connector in use for Trino. Virtually every big data query 
engine uses the Hive model today in some form. As a result it is used by 
numerous companies to store and access data in their data lakes.

So how did something with no specification become so ubiquitous in data lakes? 
Hive was first in the large object storage and big data world as part of Hadoop.
Hadoop became popular from good marketing for Hadoop to solve the problems of 
dealing with the increase in data with the Web 2.0 boom . Of course, Hive didn't
get everything wrong. In fact, without Hive, and the fact that it is open 
source, there may not have been a unified specification at all. Despite the many
hours data engineers have spent bashing their heads against the wall with all 
the unintended consequences of Hive, it still served a very useful purpose.

So why did I just rant about Hive for so long if I’m here to tell you about 
[Apache Iceberg](https://iceberg.apache.org/)? It’s impossible for a teenager 
growing up today to truly appreciate music streaming services without knowing 
what it was like to have an iPod with limited storage, or listening to a 
scratched burnt CD that skips, or flipping your tape or record to side-B. The 
same way anyone born before the turn of the millennium really appreciates 
streaming services, so you too will appreciate Iceberg once you’ve learned the 
intricacies of managing a data lake built on Hive and Hadoop. 

If you haven’t used Hive before, this blog post outlines just a few pain points 
that come from this data warehousing software to give you proper context. If you have already
lived through these headaches, this post acts as a guide to Iceberg from 
Hive. This post is the first in a series of blog posts discussing Apache Iceberg in 
great detail, through the lens of the Trino query engine user. If you’re not 
aware of Trino (formerly PrestoSQL) yet, it is the project that houses the 
founding Presto community after the 
[founders of Presto left Facebook](https://trino.io/blog/2020/12/27/announcing-trino.html).
This and the next couple of posts discuss the Iceberg specification and all
the features Iceberg has to offer, many times in comparison with Hive. 

Before jumping into the comparisons, what is Iceberg exactly? The first thing to
understand is that Iceberg is not a file format, but a table format. It may not
be clear what this means by just stating that, but the function of a table 
format becomes clearer as the improvements Iceberg brings from the Hive table 
standard materialize. Iceberg doesn’t replace file formats like ORC and Parquet,
but is the layer between the query engine and the data. Iceberg maps and indexes
the files in order to provide a higher level abstraction that handles the 
relational table format for data lakes. You will understand more about table 
formats through examples in this series.

## Hidden Partitions

### Hive Partitions

Since most developers and users interact with the table format via the query 
language, a noticeable difference is the flexibility you have while creating a 
partitioned table. Assume you are trying to create a table for tracking events 
occurring in our system. You run both sets of SQL commands from Trino, just 
using the Hive and Iceberg connectors which are designated by the catalog name 
(i.e. the catalog name starting with `hive.` uses the Hive connector, while the
`iceberg.` table uses the Iceberg connector). To begin with, the first DDL 
statement attempts to create an `events` table in the `logging` schema in the 
`hive` catalog, which is configured to use the Hive connector. Trino also 
creates a partition on the `events` table using the `event_time` field which is a
`TIMESTAMP` field. 

```
CREATE TABLE hive.logging.events (
  level VARCHAR,
  event_time TIMESTAMP,
  message VARCHAR,
  call_stack ARRAY(VARCHAR)
) WITH (
  format = 'ORC',
  partitioned_by = ARRAY['event_time']
);
```

Running this in Trino using the Hive connector produces the following error message.

```
Partition keys must be the last columns in the table and in the same order as the table properties: [event_time]
```

The Hive DDL is very dependent on ordering for columns and specifically 
partition columns. Partition fields must be located in the final column 
positions and in the order of partitioning in the DDL statement. The next 
statement attempts to create the same table, but now with the `event_time` field 
moved to the last column position.

```
CREATE TABLE hive.logging.events (
  level VARCHAR,
  message VARCHAR,
  call_stack ARRAY(VARCHAR),
  event_time TIMESTAMP
) WITH (
  format = 'ORC',
  partitioned_by = ARRAY['event_time']
);
```

This time, the DDL command works successfully, but you likely don’t want to
partition your data on the plain timestamp. This results in a separate file for 
each distinct timestamp value in your table (likely almost a file for each 
event). In Hive, there’s no way to indicate the time granularity at which you 
want to partition natively. The method to support this scenario with Hive is to
create a new `VARCHAR` column, `event_time_day` that is dependent on the 
`event_time` column to create the date partition value.

```
CREATE TABLE hive.logging.events (
  level VARCHAR,
  event_time TIMESTAMP,
  message VARCHAR,
  call_stack ARRAY(VARCHAR),
  event_time_day VARCHAR
) WITH (
  format = 'ORC',
  partitioned_by = ARRAY['event_time_day']
);
```

This method wastes space by adding a new column to your table. Even worse,
it puts the burden of knowledge on the user to include this new column for 
writing data. It is then necessary to use that separate column for any read 
access to take advantage of the performance gains from the partitioning.

```
INSERT INTO hive.logging.events
VALUES
(
  'ERROR',
  timestamp '2021-04-01 12:00:00.000001',
  'Oh noes', 
  ARRAY ['Exception in thread "main" java.lang.NullPointerException'], 
  '2021-04-01'
),
(
  'ERROR',
  timestamp '2021-04-02 15:55:55.555555',
  'Double oh noes',
  ARRAY ['Exception in thread "main" java.lang.NullPointerException'],
  '2021-04-02'
),
(
  'WARN', 
  timestamp '2021-04-02 00:00:11.1122222',
  'Maybeh oh noes?',
  ARRAY ['Bad things could be happening??'], 
  '2021-04-02'
);
```

Notice that the last partition value `'2021-04-01'` has to match the `TIMESTAMP` 
date during insertion. There is no validation in Hive to make sure this is 
happening because it only requires a `VARCHAR` and knows to partition based on 
different values. Likewise, if a user runs this DML statement, they get the
correct results back, but have to scan all the data in the process as they
forgot to include the `event_time_day < '2021-04-02'` predicate in the `WHERE` 
clause. This eliminates all the benefits that led us to create the partition in
the first place.

```
SELECT *
FROM hive.logging.events
WHERE event_time < timestamp '2021-04-02' 
AND event_time_day < '2021-04-02';
```

```
SELECT *
FROM hive.logging.events
WHERE event_time < timestamp '2021-04-02';
```

Result:
```
|ERROR|2021-04-01 12:00:00|Oh noes|Exception in thread "main" java.lang.NullPointerException|
```

### Iceberg Partitions 

The following DDL statement illustrates how these issues are handled in Iceberg
via the Trino Iceberg connector.

```
CREATE TABLE iceberg.logging.events (
  level VARCHAR,
  event_time TIMESTAMP(6),
  message VARCHAR,
  call_stack ARRAY(VARCHAR)
) WITH (
  partitioning = ARRAY['day(event_time)']
);
```

Taking note of a few things. First, notice the partition on the `event_time` 
column that is defined without having to move it to the last position. There 
is also no need to create a separate field to handle the daily partition on the
`event_time` field. The _**partition specification**_ is maintained internally
by Iceberg, and neither the user nor the reader of this table needs to know 
anything about the partition specification to take advantage of it. This concept
is called _**hidden partitioning**_ , where only the table creator/maintainer 
has to know the _**partitioning specification**_. Here is what the insert 
statements look like now:

```
INSERT INTO iceberg.logging.events
VALUES
(
  'ERROR',
  timestamp '2021-04-01 12:00:00.000001',
  'Oh noes', 
  ARRAY ['Exception in thread "main" java.lang.NullPointerException']
),
(
  'ERROR',
  timestamp '2021-04-02 15:55:55.555555',
  'Double oh noes',
  ARRAY ['Exception in thread "main" java.lang.NullPointerException']),
(
  'WARN', 
  timestamp '2021-04-02 00:00:11.1122222',
  'Maybeh oh noes?',
  ARRAY ['Bad things could be happening??']
);
```

The `VARCHAR` dates are no longer needed. The `event_time` field is 
internally converted to the proper partition value to partition each row. Also,
notice that the same query that ran in Hive returns the same results. The big 
difference is that it doesn’t require any extra clause to indicate to filter 
partition as well as filter the results.

```
SELECT *
FROM iceberg.logging.events
WHERE event_time < timestamp '2021-04-02';
```

Result:
```
|ERROR|2021-04-01 12:00:00|Oh noes|Exception in thread "main" java.lang.NullPointerException|
```

So hopefully that gives you a glimpse into what a table format and specification
are, and why Iceberg is such a wonderful improvement over the existing and 
outdated method of storing your data in your data lake. While this post covers
a lot of aspects of Iceberg’s capabilities, this is just the tip of the Iceberg… 

<p align="center">
 <img align="center" width="50%" height="100%" src="/assets/blog/trino-on-ice/see_myself_out.gif"/>
</p>

If you want to play around with Iceberg using Trino, check out the 
[Trino Iceberg docs](https://trino.io/docs/current/connector/iceberg.html).
The next post covers how table evolution works in Iceberg, as well as, how 
Iceberg is an improved storage format for cloud storage. 